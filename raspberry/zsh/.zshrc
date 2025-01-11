# Add deno completions to search path
neofetch
# Set color variables
autoload -U colors && colors

# Define prompt colors (example colors)
PROMPT_COLOR="%{$fg[cyan]%}"
USER_COLOR="%{$fg[green]%}"
HOST_COLOR="%{$fg[red]%}"
PATH_COLOR="%{$fg[blue]%}"
GIT_COLOR="%{$fg[yellow]%}"
RESET_COLOR="%{$reset_color%}"
# Custom prompt
PROMPT='${PROMPT_COLOR}${USER_COLOR} %n${RESET_COLOR} ${HOST_COLOR} %m${PATH_COLOR}   %~${RESET_COLOR}
${PROMPT_COLOR}${GIT_COLOR}$(git_prompt_info)${RESET_COLOR}  '
RPS1='${ICON}'

# Function to display git branch in the prompt
function git_prompt_info() {
  local branch
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F'/' '{print $3}')
  if [ -n "$branch" ]; then
    echo "[$branch] "
  fi
}

# Initialize and configure command completion
autoload -U compinit
compinit

# Enable menu selection
zstyle ':completion:*' menu select
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;2;116;199;236;38;2;0;0;0"

# Set history options
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Set other useful options
setopt autocd             # Change to directory without typing 'cd'
setopt notify             # Notify when jobs are completed
setopt correct            # Correct command spelling
setopt prompt_subst       # Prompt substitution

# Define syntax highlighting styles
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
    main    # Basic syntax highlighting
    brackets    # Bracket highlighting
    pattern     # Pattern matching highlighting
    cursor      # Cursor position highlighting
)

# Define syntax highlighting styles
ZSH_HIGHLIGHT_STYLES=(
    # Default text
    default=fg=yellow,bold

    # Comments
    comment=fg=cyan

    # Keywords
    keyword=fg=magenta

    # Commands
    command=fg=green

    # Strings
    string=fg=blue

    # Variables
    var=fg=red
)

# Load theme if using a Zsh framework (like Oh My Zsh)
# source $ZSH/oh-my-zsh.sh

# Other example styles:
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=magenta,bold'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow,underline'

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#0B0B13,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#45475a \
--multi"

alias ":q"=exit
# ddcutil is used to set my screen brightness without having to use the physical buttons
# I was unable to find a better solution
alias bright='ddcutil setvcp 10 + 100'
alias brighter='ddcutil setvcp 10 - 10'
alias dark='ddcutil setvcp 10 - 100'
alias darker='ddcutil setvcp 10 - 10'
alias default='ddcutil setvcp DC 0'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias format='prettier --tab-width 1 --write .'
alias fzf='fzf --reverse --border rounded --margin 1 --preview='\''bat --color always --theme base16 {}'\'
alias grep='grep --color=auto'
alias hell='node ~/bin/alias.js'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lq='cd ~/liqour_ideas/'
alias note='cat >> ~/notes/notes.txt'
alias nzf='nvim $(fzf --preview='\''bat --color always {}'\'')'
alias run-help=man
alias s='source /home/constantin/.zshrc'
alias tdt='tmux attach -d -t'
alias tv='ddcutil setvcp DC 3'
alias u='cd ..'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-tilde --show-dot'
alias which-command=whence
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
alias commit="bash ~/bin/commit.bash"
alias ls="lsd --tree --depth=2"
alias l="lsd"
alias la="lsd -l -a --git --gitsort --depth=2 --tree"
alias dir="lsd"
alias pacman="sudo pacman"
alias docker="sudo docker"
alias lr="tmux popup -E '~/lq/sh/launcher.bash'"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

. "$HOME/.cargo/env"
