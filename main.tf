data "azapi_client_config" "current" {}

resource "azapi_resource" "azurerm_maintenance_configuration" {
  type      = "Microsoft.Maintenance/maintenanceConfigurations@2023-10-01-preview"
  name      = var.name
  location  = var.location
  parent_id = provider::azapi::build_resource_id("/subscriptions/${data.azapi_client_config.current.subscription_id}", "Microsoft.Resources/resourceGroups", var.resource_group_name)

  body = {
    properties = {
      extensionProperties = var.extension_properties
      installPatches = var.scope == "InGuestPatch" ? {
        linuxParameters = {
          classificationsToInclude  = var.linux_classifications_to_include
          packageNameMasksToExclude = var.linux_package_names_to_exclude
          packageNameMasksToInclude = var.linux_package_names_to_include
        }
        rebootSetting = var.reboot_setting
        windowsParameters = {
          classificationsToInclude  = var.windows_classifications_to_include
          excludeKbsRequiringReboot = var.windows_exclude_kbs_requiring_reboot
          kbNumbersToExclude        = var.windows_kb_ids_to_exclude
          kbNumbersToInclude        = var.windows_kb_ids_to_include
        }
      } : null
      maintenanceScope = var.scope
      maintenanceWindow = {
        duration           = var.duration
        expirationDateTime = var.expiration_date_time
        recurEvery         = var.recur_every
        startDateTime      = var.start_date_time
        timeZone           = var.time_zone
      }
      visibility = var.visibility
    }
  }

  tags = var.tags
}

resource "azapi_resource" "azurerm_maintenance_configuration_assignment" {
  for_each = var.resource_ids

  type = "Microsoft.Maintenance/configurationAssignments@2023-10-01-preview"
  name = basename(each.value)

  parent_id = each.value
  location  = var.location
  body = {
    properties = {
      maintenanceConfigurationId = lower(azapi_resource.azurerm_maintenance_configuration.id)
      resourceId                 = lower(each.value)
    }
  }
}

moved {
  from = azurerm_maintenance_configuration.this
  to   = azapi_resource.azurerm_maintenance_configuration
}
