$fruits = ("bananna", "apple", "orange")
Write-Output $fruits[1,2]


$fruits += ("peach", "rockmelon")
Write-Output $fruits[1,3,4]

$fruits = $fruits #| Where-Object { $_ -ne "peach" }
Write-Output " "
Write-Output $fruits[1,3,4]