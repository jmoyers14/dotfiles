# Dotfiles

My personal configuration files for development environment setup on macOS.

## Prerequisites

- **Xcode**: Install from the App Store
- **Command Line Tools**:
    ```bash
    xcode-select --install
    ```
- **Homebrew**: Follow instructions at [brew.sh](https://brew.sh)
- **Alacritty**: Download DMG from [alacritty.org](https://alacritty.org/)

## Setup Process

### 1. Configure GitHub and Clone Repository

Set up your GitHub account and clone this repository to your local machine.

### 2. Set ZSH Path to Homebrew

For Apple Silicon Macs, add to your shell configuration:

```bash
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
```

### 3. Install Required Packages

```bash
# Core utilities
brew install fish
brew install neovim
brew install tmux
brew install fnm
brew install fzf
brew install ripgrep
brew install lazygit

# Install Yarn
# See: https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable
```

### 4. Setup Symlinks

```bash
ln -s /Users/jeremymoyers/Personal/dotfiles/alacritty ~/.config/alacritty
ln -s /Users/jeremymoyers/Personal/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s /Users/jeremymoyers/Personal/dotfiles/fish ~/.config/fish
ln -s /Users/jeremymoyers/Personal/dotfiles/nvim ~/.config/nvim
ln -s /Users/jeremymoyers/Personal/dotfiles/bin/.local/scripts/tmux-sessionizer .local/bin/tmux-sessionizer
ln -s /Users/jeremymoyers/Personal/dotfiles/tmux/.tmux.conf .tmux.conf
```

### 5. Setup Node.js

```bash
fnm install 18
```

### 6. Additional Tools

#### Ruby Environment

Install rbenv using instructions from [github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)
