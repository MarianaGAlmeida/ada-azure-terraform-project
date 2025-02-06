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
}
