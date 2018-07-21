#
# ~/.bashrc
#

function source_if_exists() {
	[[ -f "$1" ]] && source "$1"
}

# firstly, source .bashrc provided by vendor
source_if_exists "$HOME/.bashrc.backup"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# To launch android sdk
#source /etc/profile
# For adb and fastboot
export PATH="$PATH:/opt/android-sdk/platform-tools"
# For Golang
export GOPATH="/home/zepp/build/go"
export PATH="$PATH:$GOPATH/bin"
# In yaourt, we can edit stuff with vim
export VISUAL=vim

export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'


# PS1='[\u@\h \W]\$ '
PS1='${arch_chroot:+($arch_chroot)}\[\033[01;33m\]\u\[\033[37m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# functions manipulates build flags
COMFLAGS="-Wall -g -O0"
function flags_clear() {
	export CFLAGS=""
	export CXXFLAGS=""
	export CC=""
	export CXX=""
}
function flags_gcc() {
	export CFLAGS="$COMFLAGS -std=c11"
	export CXXFLAGS="$COMFLAGS -std=c++14"
	export CC="gcc"
	export CXX="g++"
}
function flags_gcc() {
	export CFLAGS="$COMFLAGS -std=c11"
	export CXXFLAGS="$COMFLAGS -std=c++14"
	export CC="clang"
	export CXX="clang++"
}

# Some useful alias
alias ag='ag --follow'
alias ll='ls --color=auto -alh'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'
alias socks='ALL_PROXY=socks5://127.0.0.1:1080/ \
	http_proxy=http://127.0.0.1:8118/ \
	https_proxy=http://127.0.0.1:8118/ \
	HTTP_PROXY=http://127.0.0.1:8118/ \
	HTTPS_PROXY=http://127.0.0.1:8118/'
# conda
alias activate='source ~/Softwares/miniconda3/bin/activate'
alias deactivate='source ~/Softwares/miniconda3/bin/deactivate'

# Environment variables
# socks5 proxy for java-related app
#export _JAVA_OPTIONS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=1080"

## test
#if [ -n "$GTK_MODULES" ]; then
#    GTK_MODULES="${GTK_MODULES}:appmenu-gtk-module"
#else
#    GTK_MODULES="appmenu-gtk-module"
#fi
#
#if [ -z "$UBUNTU_MENUPROXY" ]; then
#    UBUNTU_MENUPROXY=1
#fi
#
#export GTK_MODULES
#export UBUNTU_MENUPROXY

# stack's suggestion
export PATH="$HOME/.local/bin:$PATH"
# bash completion for stack
type -P "stack" && eval "$(stack --bash-completion-script stack)"

# thefuck
command -v thefuck >/dev/null 2>&1 && \
	eval $(thefuck --alias)

## ros
#source_if_exists /opt/ros/kinetic/setup.bash
## catkin workspace
#source_if_exists ~/catkin_ws/devel/setup.bash
