# google-cloud-run-python-job

This repository provides a template to quickly get a Cloud Run Job tested and deployed
with a GitHub Actions powered CI/CD pipeline in minutes.

## What are Cloud Run Jobs?

Cloud Run is a fully managed platform for deploying containerised applications rapidly
and scalably. Cloud Run traditionally focused on the deployment and management of web
applications - these are Cloud Run Services.

At the time of writing, Cloud Run Jobs have been released into preview. In this mode,
Cloud Run offers an easy-to use batch processing platform. These batch processes have
a range of features that allow them to be triggered as part of a Google Workflow, on
a schedule, or manually via the `gcloud` tool or Google Cloud Console. Even better, you
only pay for what you use! This makes Cloud Run Jobs a great way of deploying batch
processing jobs in a simple, cost-effective way!

This repository provides a skeleton for getting a Google Cloud Job deployed fast!

## Using this template

To configure GitHub Actions to manage the deployment you will need to follow the [setup
guide](doc/setup.md) to generate Google Cloud Workload Identity Federation credentials
and to provide the required secrets via GitHub, too.
