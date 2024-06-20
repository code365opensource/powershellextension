function Merge-Object {
    param (
        [pscustomobject]$Object1,
        [pscustomobject]$Object2
    )
    $Object2.PSObject.Properties | ForEach-Object {
        if ($null -eq $Object1.$($_.Name)) {
            $Object1 | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
        }
    }
}