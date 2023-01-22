## Setting a schedule

* Enable cloud scheduler API
* [Understand cron](crontab.guru)

```bash
export PROJECT_ID=...
export JOB_NAME=...
export JOB_REGION=...
export PROJECT_NUMBER=...
export SCHEDULER_JOB_NAME=python-job-name
export SCHEDULER_REGION=...
```

```bash
gcloud scheduler jobs create http ${SCHEDULER_JOB_NAME} \
  --location SCHEDULER_REGION \
  --schedule="SCHEDULE" \
  --uri="https://${JOB_REGION}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${PROJECT_ID}/jobs/${JOB_NAME}:run" \
  --http-method POST \
  --oauth-service-account-email ${PROJECT_NUMBER}-compute@developer.gserviceaccount.com
```

## Triggering via Workflows

...
