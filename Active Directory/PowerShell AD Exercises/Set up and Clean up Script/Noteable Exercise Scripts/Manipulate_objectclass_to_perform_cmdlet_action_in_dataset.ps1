$data = import-csv -path "C:\Users\Fred\PowerShell Scripts\Exercises\fastOU.csv"

#find info on group and member of the groups in ff OU

foreach($group in $data){
    if ($group.objectclass -eq "user"){
        Disable-ADAccount $group.distinguishedname 
        get-aduser $group.distinguishedname | Select-Object name, enabled
        echo "Get disabled BITCH"
    }
}
 
 #so you want the entire data list of objects first, then use dot notation on the loop variable to access the object class with condition that it is a group, 
 #then using the loop variable again but change the dot notation to access the distinguished name of the current object/row in $data