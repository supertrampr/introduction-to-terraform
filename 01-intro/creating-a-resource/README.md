# Introduction

This folder contains what a simple configuration is usually setup for a [Terraform](https://terraform.io) project
with a resource `local_file` that creates a file.

## Content

In [main.tf](main.tf) inside the terraform block there are defined:
- version constraint of Terraform
- required providers if any
- backend specification (by default Terraform implies the `local` backend) 
- a resource block `local_file` that implies the usage of the [Terraform local provider](https://registry.terraform.io/providers/hashicorp/local/latest/docs) at the latest version

## Try it yourself

Run the command:

```bash
terraform init 
```

And see what happens! Terraform should create a .terraform folder containing some information about the configuration you just run and additionally a `.terraform.lock.hcl` that include version of the provider you are using.