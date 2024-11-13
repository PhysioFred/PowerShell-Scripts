$user_list = @("dtoretto","lortiz","mtoretto")

Disable-ADAccount "dtoretto"

foreach($user in $user_list){
    $userobject = get-aduser $user
    if($userobject.SamAccountName -eq "dtoretto"){
        get-aduser $user | Select-Object name, enabled
    }
}