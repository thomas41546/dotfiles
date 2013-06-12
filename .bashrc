shopt -s checkwinsize
export PATH=$PATH:$HOME/bin
export LS_COLORS='*_test.py=31:di=94:fi=0:ln=96:ow=97;42:or=33:mi=103;33:ex=01;92:*.pyc=90:*.o=90:*.d=90:*.py=31:*.c=36:*.h=93:*_test.py=36'
export HISTFILESIZE=90000

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
alias py='/usr/bin/python'
alias nano='vim'
alias ls='ls --color=auto'
alias grep='grep --color=always'
alias ll='ls -lah --color=auto'
alias ks='ls --color=auto'
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

git_prompt2 ()
{
    RESULT=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    echo "$RESULT"
}

PROMPT_COMMAND='PS1="\[\e[0;31m\]\u\[\e[m\]@\h:\[\e[1;32m\]\w\[\e[m\][$(git_prompt2)]\[\e[1;31m\]|\[\e[m\] "'

