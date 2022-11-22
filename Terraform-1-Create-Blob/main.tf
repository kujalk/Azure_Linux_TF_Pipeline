resource "azurerm_resource_group" "rg" {
  name     = var.project
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.project}artifacts001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    project = var.project
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "puppeteer-artifacts"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "Puppeteer_Framework.zip"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "Puppeteer_Framework.zip"
}