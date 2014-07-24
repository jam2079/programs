# ~/.bashrc: executed by bash(1) for non-login shells.
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
alias ~='cd ~'
alias lt='ls --color -ltrh'
alias ll='ls --color -lh'
alias ls='ls --color'
alias qstatu='qstat -u "*"'
alias qstatw='sh ~/programs/qstat_watch.sh'
alias lta='ls --color -altrh'
alias lla='ls --color -alh'
alias lsa='ls --color -ah'
alias nfiles='ls -1 | wc -l'
alias creategif='convert -colors 256 -dispose 1 -loop 0'
alias removelinks='find -L . -type l -delete &'
alias removedotdash="find . -iname '._' -exec rm '{}' ';'"
alias dusort='du -hs * | sort -h'
alias countfiles='find . -type f | wc -l'

function gedit() { command gedit "$@" & }

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

slchoose gromacs 3.3.1 >& ~/.hidden_bashrc_output
slchoose R 2.15.2 gcc_64 >& ~/.hidden_bashrc_output
#find -L . -type l -delete >& ~/.hidden_bashrc_output &
find . -iname "*~" -exec rm '{}' ';' >& ~/.hidden_bashrc_output
#export LIBGL_ALWAYS_INDIRECT=yes

#Openstructure
installdir=/home/nij2003/openstructure
export PATH=$installdir/bin${PATH+:$PATH}
export LD_LIBRARY_PATH=$installdir/lib64:$installdir/lib${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}
alias ost_develop=$installdir/develop/stage/bin/ost
alias dng_develop=$installdir/develop/stage/bin/dng
alias ost_stable=$installdir/release-1.3.3/stage/bin/ost
alias dng_stable=$installdir/release-1.3.3/stage/bin/dng

alias modeller="~/programs/modeller"
alias catdcd="~/programs/catdcd"
alias Rscript="~/programs/Rscript"
alias R="~/programs/RR"
alias vmdrun="vmd -dispdev text -e"
#alias MATCH="~/programs/MATCH_RELEASE/MATCH/scripts/MATCH.pl"
export PATH=/home/jam2079/programs/MATCH_RELEASE/MATCH/scripts/:$PATH
export PerlChemistry=/home/jam2079/programs/MATCH_RELEASE/PerlChemistry
export MATCH=/home/jam2079/programs/MATCH_RELEASE/MATCH
alias xvfb="~/programs/xvfb_wrapper.sh"
alias getpdb="sh ~/programs/getpdb.sh"
alias prepareMD="sh ~/programs/prepareMD.sh"

alias ginit="sh ~/programs/ginit.sh"
alias gadd="git add ."
alias gcomm="git commit -m "
alias gpush="sh ~/programs/gpush.sh"
alias gstat="git status"
alias gpull="git pull"
alias glog="git log"
alias gcheckout="git checkout -- "
alias gsize="sh ~/programs/gsize.sh"
alias grecover="sh ~/programs/grecover.sh"

#alias panda="ssh jam2079"
alias panda2="ssh -X panda2.pbtech"
alias zeno="qlogin -l zeno=true"
alias fido="ssh -X fido"
alias nersc="ssh -X jmedina@carver.nersc.gov"
#echo ".bashrc executed"
