# Query the group memberships for a single user (Thor)
$user = "thor"

# Get the user's details, including the MemberOf property
$userDetails = Get-ADUser $user -Properties MemberOf

# Display all groups the user belongs to by expanding the MemberOf property and printing the Distinguished Name (DN)
Write-Host "Distinguished Names of Groups for user $($user):"
$userDetails.MemberOf 
