function Get-WinAzureHealth {
    [CmdletBinding()]
    param(
        [switch] $OriginalOutput,
        [switch] $Formatted
    )
    $AzureStatus = ConvertFrom-HtmlTable -Url "https://status.azure.com/en-us/status" -ReplaceContent @{ 'Blank' = '' }
    if (-not $OriginalOutput) {
        if ($Formatted) {
            $AzureOutput = [ordered] @{
                Americas                 = $AzureStatus[0]
                Europe                   = $AzureStatus[1]
                'Asia Pacific'           = $AzureStatus[2]
                'Middle East and Africa' = $AzureStatus[3]
                'Azure Government'       = $AzureStatus[4]
                'Azure China'            = $AzureStatus[5]
            }
        } else {
            $AzureOutput = [ordered] @{
                Americas            = $AzureStatus[0]
                Europe              = $AzureStatus[1]
                AsiaPacific         = $AzureStatus[2]
                MiddleEastAndAfrica = $AzureStatus[3]
                AzureGovernment     = $AzureStatus[4]
                AzureChina          = $AzureStatus[5]
            }
        }
        $AzureOutput
    } else {
        $AzureStatus
    }
}