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

/*
// User Assigned Identity

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
resource "azurerm_user_assigned_identity" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
}



provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}







//Key Vault ///////////////////////////////////////////////////////

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}









//Key Vault Certificate//////////////////////////////////////////////////////////////////////////

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_certificates_on_destroy = true
      recover_soft_deleted_certificates          = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_key_vault" "example" {
  name                = "examplekeyvault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
    ]

    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }
}

resource "azurerm_key_vault_certificate" "example" {
  name         = "imported-cert"
  key_vault_id = azurerm_key_vault.example.id

  certificate {
    contents = filebase64("certificate-to-import.pfx")
    password = ""
  }
}











/*
tags = {
Environment = "Production"
}

output "kube_config" {
value = azurerm_kubernetes_cluster.example.kube_config_raw
sensitive = true
}
/*



/*
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

/*
*/
