resource "azurerm_virtual_network" "network" {
  name                = "puppeteer-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "puppeteer-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = "puppeteer-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "puppeteer-network-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_network_interface.nic
  ]
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}