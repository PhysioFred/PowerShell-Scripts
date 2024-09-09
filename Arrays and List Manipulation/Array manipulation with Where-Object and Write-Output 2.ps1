Get-ADUser "aburtt"

$list_of_users = @("aburtt","acarron", "afegan")

echo $list_of_users

$list_of_users += "ahayne"

echo ""

echo $list_of_users

$list_of_users = $list_of_users | Where-Object { $_ -ne "aburtt" }

echo ""

echo $list_of_users

foreach($username in $list_of_users){
   Remove-ADUser $username
}

echo ""

echo $list_of_users