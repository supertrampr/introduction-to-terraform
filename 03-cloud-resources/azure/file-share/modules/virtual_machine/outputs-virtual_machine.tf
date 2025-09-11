output "ssh_private_key" {
  description = "Private key content."
  value       = var.enable_ssh_access ? tls_private_key.this[0].private_key_openssh : null
}

output "vm_public_ip" {
  description = "Virtual machine public ip."
  value       = var.is_vm_public ? azurerm_public_ip.this[0].ip_address : null
}

output "admin_username" {
  description = "Admin username of the vm."
  value       = azurerm_linux_virtual_machine.this.admin_username
}