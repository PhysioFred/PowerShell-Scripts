$aduserobject = get-aduser rpearce -Properties memberof

$cnadgroup = $aduserobject | ForEach-Object memberof 

foreach($group in $cnadgroup){
    Get-ADGroup $group | Select-Object name
}