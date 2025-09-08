output "vnet_name" {
  description = "Virtual network name."
  value       = azurerm_virtual_network.this.name
}

output "subnets_name" {
  description = "Subnetwork name."
  value = { for k, v in azurerm_subnet.this : k => {
    name = v.name
  } }
}

output "subnets_ids" {
  description = "Subnets ids."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}