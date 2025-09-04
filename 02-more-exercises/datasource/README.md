# Introduction

This folder contains a [Terraform](https://terraform.io) configuration that use a datasource block to get information from something that is not managed by Terraform and is already existing.

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

The apply command will create some files under the [files](./files/) folder, one containing the response of the http call and one that is a result of our [files](result.txt.tftpl).
