output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.id
}

# output "public_ip" {
#   description = "The Public IP of the Virtual Machine"
#   value       = azurerm_virtual_machine.vm.public_ip_address
# }