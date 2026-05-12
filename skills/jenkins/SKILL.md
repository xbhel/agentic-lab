---
name: jenkins
description: Manage and monitor Jenkins jobs and pipelines via the Jenkins REST API. Use this when the request involves Jenkins CI/CD operation such as builds, pipeline runs, status checks, and log retrieval, including when Jenkins-related context is implied (e.g., Jenkinsfile or CI pipeline).
argument-hint: Jenkins action to perform (e.g., trigger build, check status, get logs, abort)
metadata:
  version: 1.1.0
  author: xbhel
---

# Jenkins

## Goal

Execute Jenkins job and pipeline management operations reliably using the Jenkins REST API via `curl`, providing full visibility into build execution and CI/CD workflows.

## Setup

Before running any command, resolve these values from the user's request or environment:

| Variable | Description | Example |
| --- | --- | --- |
| `JENKINS_URL` | Base URL of the Jenkins instance (no trailing slash) | `https://ci.example.com` |
| `USER` | Jenkins username | `admin` |
| `TOKEN` | Jenkins API token (preferred over password) | `11abc...` |

**Authentication** — always pass credentials via `-u USER:TOKEN`. API tokens are preferred over passwords; obtain one at `JENKINS_URL/user/USER/configure`.

**CSRF crumb** — most modern Jenkins instances with API token auth do not require a crumb. If a POST returns HTTP 403, fetch a crumb and include it:

```bash
CRUMB=$(curl -s -u "$USER:$TOKEN" "$JENKINS_URL/crumbIssuer/api/json" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['crumbRequestField']+':'+d['crumb'])")
# Then add  -H "$CRUMB"  to every POST request
```

**Verify connectivity:**

```bash
curl -sI -u "$USER:$TOKEN" "$JENKINS_URL" | grep -i x-jenkins
```

## Action References

Select the reference that best matches the request:

| Reference | Use when | Covers |
| --- | --- | --- |
| [jobs.md](./references/jobs.md) | operating a single freestyle or parameterized job | trigger, status, logs, abort, enable/disable, queue |
| [pipelines.md](./references/pipelines.md) | operating a Pipeline or Multibranch Pipeline | pipeline runs, stage view, stage logs, branch scanning |

## The IRON LAWS

- MUST read the selected reference before executing any action
- NEVER expose credentials in output; use environment variables (`$USER`, `$TOKEN`) in all shown commands
- MUST poll the build status instead of sleeping when waiting for a build to complete
- MUST report the HTTP status code and response body when a request fails

## Workflow

1. Identify the Jenkins URL, credentials, and target job/pipeline name from the request or context
2. Select the matching reference from Action References above
3. Read the reference and resolve any required inputs
4. Execute the operation following the reference workflow
5. Report the result clearly — build number, status, URL, and any relevant output
