PATH=:/usr/local/bin/:${PATH}:/usr/local/mysql/bin:/sw/bin:/usr/local/git/bin:/usr/local/mysql/bin/:/Users/okumurayasuki/scala/scala-2.9.2/bin/:/opt/local/bin/:$HOME/scala/play-2.0.4/

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export CLASSPATH=.:$HOME/scala/play-2.0.4/framework/src/:$CLASSPATH
#for bash completion
#BASH_COMPLETION=~/.bash/bash_completion
#if [ -f $BASH_COMPLETION ]; then
#    source $BASH_COMPLETION
#fi
 
# cplete-hostname
#cat ~/.ssh/known_hosts |cut -f1 -d' '|sort > ~/.host_completion
#export HOSTFILE="/home/yokumura/.host_completion"
 
# for screen
#PS1='\033k\033\\'"$PS1"
PROMPT_COMMAND='screen_display'
 
function screen_display(){
  if [ x$TERM = xscreen ]; then
    echo -n -e "\033k\033\134"
    cmd=`history | tail -1 | awk '{print $2}'`
    #echo $jo > /home/yokumura/sssss.txt
    server=`hostname`
    echo -n -e "\033k${server%%.*}:$cmd\033\134"
    #echo -n -e "\033k${server%%.*}:$0\033\134"
  fi
}
 
# for ssh-agent + screen
agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "no ssh-agent"
fi

