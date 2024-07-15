# Function to check if a command exists
function Command-Exists {
    param (
        [string]$command
    )
    $exists = Get-Command $command -ErrorAction SilentlyContinue
    return $null -ne $exists
}

# Function to add directory to PATH if it doesn't already exist
function Add-To-Path {
    param (
        [string]$directory
    )
    if ($env:PATH -notlike "*$directory*") {
        $env:PATH = "$env:PATH;$directory"
        Write-Host "${GREEN}Added $directory to PATH${NC}"
    } else {
        Write-Host "${YELLOW}$directory already exists in PATH${NC}"
    }
}

# Color codes for terminal
$GREEN = "`e[32m"
$YELLOW = "`e[33m"
$RED = "`e[31m"
$NC = "`e[0m"

# 1. Check and install Chocolatey if it's not installed
if (-Not (Command-Exists "choco")) {
    Write-Host "${YELLOW}Chocolatey not found. Installing Chocolatey...${NC}"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "${GREEN}Chocolatey is already installed.${NC}"
}

# 2. Install Java 8
Write-Host "${YELLOW}Installing Java 8...${NC}"
choco install -y temurin8

# Set Java 8 environment variable
$javaHome = [System.Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
$env:JAVA_HOME = $javaHome
Add-To-Path "$javaHome\bin"

# 3. Install fvm using Chocolatey
if (-Not (Command-Exists "fvm")) {
    Write-Host "${YELLOW}Installing fvm...${NC}"
    choco install -y fvm
} else {
    Write-Host "${GREEN}fvm is already installed.${NC}"
}

# 4. Install Flutter using fvm
Write-Host "${YELLOW}Installing Flutter using fvm...${NC}"
fvm install stable
fvm use stable

# Add Flutter to the PATH
$flutterBin = "$env:USERPROFILE\fvm\versions\stable\bin"
Add-To-Path $flutterBin

# Ensure Flutter uses Java 8 for this script
$originalJavaHome = $env:JAVA_HOME
$originalPath = $env:PATH

# Temporarily set JAVA_HOME and update PATH for Flutter
$env:JAVA_HOME = $javaHome
$env:PATH = "$javaHome\bin;$env:PATH"

# 5. Run flutter doctor command to verify if something is missing
Write-Host "${YELLOW}Running flutter doctor...${NC}"
flutter doctor

Write-Host "${GREEN}Bootstrap script completed!${NC}"
