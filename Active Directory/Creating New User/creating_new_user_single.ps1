New-ADUser -Name "Mia Toretto" `
    -SamAccountName "mtoretto" `
    -UserPrincipalName "mtoretto@jarvis.control" `
    -GivenName "Mia" `
    -Surname "Toretto" `
    -Manager "dtoretto" `
    -Path "OU=thefastandfurious, OU=fastandfurious, DC=JARVIS,DC=control" `
    -AccountPassword (ConvertTo-SecureString "!nf0TecH" -AsPlainText -Force) `
    -Enabled $true