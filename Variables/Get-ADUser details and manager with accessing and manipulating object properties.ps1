# Get the user with their manager's DN
$user = Get-ADUser -Filter { name -like "Thor Odi*" } -Properties Manager

# Get the manager's details using their DN
$manager = Get-ADUser -Identity $user.Manager

# Display the manager's name and SAMAccountName
$manager | Select-Object Name, SAMAccountName