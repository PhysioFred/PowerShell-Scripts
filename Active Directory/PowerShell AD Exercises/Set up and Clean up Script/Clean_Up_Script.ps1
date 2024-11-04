# Variables
$ouPath = "OU=FastAndFurious,DC=JARVIS,DC=control" # Same as setup script
$users = @("dtoretto", "lortiz", "boconnor", "mtoretto", "rpearce")
$groups = @("Drivers", "Mechanics", "Operations")
$attributesToClear = @("Title", "Department")

# Remove users from groups and delete users
foreach ($user in $users) {
    foreach ($group in $groups) {
        Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false -ErrorAction SilentlyContinue
    }

    # Clear Title and Department attributes
    Set-ADUser -Identity $user -Clear $attributesToClear -ErrorAction SilentlyContinue

    # Remove user account
    Remove-ADUser -Identity $user -Confirm:$false -ErrorAction SilentlyContinue
}

# Remove test groups
foreach ($group in $groups) {
    Remove-ADGroup -Identity "CN=$group,$ouPath" -Confirm:$false -ErrorAction SilentlyContinue
}

Write-Output "Test environment cleanup complete. You can rerun the setup script to start again."
