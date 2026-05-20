if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path ~/.cargo/bin
fish_add_path ~/Personal/dotfiles/bin/.local/scripts
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path /opt/homebrew/lib/ruby/gems/3.4.0/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
fish_add_path ~/.bun/bin
fish_add_path ~/.local/bin

alias erc="vim ~/.config/fish/config.fish"
alias tlogout="rm /var/tmp/com.cooltools.remit-trip.cookie"

set current_dir (dirname (status filename))
if test -f $current_dir/secrets.fish
    source $current_dir/secrets.fish
end

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH:$ANDROID_HOME/emulator
set -gx PATH $PATH:$ANDROID_HOME/platform-tools
fish_add_path ~/.yarn/bin
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

starship init fish | source
#set PATH $PATH /usr/local/bin /usr/local/go/bin /Library/TeX/texbin/pdflatex
#status --is-interactive; and rbenv init - fish | source

# Set up fzf key bindings
#fzf --fish | source

# Google Cloud SDK
if test -f '/Users/jeremymoyers/google-cloud-sdk/path.fish.inc'
    source '/Users/jeremymoyers/google-cloud-sdk/path.fish.inc'
end


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/jeremymoyers/.lmstudio/bin
# End of LM Studio CLI section

