$aduserobject = get-aduser rpearce -Properties memberof

foreach($group in $aduserobject.memberof){
    Get-ADGroup $group | Select-Object name, distinguishedname
}