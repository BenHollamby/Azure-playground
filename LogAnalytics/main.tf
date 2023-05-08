resource "azurerm_resource_group" "RG" {
  name     = var.rg_name
  location = var.rg_location
}

# resource for log analytics workspace
resource "azurerm_log_analytics_workspace" "LogAnalytics" {
  name                = var.la_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = var.la_sku                                  #sku and retention are optional, but are intertwined
  retention_in_days   = var.la_retention                            #retention and sku are optional, but are intertwined

  allow_resource_only_permissions = true
  local_authentication_disabled = false
  #daily_quota_gb = -1                                              #daily_quota_gb is optional but only used for reserved capacity

  depends_on = [ azurerm_resource_group.RG ]
}

#foreach log category
resource "azurerm_monitor_aad_diagnostic_setting" "example" { #does not support service principal must be connected through azure cli
  name               = var.aad_diagnostic_setting_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalytics.id
  log {
    category = "SignInLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "AuditLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "NonInteractiveUserSignInLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "ServicePrincipalSignInLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "ManagedIdentitySignInLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "RiskyUsers"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "UserRiskEvents"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "ProvisioningLogs"
    enabled  = true                 
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "ADFSSignInLogs"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "RiskyServicePrincipals"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "ServicePrincipalRiskEvents"
    enabled  = true
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
}