Import-Module .\PSWinDocumentation.AzureHealthService.psd1 -Force

$Azure = Get-WinAzureHealth -Formatted
$Azure.Europe | Format-Table -AutoSize

New-HTML {
    foreach ($Region in $Azure.Keys) {
        New-HTMLTab -Name $Region {

            New-HTMLTable -DataTable $Azure.$Region -Filtering {
                foreach ($Column in $Azure.$Region[0].PSObject.Properties.Name) {
                    New-HTMLTableCondition -Name $Column -Value 'Good' -BackGroundColor Green -Color White -Alignment center
                    New-HTMLTableCondition -Name $Column -Value 'Information' -BackGroundColor Blue -Color White -Alignment center
                    New-HTMLTableCondition -Name $Column -Value 'Warning' -BackGroundColor Orange -Alignment center
                    New-HTMLTableCondition -Name $Column -Value 'Critical' -BackGroundColor Red -Color White  -Alignment center
                }
            }
        }
    }
} -FilePath $PSScriptRoot\AzureHealth.Html -UseCssLinks -UseJavaScriptLinks -TitleText 'Azure' -ShowHTML