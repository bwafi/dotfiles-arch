# completion path
fpath=($HOME/.zfunc $fpath)

export TERM='xterm-256color'
export EDITOR='nvim'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="wapi"

zstyle ':omz:update' mode auto      # update automatically without asking

zstyle :omz:plugins:ssh-agent identities ~/.ssh/wapi

# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(z zsh-autopair git zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting ssh-agent)


#auto start tmux
# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_DEFAULT_SESSION_NAME="dev"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

####### User configuration #######

## configuration nnn https://github.com/jarun/nnn/
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='p:preview-tui'
export PAGER='less -R'
export NNN_OPENER=/home/wapi/.config/nnn/plugins/nuke
export NNN_TRASH=1

# cd on quit nnn https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_sh_zsh
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@" -Pp

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}


# export MANPATH="/usr/local/man:$MANPATH"

# export LANG=en_US.UTF-8

## nvim config switcher
# nvims() {
#   if [ $# -eq 0 ]; then
#     items=$(find ${XDG_CONFIG_HOME:-$HOME/.config} -maxdepth 1 -name 'nvim-*' -exec sh -c 'basename {} | cut -d"-" -f2' \;)
#     appname=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=10% --layout=reverse --border --exit-0)
#   else
#     appname="$1"
#     shift
#   fi
#
#   installed_version=$(nvim --version | awk 'NR == 1 {split($2, a, "-"); print a[1]}')
#
#   ## add required_version
#   case "$appname" in
#     "lazyvim")
#       required_version="v0.10.0"
#       ;;
#     "nvchad")
#       required_version="v0.9.4"
#       ;;
#     *)
#       echo "Unsupported appname: $appname"
#       return 1
#       ;;
#   esac
#
#   if [[ "$required_version" != "$installed_version" ]]; then
#     if [[ "$appname" == "lazyvim" ]]; then
#       bob use nightly
#     else
#       bob use "$required_version"
#     fi
#     echo "Switch to Neovim version $required_version"
#   fi
#
#   dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim-${appname}"
#   if [[ -d "${dir}" ]]; then
#     NVIM_APPNAME="$(basename ${dir})" nvim ${@}
#   else
#     echo "${dir} doesn't exist..." && return 1
#   fi
# }
#
# bindkey -s "^v" "nvims\n"
# alias v="nvims lazyvim" ## default key
# alias vlazy="nvims lazyvim"
# alias vchad="nvims nvchad"
#
# bindkey -s "^v" "nvim\n"
# alias nv="NVIM_APPNAME=nvim-nvchad nvim"



alias mongostop="sudo systemctl stop mongod"
alias mongostart="sudo systemctl start mongod"
alias mysqlstart="sudo service mysql start"
alias mysqlstop="sudo service mysql stop"
alias air='~/go/bin/air'

alias cat='bat'

# eza aliases https://github.com/eza-community/eza
alias ls='eza --icons=always'                                                         # ls
alias l='eza -lbF --git --icons=always'                                               # list, size, type, git
alias ll='eza -lbGF --git --icons=always'                                             # long list
alias llm='eza -lbGd --git --sort=modified --icons=always'                            # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons=always'  # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons=always' # all + extended list
# eza aliases specialty views
alias lS='eza -1 --icons=always'                                                       # one column, just names
alias lt='eza --tree --level=2 --icons=always'                                         # tree

# aliases trash-cli https://github.com/andreafrancia/trash-cli
alias tp='trash-put'             # trash files and directories.
alias trestore='trash-restore'   # restore a trashed file.
alias tlist='trash-list'         # list trashed files.
alias te='trash-empty'           # empty the trashcan(s).
alias trm='trash-rm'             # remove individual files from the trashcan.

# alias 
alias v=nvim
alias c=clear
alias x=exit
# alias fd=fdfind
alias tx=tmuxinator 

# global aliases
# alias -g v=nvim
# alias -g c=clear
# alias -g x=exit
# alias -g fd=fdfind

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# nnn file manager aliases
alias nx='nnn -c'                                         # tree
bindkey -s '^e' 'n^M'

# Volta javascript/node js package manager
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# go language
export PATH=$PATH:/usr/local/go/bin

# Android-SDK https://gist.github.com/dianjuar/a86814b592dad96cfa9d9540cb5acbe0
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
