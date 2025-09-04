# Introduction

This folder contains what a simple configuration is usually setup for a [Terraform](https://terraform.io) project. The project will:

- Create a file based on the value of the `course` variable specified in the .tfvars file.

## Content

In [main.tf](main.tf) inside the terraform block there are defined:
- version constraint of Terraform
- required providers if any: in this case we explicitly specified the `hashicorp/local` provider and used a version with a constraint (i.e.: will accept version that has new or older patches number).
- backend specification (by default Terraform implies the `local` backend) 
- a variable block named `course`
- a resource block `local_file` 

[terraform.tfvars] file will contain values for each variable defined in main.tf and it will be loaded automatically. Any file with extension .auto.tfvars will be loaded too and overwrite the value of the variable. Furthermore, you can use the file `prod.tfvars` by adding the flag `-var-file=prod.tfvars` when planning and applying your configuration.

## Try it yourself

Run the command:

```bash
terraform init 
```

Then:

```bash
terraform apply [-var-file]
```

To show a plan and apply it by typing 'yes'.