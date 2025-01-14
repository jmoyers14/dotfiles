if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path /Users/jmoyers/.cargo/bin
fish_add_path /Users/jmoyers/Personal/dotfiles/bin/.local/scripts

alias erc="vim ~/.config/fish/config.fish"
alias proj="cd ~/Projects"
alias ptmo="cd ~/Projects/trova-mobile"
alias ptmo="cd ~/Projects/trova-mobile-api-services"
alias pdt="cd ~/Projects/dynamic-trips"
alias ptb="cd ~/Projects/trova-buddy"
alias optm="cd ~/Projects/trova-maven"
alias ptc="cd ~/Projects/trova-core"
alias ptma="cd ~/Projects/trova-micro-apps"
alias ptd="cd ~/Projects/trova-devops"
alias ptbook="cd ~/Projects/trova-booking"
alias ptbooka="cd ~/Projects/trova-booking-api-services"
alias ptcomp="cd ~/Projects/trova-components"
alias ptm="cd ~/Projects/trova-maven"
alias ptn="cd ~/Projects/trova-mobile"
alias optm="code ~/Projects/trova-maven"
alias dem="cd ~/Demos"
alias doc="cd ~/Documents"
alias proj="cd ~/Projects"
alias mplay="cd ~/Documents/MongoPlaygrounds"
alias mapi="cd ~/Documents/trova-api"
alias tlogout="rm /var/tmp/com.cooltools.remit-trip.cookie"
alias list-node="ls /usr/local/Cellar | grep node"
alias node16="brew link --overwrite node@16"


set current_dir (dirname (status filename))
if test -f $current_dir/secrets.fish
    source $current_dir/secrets.fish
end

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH:$ANDROID_HOME/emulator
set -gx PATH $PATH:$ANDROID_HOME/platform-tools

set PATH $PATH /usr/local/bin /usr/local/go/bin /Library/TeX/texbin/pdflatex
starship init fish | source
status --is-interactive; and rbenv init - fish | source

# Set up fzf key bindings
fzf --fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jmoyers/google-cloud-sdk/path.fish.inc' ]; . '/Users/jmoyers/google-cloud-sdk/path.fish.inc'; end

