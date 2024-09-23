$group = "Scientists"

echo ""
echo "GROUP DETAILS"
Get-ADGroup -Identity $group 
echo "LIST OF USERS:"
Get-ADGroupMember -Identity $group | where-Object {$_.samaccountname -in @("thor", "bbanner", "nromanoff")} | Select-Object name | ForEach-Object { write-host $_.name "is in $group group" }