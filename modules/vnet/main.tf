# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address-space
}

# Create Azure Subnets
resource "azurerm_subnet" "pub-sub-1-a" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pub-sub-1-a"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pub_sub_1_a_prefixes
}

resource "azurerm_subnet" "pub-sub-2-b" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pub-sub-2-b"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pub_sub_2_b_prefixes
}

# create route table and add public route
resource "azurerm_route_table" "public_route_table" {
  name                = "PublicRouteTable"
  resource_group_name = var.resource_group_name
  location            = var.location

  route {
    name           = "Internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

# associate public subnet pub-sub-1-a to "public route table"
resource "azurerm_subnet_route_table_association" "pub-sub-1-a_route_table_association" {
  subnet_id      = azurerm_subnet.pub-sub-1-a.id
  route_table_id = azurerm_route_table.public_route_table.id
}

# associate public subnet pub-sub-2-b to "public route table"
resource "azurerm_subnet_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id      = azurerm_subnet.pub-sub-2-b.id
  route_table_id = azurerm_route_table.public_route_table.id
}

resource "azurerm_subnet" "pri-sub-3-a" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pri-sub-3-a"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pri_sub_3_a_prefixes
 
}

resource "azurerm_subnet" "pri-sub-4-b" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pri-sub-4-b"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pri_sub_4_b_prefixes
}

resource "azurerm_subnet" "pri-sub-5-a" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pri-sub-5-a"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pri_sub_5_a_prefixes
}

resource "azurerm_subnet" "pri-sub-6-b" {
  depends_on          = [azurerm_virtual_network.vnet]
  name                = "pri-sub-6-b"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.pri_sub_6_b_prefixes
}
