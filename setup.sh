#!/usr/bin/env zsh

###############################################################################
# macOS Sequoia (15.2) Automatic Configuration Script (Zsh)                    #
# Installs Homebrew, Brewfile dependencies, and configures iTerm2              #
###############################################################################

echo "🚀 Starting macOS setup..."

# Install Xcode Command Line Tools
echo "📦 Installing Xcode Command Line Tools..."
xcode-select --install
# Wait until installation completes
until xcode-select -p &>/dev/null; do
    sleep 5
done
echo "✅ Xcode Command Line Tools installed."

# Install Homebrew (if not installed)
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew installed."

    # Add Homebrew to the PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew already installed."
fi

# Install dependencies from Brewfile
if [[ -f ./Brewfile ]]; then
    echo "📦 Installing dependencies from Brewfile..."
    brew bundle --file=./Brewfile
    echo "✅ Brewfile dependencies installed."
else
    echo "⚠️ Brewfile not found! Skipping package installation."
fi

# Apply macOS System Preferences
echo "🛠 Applying macOS System Preferences..."

# Set Dark Mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Set Dock to auto-hide
defaults write com.apple.dock autohide -bool true
killall Dock

echo "✅ System Preferences applied."

# Configure iTerm2 with custom preferences
if [[ -f iterm2/com.googlecode.iterm2.plist ]]; then
    echo "🖥 Configuring iTerm2 with custom settings..."
    
    # Get the absolute path of the script's directory
    directory=$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")" && pwd)

    # Set iTerm2 preferences folder
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$directory/iterm2"

    # Tell iTerm2 to use the custom preferences
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

    # Don’t display the annoying prompt when quitting iTerm
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false

    echo "✅ iTerm2 configuration applied."
else
    echo "⚠️ iTerm2 config file not found! Skipping iTerm2 setup."
fi

echo "🎉 macOS setup completed successfully!"
