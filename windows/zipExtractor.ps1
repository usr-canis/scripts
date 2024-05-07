[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]$ZipName,

    [Parameter(Mandatory=$false)]
    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: Extract-Zip.ps1 [-ZipName] [-Help]"
    Write-Host ""
    Write-Host "  -ZipName <string>   The name of the zip file to extract."
    Write-Host "  -Help               Display this help message."
    return
}

$ProgramsPath = "C:\User Programs"

# Check if the programs directory exists, and create it if it doesn't
if (-not (Test-Path -Path $ProgramsPath)) {
    New-Item -Path $ProgramsPath -ItemType Directory
}

if (-not $ZipName) {
    # If the zip file name is not provided as an argument, ask the user for it
    $ZipName = Read-Host "Enter the name of the zip file to extract"
}

try {
    # Extract the contents of the zip file to a directory named after the zip file
    $ZipDirectory = Join-Path -Path $ProgramsPath -ChildPath ($ZipName -replace '\.zip$', '')
    Write-Host "Extracting files from $ZipName to $ZipDirectory"
    Expand-Archive -LiteralPath $ZipName -DestinationPath $ZipDirectory -ProgressPercentage 5,10,20,30,40,50,60,70,80,90,100 | Out-Null
    Write-Host "Extraction complete."
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}