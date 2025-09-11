# Introduction

This folder contains a [Terraform](https://terraform.io) configuration to deploy real infrastructure on [Google Cloud](https://cloud.google.com/?hl=en), such as:

- [Google Compute Instance](https://cloud.google.com/compute/docs/instances)
- [Google VPC](https://cloud.google.com/vpc/docs)
- [Google Cloud SQL](https://cloud.google.com/sql/docs/introduction)

_Note: this configuration will deploy real infrastructure. While we tried to create resources with little cost, to avoid unwanted cost be sure to destroy it as soon as you don't need it anymore._

## Requirements

You must have installed:

- [terraform](https://developer.hashicorp.com/terraform/install) >= 0.12.6;
- [generate a service account key](https://cloud.google.com/iam/docs/keys-create-delete) and save it in folder credentials with name `google_credentials.json`

## Getting started

Run:

```bash
terraform init
```

And then apply it with:

```bash
terraform apply
```

