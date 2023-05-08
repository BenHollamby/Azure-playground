variable "rg_name" {
  type    = string
  default = "RG_LogAnalytics"
}

variable "rg_location" {
  type    = string
  default = "australiasoutheast"
}

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

variable "aad_diagnostic_setting_name" {
  type    = string
  default = "AAD-Diagnostic-Setting-01"
}
