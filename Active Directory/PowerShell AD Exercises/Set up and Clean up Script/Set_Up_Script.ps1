# Set up variables
$ouPath = "OU=FastAndFurious,DC=JARVIS,DC=control" # Adjust this path as needed for your environment
$users = @(
    @{Name="Dominic Toretto"; SamAccountName="dtoretto"; Title="Driver"; Department="Cars"},
    @{Name="Letty Ortiz"; SamAccountName="lortiz"; Title="Mechanic"; Department="Garage"},
    @{Name="Brian O'Conner"; SamAccountName="boconnor"; Title="Driver"; Department="Cars"},
    @{Name="Mia Toretto"; SamAccountName="mtoretto"; Title="Operations"; Department="Administration"},
    @{Name="Roman Pearce"; SamAccountName="rpearce"; Title="Driver"; Department="Cars"}
)
$groups = @("Drivers", "Mechanics", "Operations", "TeamFast", "Logistics", "Security")

# Ensure the OU exists (create if it doesn't)
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'FastAndFurious'")) {
    New-ADOrganizationalUnit -Name "FastAndFurious" -Path "DC=JARVIS,DC=control"
}

# Create test groups
foreach ($group in $groups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$group'" -SearchBase $ouPath)) {
        New-ADGroup -Name $group -SamAccountName $group -GroupCategory Security -GroupScope Global -Path $ouPath
    }
}

# Create test users and assign to groups
foreach ($user in $users) {
    # Check if user exists before creating
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -SearchBase $ouPath)) {
        # Create user
        New-ADUser -Name $user.Name -SamAccountName $user.SamAccountName -UserPrincipalName "$($user.SamAccountName)@JARVIS.control" `
                   -Title $user.Title -Department $user.Department -Path $ouPath `
                   -AccountPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) -Enabled $true
    }

    # Add users to relevant group
    if ($user.Department -eq "Cars") {
        Add-ADGroupMember -Identity "Drivers" -Members $user.SamAccountName
    } elseif ($user.Department -eq "Garage") {
        Add-ADGroupMember -Identity "Mechanics" -Members $user.SamAccountName
    } elseif ($user.Department -eq "Administration") {
        Add-ADGroupMember -Identity "Operations" -Members $user.SamAccountName
    }
}

# Set Title and Department attributes for additional practice
foreach ($user in $users) {
    Set-ADUser -Identity $user.SamAccountName -Replace @{Title = "Specialist"; Department = "TeamFast"}
}

Write-Output "Test environment setup complete. Ready for practice."
