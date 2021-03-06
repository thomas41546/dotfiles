# If not running interactively, don't do anything
[ -z "$PS1" ] && return

shell="$(basename $(ps -p $$ -o command | sed '1d; s/^-//; s/ .*$//'))"    

export PATH=$PATH:$HOME/bin

if [ "$(uname -s)" == "Linux" ]; then
    #LINUX
    shopt -s checkwinsize
    shopt -s autocd
	shopt -s histappend
    export LS_COLORS='*_test.py=31:di=94:fi=0:ln=96:ow=97;42:or=33:mi=103;33:ex=01;92:*.pyc=90:*.o=90:*.d=90:*.py=31:*.c=36:*.h=93:*_test.py=36'
    alias ls='ls --color=auto'
    alias la='ls -la --color=auto'
elif [ "$(uname -s)" == "Darwin" ]; then
    #OSX    
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias la='ls -la'
    alias serial='sudo cu -l /dev/tty.usbserial -s 115200'
fi

export HISTFILESIZE=20000
export HISTSIZE=10000
export HISTCONTROL=ignoredups

export EDITOR=vim
export MERGE_TOOL=meld

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

case $TERM in                                                                   
    dumb)                                                                       
        ;;                                                                      
    *)                                                                          
        c_black="\[\x1B[30m\]"
        c_bright="\[\x1B[1m\]"                                                    
        c_yellow="\[\x1B[33m\]"                                                 
        c_green="\[\x1B[32m\]"                                                 
        c_blue="\[\x1B[34m\]"                                                  
        c_red="\[\x1B[31m\]" 
        c_gray="\[\x1B[37m\]"                                  
        c_mag="\[\x1B[35m\]"
        c_white="\[\x1B[97m\]"
        c_cyan="\[\x1B[96m\]"
        c_nc="\[\x1B[0m\]"                                                   
        b_red="\[\x1B[101m\]"
        b_nc="\[\x1B[49m\]"
        ;;                                                                      
esac         
 
__jobcount () {                                                                 
    local stopped=$(jobs -s | wc -l)                                            
    local result=" "                                                            
    [ $stopped -gt 0 ] && result="$result($stopped) "                           
    echo "$result"                                                              
}                                                                               
                                                                                
__shorten () {                                                                  
    local max=$(($COLUMNS/4))                                                   
    local result="$@"                                                           
    [[ $result == $HOME/* ]] && result="~${result#$HOME}"                       
    local offset=$(( ${#result} - $max + 3 ))                                   
    [ $offset -gt 0 ] && result="...${result:$offset:$max}"                     
    [[ $result == ...*/* ]] && result="$(echo $result | sed 's/^[^/]*/.../')"   
    echo $result                                                                
}                                                                               
                                                                                
git_branch ()
{
    local result=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    echo "$result"
}


if [ $EUID = 0 ]; then                             
_user="${c_mag}\u"
else
_user="${c_red}\u"
fi                                                         

if [ "$SSH_CLIENT" ]; then
_ip=`echo $SSH_CLIENT | sed -nE 's/^([^ ]*) .*$/\1/p'`
_host="${c_gray}@${c_cyan}${_ip}"                                                            
else
_host="${c_gray}@${c_green}\h"                                                            
fi

_jobs="${c_white}"'$(__jobcount)'""                                            
_cwd=" $([ -w "$PWD" ])"
_prompt="${c_blue}"'$(__shorten \w)'""    
_git="${c_yellow}["'$(git_branch)'"]"

PS1=$(echo -e "${c_bright}${_user}${_host}${_cwd}${_prompt}${_git}${jobs} ${c_nc}")                   

alias py='/usr/bin/python'
alias nano='vim'
alias grep='grep --color=always'
alias zzz='sudo pm-suspend'
alias gg='giggle'
alias emacs='vim'
alias gl='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


function s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
    	sudo $(history -p '!!')
    else
    	sudo "$@"
    fi
}

function re()
{
    perl -pe "s|$1|$2|"
}


function gitupdate()
{   
    git commit -a -m "placeholder commit REMOVE!!";
    git rebase -i HEAD^^;
}

function check()
{ 
    ~/bin/trailwhite.py $@;
    pylint -E $@;    
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.xz)   tar xJf $1      ;;
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

