# Set up variables
$ouPath = "OU=FastAndFurious,DC=JARVIS,DC=control"
$originalGroupOU = "OU=OriginalGroups,DC=JARVIS,DC=control" # Ensure this exists or modify as needed
$groups = @("Drivers", "Mechanics", "Operations", "TeamFast", "Logistics", "Security")
$users = @("dtoretto", "lortiz", "boconnor", "mtoretto", "rpearce")

# Ensure the original group OU exists
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'OriginalGroups'")) {
    New-ADOrganizationalUnit -Name "OriginalGroups" -Path "DC=JARVIS,DC=control"
}

# Move groups back to the original OU
foreach ($group in $groups) {
    $groupObject = Get-ADGroup -Filter "Name -eq '$group'" -SearchBase $ouPath
    if ($groupObject) {
        Move-ADObject -Identity $groupObject.DistinguishedName -TargetPath $originalGroupOU
        Write-Output "Moved group $group back to $originalGroupOU"
    }
}

# Delete test users
foreach ($user in $users) {
    $userObject = Get-ADUser -Filter "SamAccountName -eq '$user'" -SearchBase $ouPath
    if ($userObject) {
        Remove-ADUser -Identity $userObject.DistinguishedName -Confirm:$false
        Write-Output "Deleted user $user"
    }
}

# Delete test groups from both OUs
foreach ($group in $groups) {
    $groupObject = Get-ADGroup -Filter "Name -eq '$group'" -SearchBase $ouPath
    if ($groupObject) {
        Remove-ADGroup -Identity $groupObject.DistinguishedName -Confirm:$false
        Write-Output "Deleted group $group from $ouPath"
    }

    $originalGroupObject = Get-ADGroup -Filter "Name -eq '$group'" -SearchBase $originalGroupOU
    if ($originalGroupObject) {
        Remove-ADGroup -Identity $originalGroupObject.DistinguishedName -Confirm:$false
        Write-Output "Deleted group $group from $originalGroupOU"
    }
}

# Remove the test OU
Remove-ADOrganizationalUnit -Identity $ouPath -Recursive -Confirm:$false
Remove-ADOrganizationalUnit -Identity $originalGroupOU -Recursive -Confirm:$false

Write-Output "Cleanup completed. Test environment reset."
