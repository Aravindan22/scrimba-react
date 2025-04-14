<#
.SYNOPSIS
Replaces the current src folder with lesson templates from the templates-scrimba folder.

.DESCRIPTION
This script backs up the existing src folder and replaces it with the specified lesson template.

.PARAMETER LessonName
The name of the lesson folder in templates-scrimba to use as the replacement.

.EXAMPLE
.\Replace-Template.ps1 -LessonName "meme-generator"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$LessonName
)

$TemplatesDir = "templates-scrimba\$LessonName"
$SrcDir = "src"

# Check if templates directory exists
if (-not (Test-Path -Path $TemplatesDir -PathType Container)) {
    Write-Host "Error: Template directory '$TemplatesDir' not found." -ForegroundColor Red
    Write-Host "Available lessons:" -ForegroundColor Yellow
    Get-ChildItem -Path "templates-scrimba" -Directory | Select-Object -ExpandProperty Name
    exit 1
}

# Backup current src folder if it exists
if (Test-Path -Path $SrcDir -PathType Container) {
    $BackupName = "src_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Write-Host "Backing up current src folder as $BackupName" -ForegroundColor Yellow
    Rename-Item -Path $SrcDir -NewName $BackupName
}

# Copy template files
Write-Host "Copying template files from $TemplatesDir to $SrcDir" -ForegroundColor Green
Copy-Item -Path $TemplatesDir -Destination $SrcDir -Recurse

Write-Host "Successfully replaced src folder with $LessonName template" -ForegroundColor Green