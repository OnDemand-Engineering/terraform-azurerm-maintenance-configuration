<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.9 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 2.0.1, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.azurerm_maintenance_configuration](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_client_config.current](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_duration"></a> [duration](#input\_duration) | The duration in the format H:MM, which can either be null or between 01:30 and 03:55. | `string` | `"03:55"` | no |
| <a name="input_expiration_date_time"></a> [expiration\_date\_time](#input\_expiration\_date\_time) | (Optional) The expiration date and time, which can either be null or follow the format YYYY-MM-DD hh:mm. | `string` | `null` | no |
| <a name="input_extensionProperties"></a> [extensionProperties](#input\_extensionProperties) | (Optional) The extension properties. | `map(string)` | n/a | yes |
| <a name="input_linux_classifications_to_include"></a> [linux\_classifications\_to\_include](#input\_linux\_classifications\_to\_include) | (Optional) List of Classification category of patches to be patched. Possible values are Critical, Security and Other. | `list(string)` | <pre>[<br/>  "Critical",<br/>  "Security"<br/>]</pre> | no |
| <a name="input_linux_package_names_to_exclude"></a> [linux\_package\_names\_to\_exclude](#input\_linux\_package\_names\_to\_exclude) | (Optional) List of package names to be excluded from patching. | `list(string)` | `[]` | no |
| <a name="input_linux_package_names_to_include"></a> [linux\_package\_names\_to\_include](#input\_linux\_package\_names\_to\_include) | (Optional) List of package names to be included for patching. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where this and supporting resources should be deployed. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Maintenance Configuration. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_reboot_setting"></a> [reboot\_setting](#input\_reboot\_setting) | (Optional) Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed. Possible values are Always, IfRequired and Never. | `string` | `"IfRequired"` | no |
| <a name="input_recur_every"></a> [recur\_every](#input\_recur\_every) | (Optional) The rate at which a maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The resource group name of the resource group where the vm resources will be deployed. | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | (Optional) The scope of the maintenance configuration. | `string` | `"InGuestPatch"` | no |
| <a name="input_start_date_time"></a> [start\_date\_time](#input\_start\_date\_time) | (Required) Effective start date of the maintenance window in YYYY-MM-DD hh:mm format. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to be assigned to this resource | `map(string)` | `null` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | (Optional) The time zone for the maintenance window, defaults to 'GMT Standard Time'. | `string` | `"GMT Standard Time"` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) The visibility of the maintenance configuration. | `string` | `"Custom"` | no |
| <a name="input_windows_classifications_to_include"></a> [windows\_classifications\_to\_include](#input\_windows\_classifications\_to\_include) | (Optional) List of Classification category of patches to be patched. Possible values are Critical, Security, UpdateRollup, FeaturePack, ServicePack, Definition, Tools and Updates. | `list(string)` | <pre>[<br/>  "Critical",<br/>  "Security"<br/>]</pre> | no |
| <a name="input_windows_exclude_kbs_requiring_reboot"></a> [windows\_exclude\_kbs\_requiring\_reboot](#input\_windows\_exclude\_kbs\_requiring\_reboot) | Exclude patches which need reboot | `bool` | `false` | no |
| <a name="input_windows_kb_ids_to_exclude"></a> [windows\_kb\_ids\_to\_exclude](#input\_windows\_kb\_ids\_to\_exclude) | (Optional) List of KB numbers to be excluded from patching. | `list(string)` | `[]` | no |
| <a name="input_windows_kb_ids_to_include"></a> [windows\_kb\_ids\_to\_include](#input\_windows\_kb\_ids\_to\_include) | (Optional) List of KB numbers to be included for patching. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | Maintenance Configuration resource id. |
<!-- END_TF_DOCS -->
