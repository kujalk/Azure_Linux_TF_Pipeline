resource "azurerm_linux_virtual_machine" "linux" {
  name                            = "Puppeteer-Linux"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm-size
  admin_username                  = var.admin-user
  admin_password                  = var.admin-password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_storage_container" "container" {
  name                 = var.container_name
  storage_account_name = var.storage_account_name
}

# Write role for container
resource "azurerm_role_assignment" "container" {
  scope                = data.azurerm_storage_container.container.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"

  principal_id = azurerm_linux_virtual_machine.linux.identity[0].principal_id
}