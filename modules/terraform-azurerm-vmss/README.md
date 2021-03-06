## terraform-azurerm-vmss
Terraform module to create a Azure virutal machine scale sets for windows as well as Linux

## Description
Azure virtual machine scale sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.
Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.
 You can deploy a windows vm scaleset or linux vm scaleset using below module
You can deploy vm scale sets behind a load balancer or without load blancer also
If you would like to deploy the vm scale set behind a load blancer, load balancer should exist already and you should pass load balancer backend pool and optionally load balancer nat pool
Various options have been parametersied and optional for example : data disks, automatic\_os\_upgrade\_policy, rolling\_upgrade\_policy, automatic instance repair etc
## Dependencies
Virtual Network and Subnet
Network Security Group
## Module example use
```hcl
windows example
module "vmss_win" {
 source = "../../modules/terraform-azurerm-vmss"
 resource_group_name  = azurerm_resource_group.main.name
 location             = azurerm_resource_group.main.location
 subnet_id            = data.azurerm_subnet.snet.id
 vmscaleset_name      = module.naming.vm_scaleset.name
 tags = var.tags
 os_flavor                 = "windows"
 windows_distribution_name = "windows2019dc"
 virtual_machine_size      = "Standard_A2_v2"
 computer_name_prefix      = "atosvm"
 admin_username            = "azureadmin"
 admin_password            = "P@$$w0rd1234!"
 instances_count           = 2
 existing_network_security_group_id = azurerm_network_security_group.main.id
 load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.main.id]  
 # Enable Auto scaling feature for VM scaleset by set argument to true.
 # Instances_count in VMSS will become default and minimum instance count.
 # Automatically scale out the number of VM instances based on CPU Average only.    
 enable_autoscale_for_vmss          = true
 minimum_instances_count            = 2
 maximum_instances_count            = 5
 scale_out_cpu_percentage_threshold = 80
 scale_in_cpu_percentage_threshold  = 20

*}

*Linux examples
*module "vmss_linux" {
 source              = "../../modules/terraform-azurerm-vmss"
 resource_group_name = azurerm_resource_group.main.name
 location            = azurerm_resource_group.main.location
 subnet_id           = data.azurerm_subnet.snet.id
 vmscaleset_name     = module.naming.vm_scaleset.name
 tags                = var.tags

 os_flavor                              = "linux"
 linux_distribution_name                = "ubuntu1804"
 virtual_machine_size                   = "Standard_A2_v2"
 admin_username                         = "azureadmin"
 admin_password                         = "P@$$w0rd1234!"
 generate_admin_ssh_key                 = true
 instances_count                        = 2
 existing_network_security_group_id     = azurerm_network_security_group.main.id
 load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.main.id]

 # Enable Auto scaling feature for VM scaleset by set argument to true.
 # Instances_count in VMSS will become default and minimum instance count.
 # Automatically scale out the number of VM instances based on CPU Average only.    
 enable_autoscale_for_vmss          = true
 minimum_instances_count            = 2
 maximum_instances_count            = 5
 scale_out_cpu_percentage_threshold = 80
 scale_in_cpu_percentage_threshold  = 20

*}

```

## License
Atos, all rights protected - 2021.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.linux_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.auto](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_proximity_placement_group.appgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/proximity_placement_group) | resource |
| [azurerm_windows_virtual_machine_scale_set.winsrv_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_data_disks"></a> [additional\_data\_disks](#input\_additional\_data\_disks) | Adding additional disks capacity to add each instance (GB) | `list(number)` | `[]` | no |
| <a name="input_additional_data_disks_storage_account_type"></a> [additional\_data\_disks\_storage\_account\_type](#input\_additional\_data\_disks\_storage\_account\_type) | The Type of Storage Account which should back this Data Disk. Possible values include Standard\_LRS, StandardSSD\_LRS, Premium\_LRS and UltraSSD\_LRS. | `string` | `"Standard_LRS"` | no |
| <a name="input_additional_unattend_content"></a> [additional\_unattend\_content](#input\_additional\_unattend\_content) | The XML formatted content that is added to the unattend.xml file for the specified path and component. | `any` | `null` | no |
| <a name="input_additional_unattend_content_setting"></a> [additional\_unattend\_content\_setting](#input\_additional\_unattend\_content\_setting) | The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands` | `any` | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine | `string` | `null` | no |
| <a name="input_admin_ssh_key_data"></a> [admin\_ssh\_key\_data](#input\_admin\_ssh\_key\_data) | specify the path to the existing ssh key to authenciate linux vm | `bool` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. | `string` | `"azureadmin"` | no |
| <a name="input_assign_public_ip_to_each_vm_in_vmss"></a> [assign\_public\_ip\_to\_each\_vm\_in\_vmss](#input\_assign\_public\_ip\_to\_each\_vm\_in\_vmss) | Create a virtual machine scale set that assigns a public IP address to each VM | `bool` | `false` | no |
| <a name="input_availability_zone_balance"></a> [availability\_zone\_balance](#input\_availability\_zone\_balance) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in | `any` | `null` | no |
| <a name="input_computer_name_prefix"></a> [computer\_name\_prefix](#input\_computer\_name\_prefix) | Specifies the name of the virtual machine inside the VM scale set | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set. | `string` | `null` | no |
| <a name="input_custom_image"></a> [custom\_image](#input\_custom\_image) | Proive the custom image to this module if the default variants are not sufficient | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Should Password Authentication be disabled on this Virtual Machine Scale Set? Defaults to true. | `bool` | `false` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault | `string` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Scale Set is sourced from. | `any` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of dns servers to use for network interface | `list` | `[]` | no |
| <a name="input_do_not_run_extensions_on_overprovisioned_machines"></a> [do\_not\_run\_extensions\_on\_overprovisioned\_machines](#input\_do\_not\_run\_extensions\_on\_overprovisioned\_machines) | Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set? | `bool` | `false` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Should Accelerated Networking be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_automatic_instance_repair"></a> [enable\_automatic\_instance\_repair](#input\_enable\_automatic\_instance\_repair) | Should the automatic instance repair be enabled on this Virtual Machine Scale Set? | `bool` | `false` | no |
| <a name="input_enable_autoscale_for_vmss"></a> [enable\_autoscale\_for\_vmss](#input\_enable\_autoscale\_for\_vmss) | Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets | `bool` | `false` | no |
| <a name="input_enable_boot_diagnostics"></a> [enable\_boot\_diagnostics](#input\_enable\_boot\_diagnostics) | Should the boot diagnostics enabled? | `bool` | `false` | no |
| <a name="input_enable_encryption_at_host"></a> [enable\_encryption\_at\_host](#input\_enable\_encryption\_at\_host) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `false` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Should IP Forwarding be enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_enable_os_disk_write_accelerator"></a> [enable\_os\_disk\_write\_accelerator](#input\_enable\_os\_disk\_write\_accelerator) | Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`. | `bool` | `false` | no |
| <a name="input_enable_proximity_placement_group"></a> [enable\_proximity\_placement\_group](#input\_enable\_proximity\_placement\_group) | Manages a proximity placement group for virtual machines, virtual machine scale sets and availability sets. | `bool` | `false` | no |
| <a name="input_enable_ultra_ssd_data_disk_storage_support"></a> [enable\_ultra\_ssd\_data\_disk\_storage\_support](#input\_enable\_ultra\_ssd\_data\_disk\_storage\_support) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine | `bool` | `false` | no |
| <a name="input_enable_windows_vm_automatic_updates"></a> [enable\_windows\_vm\_automatic\_updates](#input\_enable\_windows\_vm\_automatic\_updates) | Are automatic updates enabled for Windows Virtual Machine in this scale set? | `bool` | `true` | no |
| <a name="input_existing_network_security_group_id"></a> [existing\_network\_security\_group\_id](#input\_existing\_network\_security\_group\_id) | The resource id of existing network security group | `string` | `null` | no |
| <a name="input_generate_admin_ssh_key"></a> [generate\_admin\_ssh\_key](#input\_generate\_admin\_ssh\_key) | Generates a secure private key and encodes it as PEM. | `bool` | `false` | no |
| <a name="input_grace_period"></a> [grace\_period](#input\_grace\_period) | Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed. | `string` | `"PT30M"` | no |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | The number of Virtual Machines in the Scale Set. | `number` | `2` | no |
| <a name="input_key_vault_certificate_secret_url"></a> [key\_vault\_certificate\_secret\_url](#input\_key\_vault\_certificate\_secret\_url) | The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https` | `any` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows\_Client and Windows\_Server. | `string` | `"None"` | no |
| <a name="input_linux_distribution_list"></a> [linux\_distribution\_list](#input\_linux\_distribution\_list) | n/a | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "centos8": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "7.5",<br>    "version": "latest"<br>  },<br>  "coreos": {<br>    "offer": "CoreOS",<br>    "publisher": "CoreOS",<br>    "sku": "Stable",<br>    "version": "latest"<br>  },<br>  "ubuntu1604": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "16.04-LTS",<br>    "version": "latest"<br>  },<br>  "ubuntu1804": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "18.04-LTS",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_linux_distribution_name"></a> [linux\_distribution\_name](#input\_linux\_distribution\_name) | Variable to pick an OS flavour for Linux based VMSS possible values include: centos8, ubuntu1804 | `string` | `"ubuntu1804"` | no |
| <a name="input_load_balancer_backend_address_pool_ids"></a> [load\_balancer\_backend\_address\_pool\_ids](#input\_load\_balancer\_backend\_address\_pool\_ids) | Controls if public load balancer should be created | `any` | `null` | no |
| <a name="input_load_balancer_inbound_nat_rules_ids"></a> [load\_balancer\_inbound\_nat\_rules\_ids](#input\_load\_balancer\_inbound\_nat\_rules\_ids) | Controls if public load balancer should be created | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which the Redis cache should be created. | `string` | n/a | yes |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine Scale Set. | `string` | `null` | no |
| <a name="input_managed_identity_type"></a> [managed\_identity\_type](#input\_managed\_identity\_type) | The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` | `string` | `null` | no |
| <a name="input_maximum_instances_count"></a> [maximum\_instances\_count](#input\_maximum\_instances\_count) | The maximum number of instances for this resource. Valid values are between 0 and 1000 | `string` | `""` | no |
| <a name="input_minimum_instances_count"></a> [minimum\_instances\_count](#input\_minimum\_instances\_count) | The minimum number of instances for this resource. Valid values are between 0 and 1000 | `string` | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite` | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values include `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_os_flavor"></a> [os\_flavor](#input\_os\_flavor) | Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux` | `string` | `"windows"` | no |
| <a name="input_os_upgrade_mode"></a> [os\_upgrade\_mode](#input\_os\_upgrade\_mode) | Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Automatic | `string` | `"Manual"` | no |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true. | `bool` | `false` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set. | `any` | `null` | no |
| <a name="input_public_ip_prefix_id"></a> [public\_ip\_prefix\_id](#input\_public\_ip\_prefix\_id) | The ID of the Public IP Address Prefix from where Public IP Addresses should be allocated | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_rolling_upgrade_policy"></a> [rolling\_upgrade\_policy](#input\_rolling\_upgrade\_policy) | Enabling automatic OS image upgrades on your scale set helps ease update management by safely and automatically upgrading the OS disk for all instances in the scale set. | <pre>object({<br>    max_batch_instance_percent              = number<br>    max_unhealthy_instance_percent          = number<br>    max_unhealthy_upgraded_instance_percent = number<br>    pause_time_between_batches              = string<br>  })</pre> | <pre>{<br>  "max_batch_instance_percent": 20,<br>  "max_unhealthy_instance_percent": 20,<br>  "max_unhealthy_upgraded_instance_percent": 20,<br>  "pause_time_between_batches": "PT0S"<br>}</pre> | no |
| <a name="input_scale_in_cpu_percentage_threshold"></a> [scale\_in\_cpu\_percentage\_threshold](#input\_scale\_in\_cpu\_percentage\_threshold) | Specifies the threshold of the metric that triggers the scale in action. | `string` | `"20"` | no |
| <a name="input_scale_in_policy"></a> [scale\_in\_policy](#input\_scale\_in\_policy) | The scale-in policy rule that decides which virtual machines are chosen for removal when a Virtual Machine Scale Set is scaled in. Possible values for the scale-in policy rules are `Default`, `NewestVM` and `OldestVM` | `string` | `"Default"` | no |
| <a name="input_scale_out_cpu_percentage_threshold"></a> [scale\_out\_cpu\_percentage\_threshold](#input\_scale\_out\_cpu\_percentage\_threshold) | Specifies the threshold % of the metric that triggers the scale out action. | `string` | `"80"` | no |
| <a name="input_scaling_action_instances_number"></a> [scaling\_action\_instances\_number](#input\_scaling\_action\_instances\_number) | The number of instances involved in the scaling action | `string` | `"1"` | no |
| <a name="input_single_placement_group"></a> [single\_placement\_group](#input\_single\_placement\_group) | Allow to have cluster of 100 VMs only | `bool` | `true` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of an Image which each Virtual Machine in this Scale Set should be based on | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the hub storage account to store logs | `string` | `null` | no |
| <a name="input_storage_account_uri"></a> [storage\_account\_uri](#input\_storage\_account\_uri) | The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics. | `any` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet Id for the vm scaleset | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Scale Set, Default is Standard\_A2\_V2 | `string` | `"Standard_A2_v2"` | no |
| <a name="input_vm_time_zone"></a> [vm\_time\_zone](#input\_vm\_time\_zone) | Specifies the Time Zone which should be used by the Virtual Machine | `string` | `null` | no |
| <a name="input_vmscaleset_name"></a> [vmscaleset\_name](#input\_vmscaleset\_name) | The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer\_name\_prefix, then you must specify computer\_name\_prefix | `string` | `""` | no |
| <a name="input_windows_distribution_list"></a> [windows\_distribution\_list](#input\_windows\_distribution\_list) | n/a | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "mssql2017exp": {<br>    "offer": "SQL2017-WS2016",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "Express",<br>    "version": "latest"<br>  },<br>  "windows2012r2dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2012-R2-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2016dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2016-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2019dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-Datacenter",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_windows_distribution_name"></a> [windows\_distribution\_name](#input\_windows\_distribution\_name) | Variable to pick an OS flavour for Windows based VMSS possible values include: winserver, wincore, winsql | `string` | `"windows2019dc"` | no |
| <a name="input_winrm_protocol"></a> [winrm\_protocol](#input\_winrm\_protocol) | Specifies the protocol of winrm listener. Possible values are `Http` or `Https` | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_virtual_machine_scale_set_id"></a> [linux\_virtual\_machine\_scale\_set\_id](#output\_linux\_virtual\_machine\_scale\_set\_id) | The resource ID of the Linux Virtual Machine Scale Set. |
| <a name="output_linux_virtual_machine_scale_set_name"></a> [linux\_virtual\_machine\_scale\_set\_name](#output\_linux\_virtual\_machine\_scale\_set\_name) | The name of the Linux Virtual Machine Scale Set. |
| <a name="output_linux_virtual_machine_scale_set_unique_id"></a> [linux\_virtual\_machine\_scale\_set\_unique\_id](#output\_linux\_virtual\_machine\_scale\_set\_unique\_id) | The unique ID of the Linux Virtual Machine Scale Set. |
| <a name="output_windows_virtual_machine_scale_set_id"></a> [windows\_virtual\_machine\_scale\_set\_id](#output\_windows\_virtual\_machine\_scale\_set\_id) | The resource ID of the windows Virtual Machine Scale Set. |
| <a name="output_windows_virtual_machine_scale_set_name"></a> [windows\_virtual\_machine\_scale\_set\_name](#output\_windows\_virtual\_machine\_scale\_set\_name) | The name of the windows Virtual Machine Scale Set. |
| <a name="output_windows_virtual_machine_scale_set_unique_id"></a> [windows\_virtual\_machine\_scale\_set\_unique\_id](#output\_windows\_virtual\_machine\_scale\_set\_unique\_id) | The unique ID of the windows Virtual Machine Scale Set. |
