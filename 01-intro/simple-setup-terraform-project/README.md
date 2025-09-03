# Introduction

This folder contains what a simple configuration is usually setup for a [Terraform](https://terraform.io) project.

## Content

In [main.tf](main.tf) inside the terraform block there are defined:
- version constraint of Terraform
- required providers if any
- backend specification (by default Terraform implies the `local` backend) 

## Try it yourself

Run the command:

```bash
terraform init 
```

And see what happens! Terraform should create a .terraform folder containing some information about the configuration you just run.