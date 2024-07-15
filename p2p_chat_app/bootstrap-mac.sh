#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Color codes for terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 1. Check and install Homebrew if it's not installed
if ! command_exists brew; then
  echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" --verbose
else
  echo -e "${GREEN}Homebrew is already installed.${NC}"
fi

# 2. Install Java 8
echo -e "${YELLOW}Installing Java 8...${NC}"
brew install --cask temurin8 --verbose

# Set Java 8 environment variable
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH=$JAVA_HOME/bin:$PATH

# 3. Install fvm using Homebrew
if ! command_exists fvm; then
  echo -e "${YELLOW}Installing fvm...${NC}"
  brew tap leoafarias/fvm --verbose
  brew install fvm --verbose
else
  echo -e "${GREEN}fvm is already installed.${NC}"
fi

# 4. Install Flutter using fvm
echo -e "${YELLOW}Installing Flutter using fvm...${NC}"
fvm install stable --verbose
fvm use stable --verbose

# Add Flutter to the PATH
export PATH="$HOME/.pub-cache/bin:$PATH"
export PATH="$HOME/fvm/default/bin:$PATH"

# 5. Run flutter doctor command to verify if something is missing
echo -e "${YELLOW}Running flutter doctor...${NC}"
flutter doctor --verbose

echo -e "${GREEN}Bootstrap script completed!${NC}"
