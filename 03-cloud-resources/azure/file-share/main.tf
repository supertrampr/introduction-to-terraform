data "azurerm_resource_group" "intro" {
  name = local.resource_group_name
}

module "network" {
  source = "./modules/network"

  for_each = var.network_topology

  owner               = each.key
  vnet_address_space  = each.value["vnet_address_space"]
  subnets             = each.value["subnets"]
  location            = data.azurerm_resource_group.intro.location
  resource_group_name = data.azurerm_resource_group.intro.name
}

module "virtual_machine" {
  source = "./modules/virtual_machine"

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
  custom_data = templatefile("${path.root}/scripts/mount_file_share.sh", {
    sp_client_id         = var.sp_mount_file_share_client_id
    sp_client_secret     = var.sp_mount_file_share_client_secret
    tenant_id            = var.tenant_id
    resource_group_name  = data.azurerm_storage_account.this.resource_group_name
    storage_account_name = data.azurerm_storage_account.this.name
    file_share_name      = azurerm_storage_share.this.name
  })
}