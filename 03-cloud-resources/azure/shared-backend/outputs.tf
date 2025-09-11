output "how_to_connect" {
  description = "Info on how to connect to vm via ssh"
  value       = <<EOT
You have deployed your first vm! Connect to it using:

  ssh -i ${local_file.this.filename} ${module.virtual_machine.admin_username}@${module.virtual_machine.vm_public_ip} 
EOT
}

output "vm_public_ip" {
  description = "Virtual machine public ip."
  value       = module.virtual_machine.vm_public_ip
}