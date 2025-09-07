resource "azurerm_virtual_network" "this" {
  name                = "vnet-${lower(var.owner)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = merge(local.tags,
    {
      "tobedestroyed" = "true"
    }
  )
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = "subnet-${each.key}"
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}