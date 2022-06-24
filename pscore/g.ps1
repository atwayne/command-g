Param
(
    [parameter(Position = 0) ]
    [String]
    $alias
) 

if ($alias -eq "") {
    Write-Host "Alias not provided." -ForegroundColor Red
    Return
}


$mapping_file = [Environment]::ExpandEnvironmentVariables("%UserProfile%\.grc")
if(-not(Test-Path -Path $mapping_file -PathType Leaf)) {
    Write-Host "No mapping file found. Create $mapping_file to start." -ForegroundColor Red
    Return
}

$match = Select-String -Path $mapping_file -Pattern "^$alias\s" | ForEach-Object { $_.Line }
$target = ""
if("$match" -ne "") {
    $target = $match -split "(?=\s+)"| Select-Object -SkipIndex 0|Join-String | ForEach-Object { [Environment]::ExpandEnvironmentVariables($_).Trim() }
}
else
{
    $subFolders = Get-ChildItem -Directory|Where-Object Name -match "$alias" |Select-Object FullName
    if($subFolders.Length -eq 0){
        Write-Host "No matche found" -ForegroundColor Red
        Return
    }
    if($subFolders.Length -gt 1){
        Write-Host "Mutiple matches found. Picked the shortest one" -ForegroundColor Yellow
        $target = $subFolders| ForEach-Object { $_.FullName }| Sort-Object Length | Select-Object -First 1
        Write-Host $target
    }
    else{
        $target = $subFolders[0].FullName
    }
}

Push-Location
Set-Location $target
