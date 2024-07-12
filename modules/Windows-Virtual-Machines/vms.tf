resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination = true


    
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
  }

  # os_profile_linux_config {
  #   disable_password_authentication = false
  # }

  identity {
    type = "SystemAssigned"
  }
}
