# Saad's .zshrc

# for setting history length see HISTSIZE and HISTFILESIZE in zsh
HISTSIZE=1000
HISTFILESIZE=2000

# Enable dir colors
for file in ~/.zsh/*.zsh; do
  source $file
done


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
