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
  log {
    category = "MicrosoftGraphActivityLogs"
    enabled  = false
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "NetworkAccessTrafficLogs"
    enabled  = false
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
  log {
    category = "EnrichedOffice365AuditLogs"
    enabled  = false
    retention_policy {
      #enabled = true
      #days    = 1
    }
  }
}

# create an action group for alerting
resource "azurerm_monitor_action_group" "ActionGroup" {
  name                = var.action_group_name
  resource_group_name = var.rg_name
  short_name          = var.action_group_short_name

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_address
    use_common_alert_schema = var.use_common_alert_schema
  }

  sms_receiver {
    name         = var.sms_receiver_name
    country_code = var.sms_country_code
    phone_number = var.sms_phone_number
  }
  depends_on = [ azurerm_resource_group.RG ]
}

#create an alert rule
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert" {
  name                = var.alert_rule_name
  resource_group_name = var.rg_name
  location            = var.rg_location

  evaluation_frequency = var.alert_rule_frequency
  window_duration      = var.alert_rule_frequency
  scopes               = [azurerm_log_analytics_workspace.LogAnalytics.id]
  severity             = var.alert_rule_severity
  criteria {
    query                   = <<-QUERY
      SigninLogs
      | where UserPrincipalName == "testben@benhollambyoutlook.onmicrosoft.com"
      QUERY
    time_aggregation_method = var.criteria_time_aggregation_method
    threshold               = var.criteria_threshold
    operator                = var.criteria_operator
    failing_periods {
      minimum_failing_periods_to_trigger_alert = var.criteria_failing_period_minimum
      number_of_evaluation_periods             = var.criteria_failing_period_number
    }
  }

  auto_mitigation_enabled          = var.auto_mitigation_enabled
  workspace_alerts_storage_enabled = var.workspace_alerts_storage_enabled
  description                      = var.alert_rule_description
  display_name                     = var.display_name
  enabled                          = var.alert_enabled
  query_time_range_override        = var.alert_rule_frequency
  skip_query_validation            = var.skip_query_validation
  action {
    action_groups = [azurerm_monitor_action_group.ActionGroup.id]
    custom_properties = {
    }
  }
  depends_on = [ azurerm_log_analytics_workspace.LogAnalytics ]
}