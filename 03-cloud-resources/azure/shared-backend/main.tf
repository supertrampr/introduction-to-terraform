data "azurerm_resource_group" "intro" {
  name = local.resource_group_name
}

module "network" {
  source = "github.com/supertrampr/introduction-to-terraform/03-cloud-resources/azure/file-share/modules/network"

  for_each = var.network_topology

  owner               = each.key
  vnet_address_space  = each.value["vnet_address_space"]
  subnets             = each.value["subnets"]
  location            = data.azurerm_resource_group.intro.location
  resource_group_name = data.azurerm_resource_group.intro.name
}

module "virtual_machine" {
  source = "github.com/supertrampr/introduction-to-terraform/03-cloud-resources/azure/file-share/modules/virtual_machine"

  location                    = data.azurerm_resource_group.intro.location
  resource_group_name         = data.azurerm_resource_group.intro.name
  subnet_id                   = module.network["raffaele"].subnets_ids["vm"]
  size                        = "Standard_B1ms"
  owner                       = var.owner
  enable_ssh_access           = var.enable_ssh_access
  public_ip_allocation_method = "Static"
  network_security_rules = {
    "allow-ssh" = {
      access                  = "Allow"
      direction               = "Inbound"
      priority                = 100
      protocol                = "Tcp"
      source_port_range       = "*"
      destination_port_ranges = ["22"]
      source_address_prefixes = ["${data.http.my_ip.response_body}/32"]
    }
  }
  nic_ip_config = {
    "dynamic" = {
      is_primary = true
    }
    "static" = {
      ip_allocation = "Static"
      ip_address    = "192.168.1.120"
    }
  }
  custom_data = <<EOT
#!/bin/bash

sudo apt-get update
sudo apt-get install -y mysql-client
EOT
}

resource "local_file" "this" {
  filename        = "${path.root}/ssh_key.pem"
  content         = module.virtual_machine.ssh_private_key
  file_permission = "0400"
} 