# Jenkins Jobs

Manage and monitor a single Jenkins job (freestyle, parameterized, or simple pipeline) using the REST API.

Assumes `JENKINS_URL`, `USER`, and `TOKEN` are already set. See the [Setup section in SKILL.md](../SKILL.md) for authentication and CSRF details.

---

## Trigger a Build

**No parameters:**

```bash
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/build"
```

Expect HTTP 201. The `Location` response header contains the queue item URL — capture it for polling:

```bash
QUEUE_URL=$(curl -si -X POST -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/build" \
  | grep -i "^location:" | awk '{print $2}' | tr -d '\r')
```

**With string parameters:**

```bash
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/buildWithParameters" \
  --data "PARAM1=value1&PARAM2=value2"
```

**With a file parameter:**

```bash
curl -X POST -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/buildWithParameters" \
  --form "FILE_PARAM_NAME=@/absolute/path/to/file"
```

---

## Poll Until Build Completes

After triggering, resolve the build number from the queue, then poll until `building` is `false`:

```bash
# Step 1: wait for the build to be assigned a number
until BUILD_URL=$(curl -s -u "$USER:$TOKEN" "${QUEUE_URL}api/json" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('executable',{}).get('url',''))" \
    2>/dev/null) && [ -n "$BUILD_URL" ]; do
  sleep 3
done

# Step 2: wait for the build to finish
until RESULT=$(curl -s -u "$USER:$TOKEN" "${BUILD_URL}api/json" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print('DONE' if not d['building'] else '')"); \
    [ "$RESULT" = "DONE" ]; do
  sleep 5
done
```

---

## Get Build Status

```bash
# Last build
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/lastBuild/api/json" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['number'], d['result'], d['url'])"

# Specific build number
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/$BUILD_NUMBER/api/json" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['number'], d['result'], d['duration'])"
```

Useful result values: `SUCCESS`, `FAILURE`, `UNSTABLE`, `ABORTED`, `NOT_BUILT`; `null` means still building.

**Shortcuts for last successful / last failed build:**

```bash
curl -s -u "$USER:$TOKEN" "$JENKINS_URL/job/$JOB_NAME/lastSuccessfulBuild/api/json"
curl -s -u "$USER:$TOKEN" "$JENKINS_URL/job/$JOB_NAME/lastFailedBuild/api/json"
```

---

## Get Build Logs

**Full console output:**

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/lastBuild/consoleText"
```

**Progressive (streaming) output — useful for running builds:**

```bash
START=0
while true; do
  RESPONSE=$(curl -si -u "$USER:$TOKEN" \
    "$JENKINS_URL/job/$JOB_NAME/lastBuild/logText/progressiveText?start=$START")
  echo "$RESPONSE" | sed -n '/^\r$/,$ p' | tail -n +2   # strip headers
  MORE=$(echo "$RESPONSE" | grep -i "X-More-Data:" | awk '{print $2}' | tr -d '\r')
  START=$(echo "$RESPONSE" | grep -i "X-Text-Size:" | awk '{print $2}' | tr -d '\r')
  [ "$MORE" != "true" ] && break
  sleep 2
done
```

---

## Abort a Running Build

```bash
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/$BUILD_NUMBER/stop"
```

To abort the last build: replace `$BUILD_NUMBER` with `lastBuild`.

---

## Enable / Disable a Job

```bash
# Disable
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/disable"

# Enable
curl -s -o /dev/null -w "%{http_code}" -X POST \
  -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/enable"
```

---

## Inspect the Build Queue

```bash
# Full queue
curl -s -u "$USER:$TOKEN" "$JENKINS_URL/queue/api/json" \
  | python3 -c "import sys,json; [print(i['id'], i['task']['name'], i.get('why','')) for i in json.load(sys.stdin)['items']]"

# Single queue item (from QUEUE_URL captured at trigger time)
curl -s -u "$USER:$TOKEN" "${QUEUE_URL}api/json" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('why',''), d.get('executable',{}).get('url',''))"
```

---

## Get Job Info

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/api/json" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['name'], d['color'], 'disabled' if d.get('disabled') else 'enabled')"
```

`color` reflects health: `blue` = last success, `red` = last failure, `yellow` = unstable, `grey` = not run, `_anime` suffix = currently building.

---

## List Recent Builds

```bash
curl -s -u "$USER:$TOKEN" \
  "$JENKINS_URL/job/$JOB_NAME/api/json?tree=builds[number,result,timestamp,duration]{0,10}" \
  | python3 -c "import sys,json; [print(b['number'], b['result'], b['duration']) for b in json.load(sys.stdin)['builds']]"
```

---

## The IRON LAWS

- NEVER trigger a build without confirming the correct job name and parameters with the user
- MUST use the queue item `Location` header to track build numbers — do not guess
- MUST display the final build result (SUCCESS/FAILURE/etc.) and the build URL after completion

## Workflow

1. Confirm `JOB_NAME`, parameters (if any), and desired action from the request
2. Execute the relevant operation above
3. If the user needs to wait for the build, run the poll-until-complete loop
4. Retrieve and display the build result and console output as needed

## Output

- Build number and direct URL  
- Final result: `SUCCESS`, `FAILURE`, `UNSTABLE`, `ABORTED`  
- Duration (ms → human-readable: `python3 -c "print(f'{int($DURATION/1000)}s')"`)  
- Relevant log lines on failure