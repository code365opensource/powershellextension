function Confirm-DependencyModule {
    [CmdletBinding()]
    param(
        [string]$ModuleName
    )

    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Install-Module -Name $ModuleName -Force -AllowClobber -Scope CurrentUser -Repository PSGallery
    }
}
