$users = @(
    "dtoretto",
    "lortiz",
    "mtoretto",
    "pwalker"
)

$groups = @(
    "groupcars"
    "groupnos"
)

foreach ($group in $groups){
    foreach ($user in $users){
        try{
            Add-ADGroupMember -Identity $group -Members $user 
            echo "Added $user to $group"
        }catch{
            Write-Host "Failed to add $user to $group"
        }
    }
}