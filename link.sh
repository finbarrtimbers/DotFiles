#!/bin/bash
# Script to manage config file symlinks

# Function to create a symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Check if source exists
    if [ ! -e "$source" ]; then
        echo "Error: Source file '$source' does not exist"
        return 1
    fi
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Backup existing file if it exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing file to: $backup"
        mv "$target" "$backup"
    fi
    
    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    echo "Created symlink: $target -> $source"
}

REPO_PATH="$HOME/Repos/DotFiles"

# Example configurations - modify these according to your needs
CONFIGS=(
    ".zshrc:$REPO_PATH/.zshrc"
    ".emacs:$REPO_PATH/.emacs"
    ".emacs.d:$REPO_PATH/emacs.d"
    ".tmux.conf:$REPO_PATH/.tmux.conf"
    ".gitconfig:$REPO_PATH/.gitconfig"
    ".oh-my-zsh/themes/minimalist.zsh-theme:$REPO_PATH/minimalist.zsh-theme"
)

# Create symlinks for each config file
for config in "${CONFIGS[@]}"; do
    IFS=':' read -r target source <<< "$config"
    target="$HOME/${target}"
    create_symlink "$source" "$target"
done
