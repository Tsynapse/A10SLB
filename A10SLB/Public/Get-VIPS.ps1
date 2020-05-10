<#
.Synopsis
   Gets a list of ADC VIPS from the A10
.DESCRIPTION
   Gets a list of ADC VIPS from the A10. Requires an auth header from the Get-AuthHeader command. 
.EXAMPLE
   Get-VIPS -a10 x.x.x.x -authHeader $auth
#>
function Get-VIPS
{
    [CmdletBinding()]
    Param
    (
        #IP Address of A10
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $a10,

        # Auth Headers provided by Get-AuthHeader
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $authHeader
    )

    $list = Invoke-RestMethod -Uri $("https://" + $a10 + "/axapi/v3/slb") -Method Get -ContentType 'application/json' -Headers $authHeader
    $list.slb.'virtual-server-list'

}
