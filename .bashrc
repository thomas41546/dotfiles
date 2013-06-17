# If not running interactively, don't do anything
[ -z "$PS1" ] && return

shell="$(basename $(ps -p $$ -o command | sed '1d; s/^-//; s/ .*$//'))"    

export PATH=$PATH:$HOME/bin
stty cols 800

if [ "$(uname -s)" == "Linux" ]; then
    #LINUX
    shopt -s checkwinsize
    shopt -s autocd
    export LS_COLORS='*_test.py=31:di=94:fi=0:ln=96:ow=97;42:or=33:mi=103;33:ex=01;92:*.pyc=90:*.o=90:*.d=90:*.py=31:*.c=36:*.h=93:*_test.py=36'
elif [ "$(uname -s)" == "Darwin" ]; then
    #OSX    
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
fi
    
export HISTFILESIZE=90000
export HISTCONTROL=ignoredups

export EDITOR=vim
export MERGE_TOOL=meld

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

case $TERM in                                                                   
    dumb)                                                                       
        ;;                                                                      
    *)                                                                          
        c_black="\x1B[30m"
        c_bright="\x1B[1m"                                                    
        c_yellow="\x1B[33m"                                                 
        c_green="\x1B[32m"                                                 
        c_blue="\x1B[34m"                                                  
        c_red="\x1B[31m" 
        c_gray="\x1B[37m"                                  
        c_mag="\x1B[35m"
        c_white="\x1B[97m"
        c_cyan="\x1B[96m"
        c_nc="\x1B[0m"                                                   
        b_red="\x1B[101m"
        b_nc="\x1B[49m"
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

get_rc ()
{
    echo "$?"
}

#does not work, gets the rc from git_branch ?
_err="$c_mag"'[$(get_rc)]'
_err=""
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

_jobs="${c_white}"'$(__jobcount)'                                             
_cwd=" $([ -w "$PWD" ])${c_blue}"   
_prompt="${c_blue}"'$(__shorten \w)'    
_git="${c_yellow}["'$(git_branch)'"]"

PS1=$(echo -e "${c_bright}${_user}${_host}${_cwd}${_prompt}${_git}${_err}${jobs} ${c_nc}")                   

alias py='/usr/bin/python'
alias nano='vim'
alias grep='grep --color=always'
alias zzz='sudo pm-suspend'
alias gg='giggle'
alias emacs='vim'

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

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
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

