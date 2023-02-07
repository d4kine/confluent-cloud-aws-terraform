# Confluent Cloud AWS Terraform

Terraform script to setup a Kafka Cluster with a default Schema Registry in Confluent Cloud using AWS

## Step 1: Create ConfluentCloud API-Key

1. Login to Confluent Cloud
2. Menu --> Cloud API-Keys (or here: https://confluent.cloud/settings/api-keys)
3. Click "Add key"
4. Select "Global access"
5. Create and Download key
6. Store credentials (in GitLab CI/CD-Pipeline)


## Step 2: Setup Environment Variables
```sh
export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="xxx"
export AWS_DEFAULT_REGION="eu-central-1"
export CONFLUENT_CLOUD_API_KEY="xxx"
export CONFLUENT_CLOUD_API_SECRET="xxx"
```

## Step 3: Execute Terraform

### Init
```bash
terraform init
```

### Valdidate
```bash
terraform validate
```

### Plan
```bash
terraform plan -out tfplan
terraform show -json tfplan | jq
```

### Apply
```bash
terraform apply -input=false tfplan
terraform output -json > credentials.json
```