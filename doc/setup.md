# CI/CD setup with Google Cloud Run and GitHub Actions

## Pre-requisites

* Enable Google Cloud Container Registry API
* Enable Google Cloud IAM Service Account API
* `gcloud` installed and updated

## How it works

### Service account keys

### Workload identity federation

### GitHub Actions

## Generating your Google credentials

### 1 - Create a Service Account

* IAM & Admin
* Service Accounts
* Create Service Account
* IAM Role -> Google Cloud Run Developer, Storage Admin, Cloud Run Service Agent

### 2 - Set required local environment variables

* `REPO_NAME`
* `REPO_OWNER`
* `PROJECT_ID`
* `SERVICE_ACCOUNT`
* `SERVICE_NAME`
* `POOL_NAME` (`github-actions`)

### 3 - Create a new Workload Identity Provider

#### 3.1 Create a new Workload Identity Pool

The first thing you'll need to do is create a new Workload Identity Pool to associate 
your Workload Identity Provider with. You only need to create an Identity Pool once so
if you end up configuring multiple GitHub Actions you can skip this step in future.

To generate the pool, simply run:

```bash
gcloud iam workload-identity-pools create ${POOL_NAME} \
  --location=global \
  --project=${PROJECT_ID} \
  --display-name='Github Actions'
```

Now set `WORKLOAD_IDENDITY_POOL_ID` by running:

```bash
export WORKLOAD_IDENTITY_POOL_ID=$(gcloud iam workload-identity-pools describe "github-actions" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --format="value(name)")
```

### 3.2 Create a new Workload Identity Provider

You now need to associate a Workload Identity Provider with your newly created pool
(and the service you're going to deploy). To do this, you can run:

```bash
gcloud iam workload-identity-pools providers create-oidc "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-actions" \
  --display-name="GitHub Actions provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.aud=assertion.aud" \
  --issuer-uri="https://token.actions.githubusercontent.com"
```

You can then get access to your newly created Workload Identity Provider's name by 
running the following command:

```bash
gcloud iam workload-identity-pools providers describe "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-actions" \
  --format="value(name)"
  ```

## 4 - Update IAM Roles 

Finally for this section, you'll need to configure your Service Account's IAM Roles to 
include the Workload Identity Pool you created earlier. You can do this simply enough 
using this command:

```bash
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO_ORG}/${REPO_NAME}"
```

# Configure GitHub Action

## 1 - Set GitHub Action Secrets

* `PROJECT_ID`
* `SERVICE_ACCOUNT`
* `WORKLOAD_IDENTITY_PROVIDER`
* `REGION` (optional) - can be set directly in your workflow

Note: if you plan on configuring CI/CD for both development and production environments, 
you'll want to make sure you're de-conflicting your secrets. For example, consider using
`DEV_SERVICE_ACCOUNT` and `PROD_SERVICE_ACCOUNT` to explicitly indicate the credentials 
to be used in each context. You will need to generate credentials for each environment 
you are targeting. Additionally, if you expect to use multiple tools or platforms with 
GitHub Actions, it may be worth going further and using `GCP_PROD_SERVICE_ACCOUNT` to 
further de-conflict your configuration. For a simple setup as described here, you need 
not worry about this, though!

## 2 - Create Workflow

{Provided example}

# Next steps