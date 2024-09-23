# List of users
$users = @("thor", "bbanner", "nromanoff")

# Loop through each user to get their manager's name
foreach ($user in $users) {
    # Get the user details including the Manager property
    $userDetails = Get-ADUser -Identity $user -Properties Manager

    # Get the manager's Distinguished Name (DN) and resolve it to a readable name
    if ($userDetails.Manager) {
        $managerDN = $userDetails.Manager
        $manager = Get-ADUser -Identity $managerDN
        write-host "$user's manager is: $($manager.Name)"
    } else {
        write-host "$user does not have a manager listed."
    }
}

