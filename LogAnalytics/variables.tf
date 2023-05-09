# Resource Group Variables
variable "rg_name" {
  type    = string
  default = "RG_LogAnalytics"
}
variable "rg_location" {
  type    = string
  default = "australiasoutheast"
}

# Log Analytics Variables
variable "la_name" {
  type    = string
  default = "AzureAD-LA"
}
variable "la_sku" {
  type    = string
  default = "PerGB2018"
}
variable "la_retention" {
  type    = number
  default = 30
}

# Diagnostic Settings Variables
variable "aad_diagnostic_setting_name" {
  type    = string
  default = "AAD-Diagnostic-Setting-01"
}

# Action Group Variables
variable "action_group_name" {
  type    = string
  default = "Break-Glass-Account-AG"
}
variable "action_group_short_name" {
  type    = string
  default = "Brk-gls-used"
}
variable "email_receiver_name" {
  type    = string
  default = "email-alert-sigil"
}
variable "email_address" {
  type    = string
  default = "ben.hollamby@arkahna.io"
}
variable "sms_receiver_name" {
  type    = string
  default = "on-call-msg"
}
variable "sms_country_code" {
  type    = string
  default = "64"
}
variable "sms_phone_number" {
  type    = string
  default = "21916031"
}
variable "use_common_alert_schema" {
  type    = bool
  default = true
}

# Alert Rule Variables
variable "alert_rule_name" {
  type    = string
  default = "Break-Glass-Account-Alert"
}
variable "alert_rule_frequency" {
  type    = string
  default = "PT5M"
}
variable "alert_rule_severity" {
  type    = number
  default = 0
}
variable "criteria_time_aggregation_method" {
  type    = string
  default = "Count"
}
variable "criteria_threshold" {
  type    = number
  default = 0
}
variable "criteria_operator" {
  type    = string
  default = "GreaterThan"
}
variable "criteria_failing_period_minimum" {
  type    = number
  default = 1
}
variable "criteria_failing_period_number" {
  type    = number
  default = 1
}
variable "auto_mitigation_enabled" {
  type    = bool
  default = true
}
variable "workspace_alerts_storage_enabled" {
  type    = bool
  default = false
}
variable "alert_rule_description" {
  type    = string
  default = "This alert is triggered when a break glass account is used"
}
variable "display_name" {
  type    = string
  default = "Break-Glass-Account-Alert"
}
variable "alert_enabled" {
  type    = bool
  default = true
}
variable "skip_query_validation" {
  type    = bool
  default = true
}

