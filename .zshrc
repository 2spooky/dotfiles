

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select


alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls --color=auto'
alias grep='grep --color=auto'


autoload colors; colors;


setopt hist_ignore_all_dups
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE


# vi mode prompts
setopt transientrprompt
bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^h' backward-delete-char
export KEYTIMEOUT=1

# red, blue, green, cyan, yellow, magenta, black, white
# PROMPT
PS1="\
%{$fg_bold[blue]%}%n\
%{$fg_no_bold[white]%}@\
%{$fg[green]%}%m \
%{$fg_bold[blue]%}: \
%{$fg_no_bold[green]%}%3~\
%(0?. . ${fg[red]}%? )\
%{$fg_bold[blue]%}%#\
%{$reset_color%} "

#  RPROMPT
vim_ins_mode="%{$fg_bold[green]%} INSERT %{$reset_color%}"
vim_cmd_mode="%{$fg_bold[blue]%} NORMAL %{$reset_color%}"

RPS1=$vim_ins_mode

function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	zle reset-prompt
}

function zle-line-finish {
	RPS1=$vim_ins_mode
}

# catch ^c
function TRAPINT() {
	RPS1=$vim_ins_mode
	zle && zle reset-prompt
	return $(( 128 + $1 ))
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish


function backup() {
	newname=$1.`date +%Y%m%d.%H%M.bak`;
	mv $1 $newname;
	echo "Backed up $1 to $newname.";
	cp -p $newname $1;
}

