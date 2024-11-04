# Get all objects in the specified OU
$ffadobject = Get-ADObject -Filter * -SearchBase "OU=FastandFurious,DC=JARVIS,DC=control"

# Initialize empty arrays for users and groups
$users = @()
$groups = @()

# Loop through each object in $ffadobject
foreach ($item in $ffadobject) {
    if ($item.ObjectClass -eq "user") {
        # Add user's DistinguishedName to the $users array
        $users += $item.DistinguishedName
        Write-Output "User added: $($item.DistinguishedName)"
    }
    elseif ($item.ObjectClass -eq "group") {
        # Add group's DistinguishedName to the $groups array
        $groups += $item.DistinguishedName
        Write-Output "Group added: $($item.DistinguishedName)"
    }
}

# Display the results
Write-Output "`nList of Users:"
$users

Write-Output "`nList of Groups:"
$groups

foreach($user in $users){
    Get-ADuser $user
    Disable-ADAccount $user
    echo "nnnnUser: $user deactivated"
}

foreach($group in $groups){
    echo "THE GROUP IS $group"
    Get-ADgroupmember $group
}