terraform {
  required_providers {
    azurerm = {
      # The "hashicorp" namespace is the new home for the HashiCorp-maintained
      # provider plugins.
      #
      # source is not required for the hashicorp/* namespace as a measure of
      # backward compatibility for commonly-used providers, but recommended for
      # explicitness.
      source  = "hashicorp/azurerm"
      version = "~> 2.36"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                = "${var.prefix}storageacct"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  access_tier               = "Hot"
  allow_blob_public_access  = true
}

resource "azurerm_storage_container" "example" {
  name                  = "${var.prefix}storagecontainer"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "blob"
}

resource "azurerm_storage_account" "example2" {
  name                = "${var.prefix}storageacct2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  access_tier               = "Hot"
  allow_blob_public_access  = true
}

resource "azurerm_storage_container" "example2" {
  name                  = "${var.prefix}storagecontainer2"
  storage_account_name  = azurerm_storage_account.example2.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "example3" {
  name                  = "${var.prefix}storagecontainer3"
  storage_account_name  = azurerm_storage_account.example2.name
  container_access_type = "blob"
}
