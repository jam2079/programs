# /home/jam2079/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#alias rm='rm -i'
alias rmf='rm -rf'
alias cpf='cp -r'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ..='cd ..'
#alias '../..'='cd ../..'
alias ~='cd /home/jam2079'
alias lt='ls --color -ltrh'
alias ll='ls --color -lh'
alias ls='ls --color'
alias qstatu='qstat -u "*"'
alias qstatw='sh /home/jam2079/programs/qstat_watch.sh'
alias lta='ls --color -altrh'
alias lla='ls --color -alh'
alias lsa='ls --color -ah'
alias nfiles='ls -1 | wc -l'
alias creategif='convert -colors 256 -dispose 1 -loop 0'
alias removelinks='find -L . -type l -delete &'
alias removedotdash="find . -iname '._' -exec rm '{}' ';'"
alias dusort='du -hs * | sort -h'
alias countfiles='find . -type f | wc -l'

alias bringandcat='sh /home/jam2079/programs/bringandcat.sh'
alias sendtocarver='sh /home/jam2079/programs/sendtocarver.sh'

function gedit() { command gedit "$@" & }

alias compresstar='tar -zcvf'
function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

slchoose gromacs 3.3.1 >& /home/jam2079/.hidden_bashrc_output
slchoose R 2.15.2 gcc_64 >& /home/jam2079/.hidden_bashrc_output
#find -L . -type l -delete >& /home/jam2079/.hidden_bashrc_output &
find . -iname "*/home/jam2079" -exec rm '{}' ';' >& /home/jam2079/.hidden_bashrc_output
#export LIBGL_ALWAYS_INDIRECT=yes

#Openstructure
installdir=/home/nij2003/openstructure
export PATH=$installdir/bin${PATH+:$PATH}
export LD_LIBRARY_PATH=$installdir/lib64:$installdir/lib${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}
alias ost_develop=$installdir/develop/stage/bin/ost
alias dng_develop=$installdir/develop/stage/bin/dng
alias ost_stable=$installdir/release-1.3.3/stage/bin/ost
alias dng_stable=$installdir/release-1.3.3/stage/bin/dng

alias modeller="/home/jam2079/programs/modeller"
alias catdcd="/home/jam2079/programs/catdcd"
alias Rscript="/home/jam2079/programs/Rscript"
alias R="/home/jam2079/programs/RR"
alias vmdrun="vmd -dispdev text -e"
#alias MATCH="/home/jam2079/programs/MATCH_RELEASE/MATCH/scripts/MATCH.pl"
export PATH=/home/jam2079/programs/MATCH_RELEASE/MATCH/scripts/:$PATH
export PerlChemistry=/home/jam2079/programs/MATCH_RELEASE/PerlChemistry
export MATCH=/home/jam2079/programs/MATCH_RELEASE/MATCH
alias xvfb="/home/jam2079/programs/xvfb_wrapper.sh"
alias getpdb="sh /home/jam2079/programs/getpdb.sh"
alias prepareMD="sh /home/jam2079/programs/prepareMD.sh"

alias ginit="sh /home/jam2079/programs/ginit.sh"
alias gadd="git add ."
alias gcomm="git commit -m "
alias gpush="sh /home/jam2079/programs/gpush.sh"
alias gstat="git status"
alias gpull="git pull" 
alias glog="git log"
alias gcheckout="git checkout -- "
alias gsize="sh /home/jam2079/programs/gsize.sh"
alias grecover="sh /home/jam2079/programs/grecover.sh"

alias panda2="ssh -X panda2.pbtech"
alias zeno="qlogin -l zeno=true"
alias fido="ssh -X fido"
alias nersc="ssh -X jmedina@carver.nersc.gov"
