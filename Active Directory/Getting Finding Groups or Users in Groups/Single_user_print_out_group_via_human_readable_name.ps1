# Query the group memberships for a single user (Thor)
$user = "thor"

# Get the user's details, including the MemberOf property
$userDetails = Get-ADUser $user -Properties MemberOf

# Display all groups the user belongs to by expanding the MemberOf property
Write-Host "Groups for user $($user):"
$userDetails.MemberOf | ForEach-Object { Get-ADGroup $_ | Select-Object -ExpandProperty Name }