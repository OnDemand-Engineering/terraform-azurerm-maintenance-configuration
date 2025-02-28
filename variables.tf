variable "location" {
  type        = string
  description = "(Required) The Azure region where this and supporting resources should be deployed."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The resource group name of the resource group where the vm resources will be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Maintenance Configuration. Changing this forces a new resource to be created."
  nullable    = false
}

variable "scope" {
  type        = string
  description = "(Optional) The scope of the maintenance configuration."
  default     = "InGuestPatch"

  validation {
    condition     = can(regexall("Extension|Host|InGuestPatch|OSImage|Resource|SQLDB|SQLManagedInstance", var.scope))
    error_message = "The 'scope' must be one of 'Extension', 'Host', 'InGuestPatch', 'OSImage', 'Resource', 'SQLDB', or 'SQLManagedInstance'."
  }
}

variable "visibility" {
  type        = string
  description = "(Optional) The visibility of the maintenance configuration."
  default     = "Custom"

  validation {
    condition     = var.visibility == "Custom" || var.visibility == "Public"
    error_message = "The 'visibility' must be 'Custom' or 'Public'."
  }
}

variable "extensionProperties" {
  type        = map(string)
  description = "(Optional) The extension properties."
}

variable "start_date_time" {
  type        = string
  description = "(Required) Effective start date of the maintenance window in YYYY-MM-DD hh:mm format."
  nullable    = false

  validation {
    condition     = length(regexall("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}$", var.start_date_time)) > 0
    error_message = "The 'start_date_time' must be in the format 'YYYY-MM-DD hh:mm'."
  }
}

variable "expiration_date_time" {
  type        = string
  default     = null
  description = "(Optional) The expiration date and time, which can either be null or follow the format YYYY-MM-DD hh:mm."

  validation {
    condition     = can(regex("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}$", var.expiration_date_time)) || var.expiration_date_time == null
    error_message = "The value must be in the format YYYY-MM-DD hh:mm or null."
  }
}

variable "duration" {
  type        = string
  default     = "03:55"
  description = "The duration in the format H:MM, which can either be null or between 01:30 and 03:55."
}

variable "time_zone" {
  type        = string
  description = "(Optional) The time zone for the maintenance window, defaults to 'GMT Standard Time'."
  default     = "GMT Standard Time"
}

variable "recur_every" {
  type        = string
  description = "(Optional) The rate at which a maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules."
  nullable    = false
}

variable "reboot_setting" {
  type        = string
  description = "(Optional) Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed. Possible values are Always, IfRequired and Never."
  default     = "IfRequired"

  validation {
    condition     = var.reboot_setting == "Always" || var.reboot_setting == "IfRequired" || var.reboot_setting == "Never"
    error_message = "The 'reboot_setting' must be one of 'Always', 'IfRequired', or 'Never'."
  }
}

variable "windows_classifications_to_include" {
  type        = list(string)
  description = "(Optional) List of Classification category of patches to be patched. Possible values are Critical, Security, UpdateRollup, FeaturePack, ServicePack, Definition, Tools and Updates."
  default     = ["Critical", "Security"]

  validation {
    condition     = alltrue([for classification in var.windows_classifications_to_include : can(regexall("Critical|Security|UpdateRollup|FeaturePack|ServicePack|Definition|Tools|Updates", classification))])
    error_message = "Each 'windows_classifications_to_include' must be one of 'Critical', 'Security', 'UpdateRollup', 'FeaturePack', 'ServicePack', 'Definition', 'Tools', or 'Updates'."
  }
}

variable "windows_exclude_kbs_requiring_reboot" {
  type        = bool
  description = "Exclude patches which need reboot"
  default     = false
}

variable "linux_classifications_to_include" {
  type        = list(string)
  description = "(Optional) List of Classification category of patches to be patched. Possible values are Critical, Security and Other."
  default     = ["Critical", "Security"]

  validation {
    condition     = alltrue([for classification in var.linux_classifications_to_include : can(regexall("Critical|Security|Other", classification))])
    error_message = "Each 'linux_classifications_to_include' must be one of 'Critical', 'Security', or 'Other'."
  }
}

variable "windows_kb_ids_to_include" {
  type        = list(string)
  description = "(Optional) List of KB numbers to be included for patching."
  default     = []
}

variable "windows_kb_ids_to_exclude" {
  type        = list(string)
  description = "(Optional) List of KB numbers to be excluded from patching."
  default     = []
}

variable "linux_package_names_to_include" {
  type        = list(string)
  description = "(Optional) List of package names to be included for patching."
  default     = []
}

variable "linux_package_names_to_exclude" {
  type        = list(string)
  description = "(Optional) List of package names to be excluded from patching."
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Map of tags to be assigned to this resource"
}
