# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/$USER/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


# Adds the powerline prompt theme
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Shows vaild commands in green and invaild commands as red. Installed via Pacman
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Shows suggestions when starting to type a command. Installed via Pacman
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# Allows you search just throught a type command, EG if you type nano by press allow up and down 
# it will cycle the any commands that nano have been used with. Installed via Pacman. use cat -v to get keybind code
source /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# Allows the delete keyboard button to be pressed and delete characters before the cursor
bindkey '^[[3~' delete-char


# By Press esc twice it adds sudo to a command. Installed via yay
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh


# Adding /sbin to path to allow to use of "reboot" command to all users
export PATH=$PATH:/sbin















alias cat='bat -p'

alias du='du -h'

alias df='df -h'

alias pacs='sudo pacman -Sy'

alias pacu='sudo pacman -Syu'

alias paci='sudo pacman -S'

alias ls='lsd'









