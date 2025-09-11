module "network" {
  source = "./modules/network"

  owner                   = "raffaele"
  auto_create_subnetworks = false
  subnetworks = {
    "vm" = {
      ip_cidr_range = "192.168.1.0/24"
    }
  }
}

module "service_connection" {
  source = "./modules/service_private_access"

  prefix_length       = 24
  vpc_id              = module.network.vpc_id
  global_address_name = "${module.network.vpc_name}-ip-range"
}

resource "random_password" "sql_default_user" {
  length           = 12
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!_."
}

module "database" {
  source = "./modules/database"

  depends_on = [
    module.service_connection
  ]

  owner                 = "raffaele"
  default_user_password = random_password.sql_default_user.result
  vpc_self_link         = module.network.vpc_self_link
  authorized_networks = try(data.terraform_remote_state.azure.outputs.vm_public_ip, 0) > 0 ?{
    "azure_vm" = data.terraform_remote_state.azure.outputs.vm_public_ip
  } : {}
  databases = {
    "dev" = {

    }
    "stg" = {
      charset   = "utf8mb4"
      collation = "utf8mb4_general_ci"
    }
  }
}

module "vm" {
  source = "./modules/compute_instance"

  owner                = "raffaele"
  subnetwork_self_link = module.network.subnets_self_link["vm"]
}

resource "local_file" "this" {
  filename        = "${path.root}/ssh_key.pem"
  content         = module.vm.ssh_private_key
  file_permission = "0400"
}