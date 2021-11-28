terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.86.0"
    }
  }
}

# Log into Azure; actual credentials are passed as environment variables
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "mealie" {
  name     = "Mealie-RG"
  location = "West Europe"
}

resource "azurerm_storage_account" "mealie" {
  name                     = "mealiestorageacc"
  resource_group_name      = azurerm_resource_group.mealie.name
  location                 = azurerm_resource_group.mealie.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "mealie_data" {
  name                 = "mealiedata"
  storage_account_name = azurerm_storage_account.mealie.name
  quota                = 1
}

resource "azurerm_storage_share" "mealie_db" {
  name                 = "mealiedb"
  storage_account_name = azurerm_storage_account.mealie.name
  quota                = 1
}


resource "azurerm_app_service_plan" "mealie" {
  name                = "Mealie-AppServicePlan"
  location            = azurerm_resource_group.mealie.location
  resource_group_name = azurerm_resource_group.mealie.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "mealie" {
  name                = "Mealie"
  location            = azurerm_resource_group.mealie.location
  resource_group_name = azurerm_resource_group.mealie.name
  app_service_plan_id = azurerm_app_service_plan.mealie.id
  #https_only         = true

  site_config {
    linux_fx_version = "COMPOSE|${filebase64("docker-compose.yml")}"
    # Free Tier settings
    always_on                 = false
    use_32_bit_worker_process = true
  }

  storage_account {
    name         = "MealieData"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.mealie.name
    share_name   = azurerm_storage_share.mealie_data.name
    access_key   = azurerm_storage_account.mealie.primary_access_key
  }

  storage_account {
    name         = "MealieDb"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.mealie.name
    share_name   = azurerm_storage_share.mealie_db.name
    access_key   = azurerm_storage_account.mealie.primary_access_key
  }
}
