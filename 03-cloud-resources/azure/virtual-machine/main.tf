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

resource "random_password" "this" {
  count = var.enable_ssh_access ? 0 : 1

  length = 12
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "this" {
  filename = "${path.root}/ssh_key.pem"
  content  = tls_private_key.this.private_key_openssh
}

resource "azurerm_public_ip" "this" {
  allocation_method   = "Static"
  location            = data.azurerm_resource_group.intro.location
  name                = "pip-vm-${var.owner}"
  resource_group_name = data.azurerm_resource_group.intro.name
  sku                 = "Basic"
}

resource "azurerm_network_security_group" "this" {
  location            = data.azurerm_resource_group.intro.location
  name                = "sg-${var.owner}"
  resource_group_name = data.azurerm_resource_group.intro.name
}

resource "azurerm_network_security_rule" "this" {
  name                         = "allow-ssh"
  access                       = "Allow"
  direction                    = "Inbound"
  network_security_group_name  = azurerm_network_security_group.this.name
  priority                     = 100
  protocol                     = "Tcp"
  resource_group_name          = azurerm_network_security_group.this.resource_group_name
  source_port_range            = "*"
  destination_port_ranges      = ["22"]
  source_address_prefixes      = ["80.104.179.106/32"]
  destination_address_prefixes = azurerm_network_interface.this.private_ip_addresses
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_interface" "this" {
  location            = data.azurerm_resource_group.intro.location
  name                = "nic-vm-${var.owner}"
  resource_group_name = data.azurerm_resource_group.intro.name

  dynamic "ip_configuration" {
    for_each = var.nic_ip_config
    iterator = config

    content {
      name                          = "${config.key}-config"
      private_ip_address_allocation = config.value["ip_allocation"]
      subnet_id                     = module.network["raffaele"].subnets_ids["vm"]
      primary                       = config.value["is_primary"]
      private_ip_address            = config.value["ip_address"]
      public_ip_address_id          = config.value["is_primary"] ? azurerm_public_ip.this.id : null
    }

  }
}

resource "azurerm_linux_virtual_machine" "this" {
  location                        = data.azurerm_resource_group.intro.location
  name                            = "vm-${var.owner}"
  resource_group_name             = data.azurerm_resource_group.intro.name
  size                            = "Standard_B1ls"
  network_interface_ids           = concat(var.additional_nic_ids, [azurerm_network_interface.this.id])
  admin_username                  = var.admin_username # "adminuser"
  admin_password                  = var.enable_ssh_access ? null : random_password.this[0].result
  disable_password_authentication = var.enable_ssh_access

  dynamic "admin_ssh_key" {
    for_each = var.enable_ssh_access ? [1] : []

    content {
      public_key = tls_private_key.this.public_key_openssh
      username   = var.admin_username
    }
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "None"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 32
    name                 = "os-disk-vm-${var.owner}"
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      identity
    ]
  }
}