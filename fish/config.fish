if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path /Users/jmoyers/.cargo/bin
fish_add_path /Users/jmoyers/Personal/dotfiles/bin/.local/scripts
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

alias erc="vim ~/.config/fish/config.fish"
alias tlogout="rm /var/tmp/com.cooltools.remit-trip.cookie"

set current_dir (dirname (status filename))
if test -f $current_dir/secrets.fish
    source $current_dir/secrets.fish
end

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH:$ANDROID_HOME/emulator
set -gx PATH $PATH:$ANDROID_HOME/platform-tools

starship init fish | source
#set PATH $PATH /usr/local/bin /usr/local/go/bin /Library/TeX/texbin/pdflatex
#status --is-interactive; and rbenv init - fish | source

# Set up fzf key bindings
#fzf --fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jmoyers/google-cloud-sdk/path.fish.inc' ]; . '/Users/jmoyers/google-cloud-sdk/path.fish.inc'; end

