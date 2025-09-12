# Introduction

This folder contains a [Terraform](https://terraform.io) configuration to deploy real infrastructure on Azure, such as:

- [Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)

## Requirements

You must have installed:

- [terraform](https://developer.hashicorp.com/terraform/install) >= 0.12.6;
- [azure cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) >= 2.74.0;

## Getting started

Run:

```bash
terraform init
```

And then apply it with:

```bash
terraform apply
```

## CI 

This example can be applied using GitHub actions, they will run if:
- A push has been made on main branch (this will auto-approve the configuration)
- Pull request to `main` branch: this will show you just the plan and then after merging the pull request it will trigger an apply