# .bashrc

# Greeting
greet_user() {
  echo -e "\e[38;5;214m
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⡀⠀⠀⠀⠀⠀⣿⣿⠇⠀⠀⠀⣴⣶⡄⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣧⠀⠀⠀⠀⠀⣾⣯⠀⠀⠀⠀⣿⣿⠃⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⡀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⣾⣏⠀⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⣹⣿⠀⠀⠀⠀⣿⡟⠀⠀⠀⠀⣠⣦
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣧⠀⠀⠀⠀⢻⣿⠀⠀⠀⢀⣿⠇⠀⠀⠀⠠⣿⠇
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡄⠀⠀⠀⠀⠁⠀⠀⠀⠿⠟⠀⠀⠀⢀⣼⡟⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡿⠁⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣶⣶⣿⣶⣄⣀⠀⠀⠀⠀⢸⡟⠁⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣤⡈⠀⠀⠀⠀
                                            ⣴⣶⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀
                                            ⠹⣿⣿⣿⡆⠀⠀⠀⠀⠀⢀⣤⣿⣿⡿⠀⠉⠉⢁⣾⣿⣽⣿⣿⡟⠀⠀⠀⠀⠀
                                            ⠀⠈⠻⣿⣧⡄⠀⠀⠀⠀⣨⣿⣿⠀hi->Aleš⢨⣿⡇⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠈⠙⠁⠀⣀⠀⣈⣿⣿⣿⣾⣿⣦⡀⠀⢸⣿⣿⣿⣿⣿⡗⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀
                                            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⠿⠿⠿⠛⠛⠛⠉⠀⠀

                                    \e[0m"
}

alacritty_count=$(pgrep -c alacritty)

if [ "$alacritty_count" -eq 1 ] && [ -z "$TMUX" ]; then
  greet_user
  LS_COLORS="di=38;5;214" ls --color=auto
fi

#######

# Custom terminal prompt with orange color
PS1='\[\e[38;5;214m\]┌──\[\e[0m\]\[\e[38;5;214m\](\[\e[32m\]\u@\h\[\e[38;5;214m\])-\[\e[38;5;214m\][\[\e[34m\]\w\[\e[38;5;214m\]]\[\e[0m\]\n\[\e[38;5;214m\]└─\[\e[38;5;214m\]\$ \[\e[0m\]'

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export EDITOR=vi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

## My aliases
alias pn='pnpm'
alias vi="nvim"
alias next="pnpm create next-app"
# tmux aliases
alias @="tmux"
alias @@="exit"
alias @n="tmux new-session -t"
alias @-="tmux attach -t"
alias @x="tmux kill-session -t"

# pnpm
export PNPM_HOME="/home/aleesssino/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"
eval "$(zoxide init --cmd cd bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
