# Import the Active Directory module
Import-Module ActiveDirectory

# Define variables for Organizational Units (OUs), Users, and Groups
$ouName = "MARVEL"
$baseOU = "DC=JARVIS,DC=control"
$usersOU = "OU=Users,OU=$ouName,$baseOU"

# Create the OUs if they do not exist
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ouName'" -SearchBase $baseOU -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $ouName -Path $baseOU
}

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Users'" -SearchBase "OU=$ouName,$baseOU" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Users" -Path "OU=$ouName,$baseOU"
}

# Define a list of sample users
$users = @(
    @{GivenName="Steve"; Surname="Rogers"; Name="Steve Rogers"; SamAccountName="srogers"; Department="Heroes"; Title="Captain America"; Password="P@ssw0rd123!"},
    @{GivenName="Tony"; Surname="Stark"; Name="Tony Stark"; SamAccountName="tstark"; Department="R&D"; Title="Iron Man"; Password="P@ssw0rd123!"},
    @{GivenName="Natasha"; Surname="Romanoff"; Name="Natasha Romanoff"; SamAccountName="nromanoff"; Department="Espionage"; Title="Black Widow"; Password="P@ssw0rd123!"},
    @{GivenName="Bruce"; Surname="Banner"; Name="Bruce Banner"; SamAccountName="bbanner"; Department="Science"; Title="Hulk"; Password="P@ssw0rd123!"},
    @{GivenName="Thor"; Surname="Odinson"; Name="Thor Odinson"; SamAccountName="thor"; Department="Asgardian"; Title="God of Thunder"; Password="P@ssw0rd123!"}
)

# Create users in the specified OU
foreach ($user in $users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -GivenName $user.GivenName `
            -Surname $user.Surname `
            -Name $user.Name `
            -SamAccountName $user.SamAccountName `
            -UserPrincipalName "$($user.SamAccountName)@jarvis.control" `
            -Path $usersOU `
            -Department $user.Department `
            -Title $user.Title `
            -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) `
            -Enabled $true
        Write-Host "Created user: $($user.Name)"
    } else {
        Write-Host "User $($user.Name) already exists."
    }
}

# Define sample groups
$groups = @("Avengers", "Scientists", "Asgardians")

# Create groups and add members
foreach ($group in $groups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $group -Path $usersOU -GroupScope Global -GroupCategory Security
        Write-Host "Created group: $group"
    } else {
        Write-Host "Group $group already exists."
    }
}

# Add users to groups
Add-ADGroupMember -Identity "Avengers" -Members "srogers", "tstark", "nromanoff", "bbanner", "thor"
Add-ADGroupMember -Identity "Scientists" -Members "bbanner", "tstark"
Add-ADGroupMember -Identity "Asgardians" -Members "thor"

Write-Host "AD server population complete!"
