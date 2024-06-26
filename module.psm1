
class RequiredAdministratorAttribute: System.Management.Automation.CmdletBindingAttribute {
    RequiredAdministratorAttribute():base() {
        if (-not ([System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
            throw [System.Management.Automation.ValidationMetadataException] "This command requires administrative privileges"
        }
    }
}


foreach ($directory in @('Public', 'Private', '.')) {

    $path = Join-Path -Path $PSScriptRoot -ChildPath $directory
    if (Test-Path $path) {
        Get-ChildItem -Path $path -Filter "*.ps1" | ForEach-Object { . $_.FullName }
    }
}
