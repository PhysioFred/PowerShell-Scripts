#finding objects in an OU and then using objects in that OU to find out more detailed information

$adobjects = Get-ADObject -filter * -SearchBase "OU=FastandFurious,DC=JARVIS,DC=control"

$distinguishedname = $adobjects.distinguishedname
$name = $adobjects.name
$objectclass = $adobjects.objectclass

#pass distinguishedname through get-aduser to find out more basic information including enabled or not
#


foreach($adobject in $distinguishedname){
    get-aduser -Filter {DistinguishedName -eq $adobject} -Properties enabled
}