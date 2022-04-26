variable "name" {
  type        = string
  description = "The name of the MariaDB Server. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the MariaDB Server."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "administrator_login" {
  type        = string
  description = "The Administrator Login for the MariaDB Server. Changing this forces a new resource to be created."
  default     = "sqladministrator"
}

variable "administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login for the MariaDB Server"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "mariadb_version" {
  type        = string
  description = "Specifies the version of MariaDB to use. Possible values are 10.2 and 10.3. Changing this forces a new resource to be created."
  default     = "10.3"
}

variable "storage_mb" {
  type        = number
  description = "Max storage allowed for a server. Possible values are between 5120 MB (5GB) and 1024000MB (1TB) for the Basic SKU and between 5120 MB (5GB) and 4096000 MB (4TB) for General Purpose/Memory Optimized SKUs."
  default     = 5120
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for this MariaDB Server. The name of the SKU, follows the tier + family + cores pattern (available tiers: B_Gen5_1 B_Gen5_2 GP_Gen5_2 GP_Gen5_4 GP_Gen5_8 GP_Gen5_16 GP_Gen5_32 MO_Gen5_2 MO_Gen5_4 MO_Gen5_8 MO_Gen5_16)."
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier."
  default     = null
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this server. Defaults to true."
  default     = null
}

variable "ssl_enforcement_enabled" {
  type        = bool
  description = "Specifies if SSL should be enforced on connections."
  default     = true
}

variable "mariadb_databases" {
  type        = map(map(string))
  description = "Map of maps containing config for the databases e.g. mariadb_databases = { testdb1={ database_charset = 'utf8', database_collation = 'utf8_general_ci' }, testdb2 = { database_charset = 'utf8' database_collation = 'utf8_general_ci' }}"
}