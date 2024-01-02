terraform {
  backend "azurerm" {
    resource_group_name    = "MAK-CLOUD-MIGRATION"
    storage_account_name   = "mak2"
    container_name         = "backend"
    key                    = "prod.terraform.tfstate"
    access_key             = "z0M1MVmpGGHZhTJsb8FMAl2UomRvNdTB9RdMc/CxAI8ZBDpnP4ddA+nigAbumwsoDf+Qi3DaZOxe+AStjUnc1w=="
    
  }
}