$ffadobject = Get-ADObject -Filter * -SearchBase "OU=FastandFurious,DC=JARVIS,DC=control"

$users = @()
$groups = @()

foreach($group in $ffadobject){
    if($group.objectclass -eq "group"){
        $groupname = get-adgroup $group.DistinguishedName
        $groups += $groupname
    } 
    elseif ($group.objectclass -eq "user"){
        $username = get-aduser $group.DistinguishedName -Properties enabled
        $users += $username
    }
}

#$groups
#$users 

$data = import-csv -Path "C:\Users\Fred\PowerShell Scripts\Exercises\endisnear.csv"

foreach($enable in $data.distinguishedname){
    Enable-ADAccount $enable
    get-aduser $enable -Properties enabled | Select-Object name, enabled
}

