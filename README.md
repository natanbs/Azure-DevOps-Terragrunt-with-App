# Terragrunt - Infrastructure

The goal of the project - to build fully declarative, scallable and reliable cloud infrastructure for AudioCodes Metering

## Prerequisites

Install on your local machine:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started)
- [AZ CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

Configure AZ CLI:

    az login
    az account list --output table
    az account set --subscription <SubscriptionId>
    az account show

## Manual deployment

Deploy all resources globally:

    terragrunt run-all plan
    terragrunt run-all apply

Deploy / change specific resource:

    cd env/region/project/instance/infra/vm
    terragrunt plan
    terragrunt apply

