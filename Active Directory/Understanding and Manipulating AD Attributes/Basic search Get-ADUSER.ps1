Get-ADUser -Filter { GivenName -eq "Captain" -and Surname -eq "America" }
Get-ADUser -Filter { GivenName -like "J*" }

#Get-ADUser -Filter is a powerful cmdlet for searching AD users by attributes like GivenName and Surname.
#Use -eq for exact matches and -like with wildcards for partial matches.
#Combine multiple conditions with -and or -or for flexible searches.
#Use -Properties to display additional information about users.