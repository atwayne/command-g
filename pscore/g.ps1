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
if("$match" -eq "") {
    Write-Host "No mapping found in $mapping_file" -ForegroundColor Red
    Return
}

$target = $match -split "(?=\s+)"| Select-Object -SkipIndex 0|Join-String | ForEach-Object { [Environment]::ExpandEnvironmentVariables($_).Trim() }
Push-Location
Set-Location $target
