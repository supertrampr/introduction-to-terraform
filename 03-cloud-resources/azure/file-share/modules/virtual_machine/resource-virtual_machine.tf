resource "random_password" "this" {
  count = var.enable_ssh_access ? 0 : 1

  length = 12
}

resource "tls_private_key" "this" {
  count = var.enable_ssh_access ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_public_ip" "this" {
  count = var.is_vm_public ? 1 : 0

  allocation_method   = var.public_ip_allocation_method
  location            = var.location # data.azurerm_resource_group.intro.location
  name                = "pip-vm-${var.owner}"
  resource_group_name = var.resource_group_name # data.azurerm_resource_group.intro.name
  sku                 = "Basic"
}

resource "azurerm_network_security_group" "this" {
  location            = var.location
  name                = "sg-${var.owner}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.network_security_rules

  name                         = each.key                # "allow-ssh"
  access                       = each.value["access"]    # "Allow"
  direction                    = each.value["direction"] # "Inbound"
  network_security_group_name  = azurerm_network_security_group.this.name
  priority                     = each.value["priority"] # 100
  protocol                     = each.value["protocol"] # "Tcp"
  resource_group_name          = azurerm_network_security_group.this.resource_group_name
  source_port_range            = each.value["source_port_range"]       # "*"
  destination_port_ranges      = each.value["destination_port_ranges"] # ["22"]
  source_address_prefixes      = each.value["source_address_prefixes"] # "" # ["${data.http.my_ip.response_body}/32"]
  destination_address_prefixes = azurerm_network_interface.this.private_ip_addresses
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_interface" "this" {
  location            = var.location
  name                = "nic-vm-${var.owner}"
  resource_group_name = var.resource_group_name

  dynamic "ip_configuration" {
    for_each = var.nic_ip_config
    iterator = config

    content {
      name                          = "${config.key}-config"
      private_ip_address_allocation = config.value["ip_allocation"]
      subnet_id                     = var.subnet_id # module.network["raffaele"].subnets_ids["vm"]
      primary                       = config.value["is_primary"]
      private_ip_address            = config.value["ip_address"]
      public_ip_address_id          = config.value["is_primary"] && var.is_vm_public ? azurerm_public_ip.this[0].id : null
    }

  }
}

resource "azurerm_linux_virtual_machine" "this" {
  location                        = var.location
  name                            = "vm-${var.owner}"
  resource_group_name             = var.resource_group_name
  size                            = var.size
  network_interface_ids           = concat(var.additional_nic_ids, [azurerm_network_interface.this.id])
  admin_username                  = var.admin_username
  admin_password                  = var.enable_ssh_access ? null : random_password.this[0].result
  disable_password_authentication = var.enable_ssh_access
  custom_data                     = base64encode(var.custom_data)

  dynamic "admin_ssh_key" {
    for_each = var.enable_ssh_access ? [1] : []

    content {
      public_key = tls_private_key.this[0].public_key_openssh
      username   = var.admin_username
    }
  }

  source_image_reference {
    publisher = var.os_image["publisher"]
    offer     = var.os_image["offer"]
    sku       = var.os_image["sku"]
    version   = var.os_image["version"]
  }

  os_disk {
    caching              = var.os_disk["caching"]
    storage_account_type = var.os_disk["storage_account_type"]
    disk_size_gb         = var.os_disk["disk_size_gb"]
    name                 = try(length(var.os_disk["name"]), 0) == 0 ? "os-disk-vm-${var.owner}" : var.os_disk["name"]
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      identity
    ]
  }
}