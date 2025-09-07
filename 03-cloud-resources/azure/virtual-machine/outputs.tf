# output "vnet_name" {
#   description = "Virtual network name."
#   value       = module.network.vnet_name
# }

# output "subnets_name" {
#   description = "Subnetwork name."
#   value       = module.network.subnets_name
# }

output "how_to_connect" {
  description = "Info on how to connect to vm via ssh"
  value       = <<EOT
You have deployed your first vm! Connect to it using:

  ssh -i ${local_file.this.filename} ${azurerm_linux_virtual_machine.this.admin_username}@${azurerm_public_ip.this.ip_address} 
EOT
}