$ApplicationID = ''
$ApplicationKey = ''
$TenantDomain = ''

$O365 = Get-Office365Health -ApplicationID $ApplicationID -ApplicationKey $ApplicationKey -TenantDomain $TenantDomain -ToLocalTime -Verbose
$Azure = Get-WinAzureHealth -Formatted
$O365.CurrentStatusExtended | Format-Table -AutoSize

Dashboard -FilePath $PSScriptRoot\Output\AzureAndO365Health.html {
    Tab -Name 'Azure' {
        foreach ($Region in $Azure.Keys) {
            Tab -Name $Region {
                Table -DataTable $Azure.$Region -Filtering {
                    foreach ($Column in $Azure.$Region[0].PSObject.Properties.Name) {
                        TableConditionalFormatting -Name $Column -Value 'Good' -BackGroundColor Green -Color White -Alignment center
                        TableConditionalFormatting -Name $Column -Value 'Information' -BackGroundColor Blue -Color White -Alignment center
                        TableConditionalFormatting -Name $Column -Value 'Warning' -BackGroundColor Orange -Alignment center
                        TableConditionalFormatting -Name $Column -Value 'Critical' -BackGroundColor Red -Color White  -Alignment center
                    }
                }
            }
        }
    }
    Tab -Name 'Services' {
        Section -Invisible {
            Section -Name 'Service List' {
                Table -DataTable $O365.Services
            }
            Section -Name 'Service & Feature List' {
                Table -DataTable $O365.ServicesExtended
            }
        }
    }
    Tab -Name 'Current Status' {
        Section -Invisible {
            Section -Name 'Current Status' {
                Table -DataTable $O365.CurrentStatus
            }
            Section -Name 'Current Status Extended' {
                Table -DataTable $O365.CurrentStatusExtended
            }
        }
    }
    Tab -Name 'Historical Status' {
        Section -Invisible {
            Section -Name 'Historical Status' {
                Table -DataTable $O365.HistoricalStatus
            }
            Section -Name 'Historical Status Extended' {
                Table -DataTable $O365.HistoricalStatusExtended
            }
        }
    }
    Tab -Name 'Message Center Information' {
        Section -Invisible {
            Section -Name 'Message Center' {
                Table -DataTable $O365.MessageCenterInformation
            }
            Section -Name 'Message Center Extended' {
                Table -DataTable $O365.MessageCenterInformationExtended -InvokeHTMLTags
            }
        }
    }
    Tab -Name 'Incidents' {
        Section -Invisible {
            Section -Name 'Incidents' {
                Table -DataTable $O365.Incidents
            }
            Section -Name 'Incidents Extended' {
                Table -DataTable $O365.IncidentsExtended
            }
        }
    }
    Tab -Name 'Incidents Messages' {
        Section -Invisible {
            Section -Name 'Incidents Messages' {
                Table -DataTable $O365.IncidentsMessages
            }
        }
    }
    Tab -Name 'Planned Maintenance' {
        Section -Invisible {
            Section {
                Table -DataTable $O365.PlannedMaintenance
            }
            Section {
                Table -DataTable $O365.PlannedMaintenanceExtended
            }
        }
    }
}