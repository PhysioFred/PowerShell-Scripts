#View Groups a User Belongs To
Get-ADUser -Identity "bbanner" -Property MemberOf | Select-Object -ExpandProperty MemberOf
