# maintenance configurations
resource "azurerm_maintenance_configuration" "this" {

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  scope               = var.scope
  visibility          = var.visibility

  in_guest_user_patch_mode = var.in_guest_user_patch_mode

  window {
    start_date_time      = var.start_date_time
    expiration_date_time = var.expiration_date_time
    duration             = var.duration
    time_zone            = var.time_zone
    recur_every          = var.recur_every
  }

  install_patches {
    reboot = var.reboot_setting
    windows {
      classifications_to_include = var.windows_classifications_to_include
      kb_numbers_to_include      = var.windows_kb_ids_to_include
      kb_numbers_to_exclude      = var.windows_kb_ids_to_exclude

    }
    linux {
      classifications_to_include    = var.linux_classifications_to_include
      package_names_mask_to_include = var.linux_package_names_to_include
      package_names_mask_to_exclude = var.linux_package_names_to_exclude
    }
  }

  tags = var.tags
}
