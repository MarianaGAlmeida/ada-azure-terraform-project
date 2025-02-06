# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "22bd58d1-2be1-492f-8075-6c596290a789"  
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "projeto_rg" {
  name     = "rg-spd10-tst-brs"
  location = "Brazil South"
 
}


resource "azurerm_kubernetes_cluster" "cluster-aks" {
name = "cluster-aks1"
location = azurerm_resource_group.projeto_rg.location
resource_group_name = azurerm_resource_group.projeto_rg.name
dns_prefix = "projetoakscluster"

default_node_pool {
name = "default"
node_count = 1
vm_size = "Standard_D2_v2"
}

identity {
type = "SystemAssigned"
}

tags = {
Environment = "Production"
}

output "kube_config" {
value = azurerm_kubernetes_cluster.example.kube_config_raw
sensitive = true
}

*/
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "vnet-spd8-dev-brs-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["${var.virtual_network}"]
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "vnet-spd"
  location            = azurerm_resource_group.projeto_rg.location
  resource_group_name = azurerm_resource_group.projeto_rg.name
  address_space       = ["${var.virtual_network}"]
}

resource "azurerm_subnet" "cluster_resources" {
  name                 = "cluster-resources"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.environment_rg.name
  address_prefixes     = ["${var.subnet_network}"]

  depends_on = [ azurerm_virtual_network.virtual_network ]
}

*/
