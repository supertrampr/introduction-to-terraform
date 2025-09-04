data "azurerm_resource_group" "intro" {
  name = local.resource_group_name
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${lower(var.owner)}"
  location            = data.azurerm_resource_group.intro.location
  resource_group_name = data.azurerm_resource_group.intro.name
  address_space       = var.vnet_address_space

  tags = merge(local.tags, 
    {
      "tobedestroyed" = "true"
    }
  )
}