# Introduction

This folder contains a [Terraform](https://terraform.io) configuration that demonstrate how to use for_each meta-argument to create multiple instance of the same resource.

## Requirements

You must have installed:

- [terraform]() >= 0.12.6;

## Getting started

Run:

```bash
terraform init
```

And then apply it with:

```bash
terraform apply
```

The apply command will create three files under the [files](./files/) folder. Try to move an element of the `courses` variable in [terraform.tfvars](terraform.tfvars) file and see if the behaviour is the same as the count loop.

