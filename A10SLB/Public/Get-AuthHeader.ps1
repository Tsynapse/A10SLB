<#
.Synopsis
   Get A10 Auth Header.
.DESCRIPTION
   Retrieves the Authentication Header from the A10 for Use in other Functions.  This needs to be done with a local A10 account like Admin. The fucntion should be called witht he output going into a variable.
.EXAMPLE
   $auth = Get-A10Authheader -a10 x.x.x.x
#>
function Get-AuthHeader
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $a10
    )

    Begin
    {
    $creds = Get-Credential
    $payload =@{ credentials = @{username = $creds.Username; password =$creds.GetNetworkCredential().password}}
    }
    Process
    {
    $auth = Invoke-RestMethod -Uri $("https://" + $a10 + "/axapi/v3/auth") -Method Post -ContentType 'application/json' -Body (ConvertTo-Json $Payload)
    }
    End
    {
    $(@{ Authorization = 'A10 '+ $auth.authresponse.signature})
    }
}