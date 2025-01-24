terraform {
  required_version = ">=1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.115, < 5.0.0"
    }
  }
}
