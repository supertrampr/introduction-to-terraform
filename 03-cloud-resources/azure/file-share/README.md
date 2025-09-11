# Introduction

This folder contains a [Terraform](https://terraform.io) configuration to deploy real infrastructure on Azure, such as:

- [Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Machine](https://learn.microsoft.com/en-us/azure/virtual-machines/overview)

It will then configure the virtual machine by running a script that mount a fileshare created with terraform.

_Note: this configuration will deploy real infrastructure. While we tried to create resources with little cost, to avoid unwanted cost be sure to destroy it as soon as you don't need it anymore._

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

