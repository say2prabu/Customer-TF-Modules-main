# terraform-azurerm-security-center
Terraform module to create an Azure security center.

## Description
An Azure security center is a solution that provides unified security management and threat protection for data centers in the cloud. 

This module will create a Security center with advanced threat protection, vulnerability assesment, assesment policy, an assesment, auto provisioning, automation, a contact, subscription picing and a workspace.

## Module Example Use
```hcl
module "security_center" {
  source = "../../module/terraform-azurerm-security-center"

  advanced_threat_protection_resource_id           = "a240921"
  Advanced threat enabled                          = true
  
  security_center_server_virtual_machine_id        = azurerm_linux_virtual_machine.example.id

  security_center_assesment_policy_name            = "Test Display Name"
  security_center_assesment_policy_severity        = "Medium"
  security_center_assesment_policy_description     = "Test Description"
  security_center_assesment_id                     = azurerm_security_center_assessment_policy.example.id
  target_resource_id                               = azurerm_linux_virtual_machine_scale_set.example.id

    status = {
  "security_center_code" = "Healthy"
}

  security_center_auto_provisioning                = "On"
  
  security_centre_automation_location              = azurerm_resource_group.example.location
  security_centre_automation_name                  = "example-automation"
  securtiy_centre_automation_resource_group_name   = azurerm_resource_group.example.name
    action = {
      "securtiy_centre_automation_action_type"         = "EventHub" 
     "securtiy_centre_automation_action_resource_id"   = azurerm_eventhub.example.id
     # only required when type is LogicApp
     "securtiy_centre_automation_action_trigger_url"   = azurerm_eventhub_authorization_rule.example.primary_connection_string
}
    source = {
  "securtiy_centre_automation_event_source" = "Alerts"
}
     rule_set {
      rule {
        securtiy_centre_automation_source_property_path           = "properties.metadata.severity"
        securtiy_centre_automation_source_operator                = "Equals"
        securtiy_centre_automation_source_expected_value          = "High"
        securtiy_centre_automation_source_expected_property_type  = "String"
      }
    }

  securtiy_centre_contact_email                   = "example@example.com"
  securtiy_centre_contact_alert_notifications     = true
  securtiy_centre_contact_alert_to_admins         = true

  securtiy_centre_setting_setting_name            ="MCAS"
  securtiy_centre_setting_enabled                 = true

  securtiy_centre_subscritpion_pricing_tier       = "standard"

  securtiy_centre_workspace_scope                 = "/subscriptions/00000000-0000-0000-0000-000000000000"
  securtiy_centre_workspace_workspace_id          = azurerm_log_analytics_workspace.example.id



  display_name = "Test Display Name"
  severity     = "Medium"
  description  = "Test Description"
  }


```
## Requirements

No requirements.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.98.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.az_SC_advanced_thereat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_security_center_assessment.az_security_center_assesment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_assessment) | resource |
| [azurerm_security_center_assessment_policy.az_security_assesment_assesment_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_assessment_policy) | resource |
| [azurerm_security_center_auto_provisioning.az_security_center_auto_provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource |
| [azurerm_security_center_automation.az_security_center_autoamtion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation) | resource |
| [azurerm_security_center_contact.az_security_center_contact](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |
| [azurerm_security_center_server_vulnerability_assessment.az_security_center_server_vulnerability_assesment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_server_vulnerability_assessment) | resource |
| [azurerm_security_center_setting.az_security_centre_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_setting) | resource |
| [azurerm_security_center_subscription_pricing.az_security_centre_subscription_pricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |
| [azurerm_security_center_workspace.az_security_centre_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_threat_protection_enabled"></a> [advanced\_threat\_protection\_enabled](#input\_advanced\_threat\_protection\_enabled) | Should Advanced Threat Protection be enabled on this resource? | `bool` | n/a | yes |
| <a name="input_advanced_threat_protection_resource_id"></a> [advanced\_threat\_protection\_resource\_id](#input\_advanced\_threat\_protection\_resource\_id) | The ID of the Azure Resource which to enable Advanced Threat Protection on. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_admin_password"></a> [linux\_virtual\_machine\_admin\_password](#input\_linux\_virtual\_machine\_admin\_password) | password for linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_admin_username"></a> [linux\_virtual\_machine\_admin\_username](#input\_linux\_virtual\_machine\_admin\_username) | username for linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_caching"></a> [linux\_virtual\_machine\_caching](#input\_linux\_virtual\_machine\_caching) | caching option for linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_disable_password_authentication"></a> [linux\_virtual\_machine\_disable\_password\_authentication](#input\_linux\_virtual\_machine\_disable\_password\_authentication) | disable password authentication option | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_location"></a> [linux\_virtual\_machine\_location](#input\_linux\_virtual\_machine\_location) | location of linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_name"></a> [linux\_virtual\_machine\_name](#input\_linux\_virtual\_machine\_name) | name of linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_offer"></a> [linux\_virtual\_machine\_offer](#input\_linux\_virtual\_machine\_offer) | offer for source image | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_publisher"></a> [linux\_virtual\_machine\_publisher](#input\_linux\_virtual\_machine\_publisher) | name of the publisher for the source image | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_resource_group_name"></a> [linux\_virtual\_machine\_resource\_group\_name](#input\_linux\_virtual\_machine\_resource\_group\_name) | resourcegroup of linux VM name | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_size"></a> [linux\_virtual\_machine\_size](#input\_linux\_virtual\_machine\_size) | size of linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_sku"></a> [linux\_virtual\_machine\_sku](#input\_linux\_virtual\_machine\_sku) | sku for source image | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_storage_account_network_interface_id"></a> [linux\_virtual\_machine\_storage\_account\_network\_interface\_id](#input\_linux\_virtual\_machine\_storage\_account\_network\_interface\_id) | linux VM network interface id | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_storage_account_type"></a> [linux\_virtual\_machine\_storage\_account\_type](#input\_linux\_virtual\_machine\_storage\_account\_type) | storage account name for linux VM | `string` | n/a | yes |
| <a name="input_linux_virtual_machine_version"></a> [linux\_virtual\_machine\_version](#input\_linux\_virtual\_machine\_version) | version of source image | `string` | n/a | yes |
| <a name="input_network_interface_IP_address_allocation"></a> [network\_interface\_IP\_address\_allocation](#input\_network\_interface\_IP\_address\_allocation) | IP address for the IP configuration | `string` | n/a | yes |
| <a name="input_network_interface_IP_name"></a> [network\_interface\_IP\_name](#input\_network\_interface\_IP\_name) | the name of the ip configuration | `string` | n/a | yes |
| <a name="input_network_interface_IP_subnet_id"></a> [network\_interface\_IP\_subnet\_id](#input\_network\_interface\_IP\_subnet\_id) | subnet id for the ip configuration | `string` | n/a | yes |
| <a name="input_network_interface_location"></a> [network\_interface\_location](#input\_network\_interface\_location) | the location of the network interface | `string` | n/a | yes |
| <a name="input_network_interface_name"></a> [network\_interface\_name](#input\_network\_interface\_name) | network interface name | `string` | n/a | yes |
| <a name="input_network_interface_resource_group_name"></a> [network\_interface\_resource\_group\_name](#input\_network\_interface\_resource\_group\_name) | the resource group name | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The loctaion of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_security_center_additional_data"></a> [security\_center\_additional\_data](#input\_security\_center\_additional\_data) | A map of additional data to associate with the assessment. | `map(string)` | <pre>{<br>  "": ""<br>}</pre> | no |
| <a name="input_security_center_assesment_id"></a> [security\_center\_assesment\_id](#input\_security\_center\_assesment\_id) | The ID of the security Assessment policy to apply to this resource. Changing this forces a new security Assessment to be created. | `string` | n/a | yes |
| <a name="input_security_center_assesment_policy_categories"></a> [security\_center\_assesment\_policy\_categories](#input\_security\_center\_assesment\_policy\_categories) | A list of the categories of resource that is at risk when the Security Center Assessment is unhealthy. Possible values are Unknown, Compute, Data, IdentityAndAccess, IoT and Networking | `string` | `""` | no |
| <a name="input_security_center_assesment_policy_description"></a> [security\_center\_assesment\_policy\_description](#input\_security\_center\_assesment\_policy\_description) | Specifies the human readable description of the assessment status | `string` | n/a | yes |
| <a name="input_security_center_assesment_policy_implementation_effort"></a> [security\_center\_assesment\_policy\_implementation\_effort](#input\_security\_center\_assesment\_policy\_implementation\_effort) | The implementation effort which is used to remediate the Security Center Assessment. Possible values are Low, Moderate and High. | `string` | `""` | no |
| <a name="input_security_center_assesment_policy_name"></a> [security\_center\_assesment\_policy\_name](#input\_security\_center\_assesment\_policy\_name) | The user-friendly display name of the Security Center Assessment. | `string` | n/a | yes |
| <a name="input_security_center_assesment_policy_remediation_description"></a> [security\_center\_assesment\_policy\_remediation\_description](#input\_security\_center\_assesment\_policy\_remediation\_description) | The description which is used to mitigate the security issue. | `string` | `""` | no |
| <a name="input_security_center_assesment_policy_severity"></a> [security\_center\_assesment\_policy\_severity](#input\_security\_center\_assesment\_policy\_severity) | The severity level of the Security Center Assessment. Possible values are Low, Medium and High. | `string` | `"Medium"` | no |
| <a name="input_security_center_assesment_policy_threats"></a> [security\_center\_assesment\_policy\_threats](#input\_security\_center\_assesment\_policy\_threats) | A list of the threat impacts for the Security Center Assessment. Possible values are AccountBreach, DataExfiltration, DataSpillage, DenialOfService, ElevationOfPrivilege, MaliciousInsider, MissingCoverage and ThreatResistance. | `string` | `""` | no |
| <a name="input_security_center_assesment_policy_user_impact"></a> [security\_center\_assesment\_policy\_user\_impact](#input\_security\_center\_assesment\_policy\_user\_impact) | The user impact of the Security Center Assessment. Possible values are Low, Moderate and High. | `string` | `""` | no |
| <a name="input_security_center_auto_provisioning"></a> [security\_center\_auto\_provisioning](#input\_security\_center\_auto\_provisioning) | Should the security agent be automatically provisioned on Virtual Machines in this subscription? Possible values are On (to install the security agent automatically, if it's missing) or Off (to not install the security agent automatically). | `string` | n/a | yes |
| <a name="input_security_center_automation_scopes"></a> [security\_center\_automation\_scopes](#input\_security\_center\_automation\_scopes) | A list of scopes on which the automation logic is applied, at least one is required. Supported scopes are a subscription (in this format /subscriptions/00000000-0000-0000-0000-000000000000) or a resource group under that subscription (in the format /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example). The automation will only apply on defined scopes. | `list(string)` | n/a | yes |
| <a name="input_security_center_cause"></a> [security\_center\_cause](#input\_security\_center\_cause) | Specifies the cause of the assessment status. | `string` | `""` | no |
| <a name="input_security_center_code"></a> [security\_center\_code](#input\_security\_center\_code) | Specifies the programmatic code of the assessment status. Possible values are Healthy, Unhealthy and NotApplicable. | `string` | n/a | yes |
| <a name="input_security_center_description"></a> [security\_center\_description](#input\_security\_center\_description) | Specifies the human readable description of the assessment status. | `string` | `""` | no |
| <a name="input_security_center_server_addititonal_data"></a> [security\_center\_server\_addititonal\_data](#input\_security\_center\_server\_addititonal\_data) | A map of additional data to associate with the assessment. | `string` | `""` | no |
| <a name="input_security_center_server_hybrid_machine_id"></a> [security\_center\_server\_hybrid\_machine\_id](#input\_security\_center\_server\_hybrid\_machine\_id) | The ID of the Azure ARC server to be monitored by vulnerability assessment. Changing this forces a new resource to be created.One of either virtual\_machine\_id or hybrid\_machine\_id must be set. | `string` | `""` | no |
| <a name="input_security_center_server_status"></a> [security\_center\_server\_status](#input\_security\_center\_server\_status) | A status block as defined below. | `string` | n/a | yes |
| <a name="input_security_center_server_virtual_machine_id"></a> [security\_center\_server\_virtual\_machine\_id](#input\_security\_center\_server\_virtual\_machine\_id) | The ID of the virtual machine to be monitored by vulnerability assessment. Changing this forces a new resource to be created.One of either virtual\_machine\_id or hybrid\_machine\_id must be set. | `string` | `""` | no |
| <a name="input_security_center_target_id"></a> [security\_center\_target\_id](#input\_security\_center\_target\_id) | The ID of the target resource. Changing this forces a new security Assessment to be created. | `string` | n/a | yes |
| <a name="input_security_centre_automation_location"></a> [security\_centre\_automation\_location](#input\_security\_centre\_automation\_location) | The Azure Region where the Security Center Automation should exist. Changing this forces a new Security Center Automation to be created. | `string` | n/a | yes |
| <a name="input_security_centre_automation_name"></a> [security\_centre\_automation\_name](#input\_security\_centre\_automation\_name) | The name which should be used for this Security Center Automation. Changing this forces a new Security Center Automation to be created. | `string` | n/a | yes |
| <a name="input_securtiy_centre_automation_action_connection_string"></a> [securtiy\_centre\_automation\_action\_connection\_string](#input\_securtiy\_centre\_automation\_action\_connection\_string) | (Optional, but required when type is EventHub) A connection string to send data to the target Event Hub namespace, this should include a key with send permissions. | `string` | `""` | no |
| <a name="input_securtiy_centre_automation_action_resource_id"></a> [securtiy\_centre\_automation\_action\_resource\_id](#input\_securtiy\_centre\_automation\_action\_resource\_id) | The resource id of the target Logic App, Event Hub namespace or Log Analytics workspace. | `string` | n/a | yes |
| <a name="input_securtiy_centre_automation_action_trigger_url"></a> [securtiy\_centre\_automation\_action\_trigger\_url](#input\_securtiy\_centre\_automation\_action\_trigger\_url) | The callback URL to trigger the Logic App that will receive and process data sent by this automation. This can be found in the Azure Portal under See trigger history | `string` | `""` | no |
| <a name="input_securtiy_centre_automation_action_type"></a> [securtiy\_centre\_automation\_action\_type](#input\_securtiy\_centre\_automation\_action\_type) | Type of Azure resource to send data to. Must be set to one of: LogicApp, EventHub or LogAnalytics. | `string` | n/a | yes |
| <a name="input_securtiy_centre_automation_event_source"></a> [securtiy\_centre\_automation\_event\_source](#input\_securtiy\_centre\_automation\_event\_source) | Type of data that will trigger this automation. Must be one of Alerts, Assessments, AssessmentsSnapshot, RegulatoryComplianceAssessment, RegulatoryComplianceAssessmentSnapshot, SecureScoreControls, SecureScoreControlsSnapshot, SecureScores, SecureScoresSnapshot, SubAssessments or SubAssessmentsSnapshot. Note. assessments are also referred to as recommendations. The schema for Security Center alerts, when event\_source is Alerts | `string` | n/a | yes |
| <a name="input_securtiy_centre_automation_resource_group_name"></a> [securtiy\_centre\_automation\_resource\_group\_name](#input\_securtiy\_centre\_automation\_resource\_group\_name) | The name of the Resource Group where the Security Center Automation should exist. Changing this forces a new Security Center Automation to be created. | `string` | n/a | yes |
| <a name="input_securtiy_centre_automation_source_expected_property_type"></a> [securtiy\_centre\_automation\_source\_expected\_property\_type](#input\_securtiy\_centre\_automation\_source\_expected\_property\_type) | The data type of the compared operands, must be one of: Integer, String, Boolean or Number. | `string` | `""` | no |
| <a name="input_securtiy_centre_automation_source_expected_value"></a> [securtiy\_centre\_automation\_source\_expected\_value](#input\_securtiy\_centre\_automation\_source\_expected\_value) | A value that will be compared with the value in property\_path. | `string` | `""` | no |
| <a name="input_securtiy_centre_automation_source_operator"></a> [securtiy\_centre\_automation\_source\_operator](#input\_securtiy\_centre\_automation\_source\_operator) | The comparison operator to use, must be one of: Contains, EndsWith, Equals, GreaterThan, GreaterThanOrEqualTo, LesserThan, LesserThanOrEqualTo, NotEquals, StartsWith | `string` | `""` | no |
| <a name="input_securtiy_centre_automation_source_property_path"></a> [securtiy\_centre\_automation\_source\_property\_path](#input\_securtiy\_centre\_automation\_source\_property\_path) | The JPath of the entity model property that should be checked. | `string` | `""` | no |
| <a name="input_securtiy_centre_contact_alert_notifications"></a> [securtiy\_centre\_contact\_alert\_notifications](#input\_securtiy\_centre\_contact\_alert\_notifications) | Whether to send security alerts notifications to the security contact. | `bool` | n/a | yes |
| <a name="input_securtiy_centre_contact_alert_to_admins"></a> [securtiy\_centre\_contact\_alert\_to\_admins](#input\_securtiy\_centre\_contact\_alert\_to\_admins) | Whether to send security alerts notifications to subscription admins. | `bool` | n/a | yes |
| <a name="input_securtiy_centre_contact_email"></a> [securtiy\_centre\_contact\_email](#input\_securtiy\_centre\_contact\_email) | The email of the Security Center Contact. | `string` | n/a | yes |
| <a name="input_securtiy_centre_contact_phone"></a> [securtiy\_centre\_contact\_phone](#input\_securtiy\_centre\_contact\_phone) | The phone number of the Security Center Contact. | `string` | `""` | no |
| <a name="input_securtiy_centre_setting_enabled"></a> [securtiy\_centre\_setting\_enabled](#input\_securtiy\_centre\_setting\_enabled) | Boolean flag to enable/disable data access. | `bool` | n/a | yes |
| <a name="input_securtiy_centre_setting_setting_name"></a> [securtiy\_centre\_setting\_setting\_name](#input\_securtiy\_centre\_setting\_setting\_name) | The setting to manage. Possible values are MCAS and WDATP. | `string` | n/a | yes |
| <a name="input_securtiy_centre_subscritpion_pricing_resource_type"></a> [securtiy\_centre\_subscritpion\_pricing\_resource\_type](#input\_securtiy\_centre\_subscritpion\_pricing\_resource\_type) | The resource type this setting affects. Possible values are AppServices, ContainerRegistry, KeyVaults, KubernetesService, SqlServers, SqlServerVirtualMachines, StorageAccounts, VirtualMachines, Arm, OpenSourceRelationalDatabases, Containers and Dns. Defaults to VirtualMachines. | `string` | `"virtual machine"` | no |
| <a name="input_securtiy_centre_subscritpion_pricing_tier"></a> [securtiy\_centre\_subscritpion\_pricing\_tier](#input\_securtiy\_centre\_subscritpion\_pricing\_tier) | The pricing tier to use. Possible values are Free and Standard | `string` | n/a | yes |
| <a name="input_securtiy_centre_workspace_scope"></a> [securtiy\_centre\_workspace\_scope](#input\_securtiy\_centre\_workspace\_scope) | The scope of VMs to send their security data to the desired workspace, unless overridden by a setting with more specific scope. | `string` | n/a | yes |
| <a name="input_securtiy_centre_workspace_workspace_id"></a> [securtiy\_centre\_workspace\_workspace\_id](#input\_securtiy\_centre\_workspace\_workspace\_id) | The ID of the Log Analytics Workspace to save the data in. | `string` | n/a | yes |
| <a name="input_storage_account_account_tier"></a> [storage\_account\_account\_tier](#input\_storage\_account\_account\_tier) | The account tier of the storage account | `string` | n/a | yes |
| <a name="input_storage_account_location"></a> [storage\_account\_location](#input\_storage\_account\_location) | The location of the storage account | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account | `string` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | the storage account replication | `string` | n/a | yes |
| <a name="input_storage_account_resource_group_name"></a> [storage\_account\_resource\_group\_name](#input\_storage\_account\_resource\_group\_name) | The name of the resource group which the storage account is in | `string` | n/a | yes |
| <a name="input_storage_account_tags"></a> [storage\_account\_tags](#input\_storage\_account\_tags) | the storage account tags | `map(string)` | n/a | yes |
| <a name="input_subnet_adress_prefix"></a> [subnet\_adress\_prefix](#input\_subnet\_adress\_prefix) | subnet adress prefixes | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | subnet name | `string` | n/a | yes |
| <a name="input_subnet_network_name"></a> [subnet\_network\_name](#input\_subnet\_network\_name) | subnet network name | `string` | n/a | yes |
| <a name="input_subnet_resource_group_name"></a> [subnet\_resource\_group\_name](#input\_subnet\_resource\_group\_name) | subnet resource group name | `string` | n/a | yes |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | virtual network address space | `string` | n/a | yes |
| <a name="input_virtual_network_location"></a> [virtual\_network\_location](#input\_virtual\_network\_location) | virtual network location | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | virtual network name | `string` | n/a | yes |
| <a name="input_virtual_network_resource_group_name"></a> [virtual\_network\_resource\_group\_name](#input\_virtual\_network\_resource\_group\_name) | virtual network resource group name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_center_advanced_threat_protection_id"></a> [security\_center\_advanced\_threat\_protection\_id](#output\_security\_center\_advanced\_threat\_protection\_id) | The ID of the Advanced Threat Protection resource. |
| <a name="output_security_center_assesment_id"></a> [security\_center\_assesment\_id](#output\_security\_center\_assesment\_id) | The ID of the Security Center Assessment Policy. |
| <a name="output_security_center_auto_provisioning_id"></a> [security\_center\_auto\_provisioning\_id](#output\_security\_center\_auto\_provisioning\_id) | The ID of the Security Center Auto Provisioning. |
| <a name="output_security_center_automation_id"></a> [security\_center\_automation\_id](#output\_security\_center\_automation\_id) | The ID of the Security Center Automation. |
| <a name="output_security_center_contact_id"></a> [security\_center\_contact\_id](#output\_security\_center\_contact\_id) | The Security Center Contact ID. |
| <a name="output_security_center_server_vulnerability_id"></a> [security\_center\_server\_vulnerability\_id](#output\_security\_center\_server\_vulnerability\_id) | The ID of the Vulnerability Assessment resource. |
| <a name="output_security_center_setting_id"></a> [security\_center\_setting\_id](#output\_security\_center\_setting\_id) | The subscription security center setting id. |
| <a name="output_security_center_subscription_pricing_id"></a> [security\_center\_subscription\_pricing\_id](#output\_security\_center\_subscription\_pricing\_id) | The subscription pricing ID. |
| <a name="output_security_center_workspace_id"></a> [security\_center\_workspace\_id](#output\_security\_center\_workspace\_id) | The Security Center Workspace ID. |
