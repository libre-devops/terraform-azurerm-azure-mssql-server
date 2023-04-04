variable "add_server_to_elastic_pool" {
  type        = bool
  description = "Whether an elastic pool should be made, defaults to false"
  default     = false
}

variable "elastic_pool_license_type" {
  type        = string
  description = "The license type of a elastic pool if one is provisioned"
  default     = null
}

variable "elastic_pool_maintenance_configuration_name" {
  type        = string
  description = "The maintaence mode of the elastic pool, if one is provisoned"
  default     = null
}

variable "elastic_pool_max_size_gb" {
  type        = string
  description = "The max size in GB for the elastic pool, if one is provisioned"
  default     = null
}

variable "elastic_pool_settings" {
  type        = map(any)
  description = "The settings block for Elastic Pool"
  default     = {}
}

variable "elastic_pool_zone_redundant" {
  type        = bool
  description = "Whether or not the elastic pool is zone redundant or not, requires Premium or BusinessCritical"
  default     = null
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine."
  type        = string
  default     = ""
}

variable "location" {
  description = "The location for this resource to be put in"
  type        = string
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum TLS version of the SQL server, defaults to 1.2"
  default     = "1.2"
}

variable "outbound_network_restriction_enabled" {
  type        = bool
  description = "Whether outbound network access is restricted, defaults to false"
  default     = false
}

variable "primary_user_assigned_identity_id" {
  type        = string
  description = "The ID of User-Assigned managed identity if one is set, defaults to null"
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled on the server, default is false"
  default     = false
}

variable "rg_name" {
  description = "The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists"
  type        = string
  validation {
    condition     = length(var.rg_name) > 1 && length(var.rg_name) <= 24
    error_message = "Resource group name is not valid."
  }
}

variable "sql_admin_password" {
  type        = string
  description = "The password of the local server admin"
  sensitive   = true
}

variable "sql_admin_username" {
  type        = string
  description = "The username of the local server admin user"
  sensitive   = true
}

variable "sql_server_elastic_pool_name" {
  type        = string
  description = "The name of the SQL server pull if one is made"
  default     = null
}

variable "sql_server_name" {
  type        = string
  description = "The name of the SQL server"
}

variable "sql_server_settings" {
  type        = map(any)
  description = "The settings block for MSSQL server"
  default     = {}
}

variable "sql_server_version" {
  type        = string
  description = "The version of SQL Server to run, default is 12.0"
  default     = "12.0"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "terraform"
  }
}
