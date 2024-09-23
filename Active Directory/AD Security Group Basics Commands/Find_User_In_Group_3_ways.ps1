# level 1: View single user and group belong to via Human readable
Get-ADUser -Identity "bbanner" -Property MemberOf | Select-Object -ExpandProperty MemberOf

# level 2: View single user and group belong to via Human readable name
$user = Get-ADUser "bbanner" -Properties MemberOf
($user.MemberOf | ForEach-Object { Get-ADGroup -Identity $_ }).Name

# level 3: View Group and batch Users in Group to via most human Readable
$group = "Scientists"
$members_of_group = "thor", "bbanner", "nromanoff"

echo ""
echo "GROUP DETAILS"
Get-ADGroup -Identity $group 
echo "LIST OF USERS:"
Get-ADGroupMember -Identity $group | where-Object {$_.samaccountname -in @($members_of_group)} | Select-Object name | ForEach-Object { write-host $_.name "is in $group group" }