# Jenkins Pipelines

Manage and monitor Jenkins Pipeline jobs (Declarative/Scripted) and Multibranch Pipelines using the REST API. Covers triggering runs, inspecting stages, streaming logs, and scanning branches.

Assumes `JENKINS_URL`, `USER`, and `TOKEN` are already set. See the [Setup section in SKILL.md](../SKILL.md) for authentication and CSRF details.

---

## Trigger a Pipeline Run

**No parameters:**

```bash
QUEUE_URL=$(curl -si -X POST -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/build" \
  | grep -i "^location:" | awk '{print $2}' | tr -d '\r')
```

**With parameters:**

```bash
QUEUE_URL=$(curl -si -X POST -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/buildWithParameters" \
  --data "BRANCH=main&DEPLOY_ENV=staging" \
  | grep -i "^location:" | awk '{print $2}' | tr -d '\r')
```

Expect HTTP 201. Capture `QUEUE_URL` — use it to resolve the build number.

---

## Resolve Build Number from Queue

```bash
until BUILD_URL=$(curl -s -u "$USER:$TOKEN" "${QUEUE_URL}api/json" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('executable',{}).get('url',''))" \
    2>/dev/null) && [ -n "$BUILD_URL" ]; do
  sleep 3
done
BUILD_NUMBER=$(basename "${BUILD_URL%/}")
echo "Build #$BUILD_NUMBER → $BUILD_URL"
```

---

## Poll Until Pipeline Completes

```bash
until RESULT=$(curl -s -u "$USER:$TOKEN" "${BUILD_URL}api/json" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); \
      print(d['result'] if not d['building'] else '')") \
    && [ -n "$RESULT" ]; do
  sleep 5
done
echo "Pipeline finished: $RESULT"
```

`RESULT` will be one of: `SUCCESS`, `FAILURE`, `UNSTABLE`, `ABORTED`.

---

## Get Pipeline Run Status

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/lastBuild/api/json" \
  | python3 -c "
import sys, json
d = json.load(sys.stdin)
print('Number:', d['number'])
print('Result:', d['result'])
print('Building:', d['building'])
print('URL:', d['url'])
"
```

---

## Get Stage Overview (Pipeline Stage View)

Requires the **Pipeline: Stage View** plugin (`workflow-aggregator`).

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/wfapi/describe" \
  | python3 -c "
import sys, json
d = json.load(sys.stdin)
for s in d.get('stages', []):
    print(s['name'], s['status'], f\"{s['durationMillis']}ms\")
"
```

Stage `status` values: `SUCCESS`, `FAILED`, `IN_PROGRESS`, `PAUSED`, `SKIPPED`, `NOT_EXECUTED`.

---

## Get Logs for a Specific Stage

First, retrieve the stage node ID from the stage overview, then fetch its log:

```bash
# List stages with their IDs
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/wfapi/describe" \
  | python3 -c "
import sys, json
for s in json.load(sys.stdin).get('stages', []):
    print(s['id'], s['name'], s['status'])
"

# Fetch log for a stage node
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/execution/node/$NODE_ID/wfapi/log" \
  | python3 -c "import sys,json; print(json.load(sys.stdin).get('text',''))"
```

---

## Get Full Console Log

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/consoleText"
```

**Progressive (streaming) log — for a running build:**

```bash
START=0
while true; do
  RESPONSE=$(curl -si -u "$USER:$TOKEN" \
    "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/logText/progressiveText?start=$START")
  echo "$RESPONSE" | sed -n '/^\r$/,$ p' | tail -n +2
  MORE=$(echo "$RESPONSE" | grep -i "X-More-Data:" | awk '{print $2}' | tr -d '\r')
  START=$(echo "$RESPONSE" | grep -i "X-Text-Size:" | awk '{print $2}' | tr -d '\r')
  [ "$MORE" != "true" ] && break
  sleep 2
done
```

---

## Abort a Running Pipeline

```bash
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/$BUILD_NUMBER/stop"
```

---

## Multibranch Pipeline: Scan for New Branches

Triggering a scan causes Jenkins to detect new or deleted branches and create/remove branch jobs automatically:

```bash
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$MULTIBRANCH_NAME/build"
```

---

## Multibranch Pipeline: List Branches

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$MULTIBRANCH_NAME/api/json?depth=1" \
  | python3 -c "
import sys, json
for j in json.load(sys.stdin).get('jobs', []):
    print(j['name'], j['color'])
"
```

---

## Multibranch Pipeline: Trigger a Specific Branch

```bash
BRANCH_NAME="feature%2Fmy-feature"   # URL-encode slashes: / → %2F
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$MULTIBRANCH_NAME/job/$BRANCH_NAME/build"
```

---

## List Recent Pipeline Runs

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$PIPELINE_NAME/api/json?tree=builds[number,result,timestamp,duration,building]{0,10}" \
  | python3 -c "
import sys, json
for b in json.load(sys.stdin).get('builds', []):
    status = 'RUNNING' if b['building'] else b.get('result', '?')
    print(b['number'], status, f\"{b['duration'] // 1000}s\")
"
```

---

## The IRON LAWS

- MUST resolve the build number from the queue `Location` header — never guess a build number
- MUST use the `wfapi/describe` endpoint (not the generic API) for stage-level detail
- MUST URL-encode branch names containing `/` as `%2F` when used in job paths
- MUST display the final result, build URL, and failed stage name (if any) in the output

## Workflow

1. Confirm `PIPELINE_NAME` (and `BRANCH_NAME` / `BUILD_NUMBER` if needed) from the request
2. Trigger the run and capture `QUEUE_URL`
3. Resolve `BUILD_URL` and `BUILD_NUMBER` from the queue
4. If waiting is needed, run the poll-until-complete loop
5. Retrieve stage overview and logs for any failed stage
6. Report the final result, duration, and build URL

## Output

- Build number and direct URL  
- Final result: `SUCCESS`, `FAILURE`, `UNSTABLE`, `ABORTED`  
- Stage summary table (name, status, duration) when relevant  
- Failed stage name and its log excerpt on failure