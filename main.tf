# # maintenance configurations
# resource "azurerm_maintenance_configuration" "this" {

#   name                = var.name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   scope               = var.scope
#   visibility          = var.visibility

#   in_guest_user_patch_mode = var.in_guest_user_patch_mode

#   window {
#     start_date_time      = var.start_date_time
#     expiration_date_time = var.expiration_date_time
#     duration             = var.duration
#     time_zone            = var.time_zone
#     recur_every          = var.recur_every
#   }

#   install_patches {
#     reboot = var.reboot_setting
#     windows {
#       classifications_to_include = var.windows_classifications_to_include
#       kb_numbers_to_include      = var.windows_kb_ids_to_include
#       kb_numbers_to_exclude      = var.windows_kb_ids_to_exclude

#     }
#     linux {
#       classifications_to_include    = var.linux_classifications_to_include
#       package_names_mask_to_include = var.linux_package_names_to_include
#       package_names_mask_to_exclude = var.linux_package_names_to_exclude
#     }
#   }

#   tags = var.tags
# }

data "azapi_client_config" "current" {}

resource "azapi_resource" "azurerm_maintenance_configuration" {
  type      = "Microsoft.Maintenance/maintenanceConfigurations@2023-10-01-preview"
  name      = var.name
  location  = var.location
  parent_id = provider::azapi::build_resource_id("/subscriptions/${data.azapi_client_config.current.subscription_id}", "Microsoft.Resources/resourceGroups", var.resource_group_name)

  body = {
    properties = {
      installPatches = {
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
      }
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
