$user = Get-ADUser "bbanner" -Properties MemberOf

($user.MemberOf | ForEach-Object { Get-ADGroup -Identity $_ }).Name
