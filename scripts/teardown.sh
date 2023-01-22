echo "Deleting $PROD_GCP_PROJECT_ID (prod) and $DEV_GCP_PROJECT_ID (dev) Jobs if they exist"
gcloud beta run jobs delete $JOB_NAME --project=$DEV_GCP_PROJECT_ID --region=$DEV_GCP_REGION
gcloud beta run jobs delete $JOB_NAME --project=$PROD_GCP_PROJECT_ID --region=$PROD_GCP_REGION
