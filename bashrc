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

# PS1='[\u@\h \W]\$ '
PS1='${arch_chroot:+($arch_chroot)}\[\033[01;33m\]\u\[\033[01;30m\]@\h\[\033[37m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# In yaourt, we can edit stuff with vim
export VISUAL=vim

# functions manipulates build flags
COMFLAGS="-Wall -g -O0"
function flags_clear() {
	export CFLAGS=""
	export CXXFLAGS=""
	export CC=""
	export CXX=""
}
function flags_gcc() {
	export CFLAGS="$COMFLAGS -std=c17"
	export CXXFLAGS="$COMFLAGS -std=c++17"
	export CC="gcc"
	export CXX="g++"
}
function flags_clang() {
	export CFLAGS="$COMFLAGS -std=c17"
	export CXXFLAGS="$COMFLAGS -std=c++17"
	export CC="clang"
	export CXX="clang++"
}

# Some useful alias
alias ag='ag --follow'
alias ll='ls --color=auto -alh'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias tree='tree -C'  # -C enforce colorization on pipe
HOST="127.0.0.1"
SOCKS5_PORT=10808
HTTP_PORT=10809
alias proxy="ALL_PROXY=socks5://$HOST:$SOCKS5_PORT/ \
	http_proxy=http://$HOST:$HTTP_PORT/ \
	https_proxy=http://$HOST:$HTTP_PORT/ \
	HTTP_PROXY=http://$HOST:$HTTP_PORT/ \
	HTTPS_PROXY=http://$HOST:$HTTP_PORT/ \
	JAVA_OPTIONS=\"-DsocksProxyHost=$HOST -DsocksProxyPort=$SOCKS5_PORT\""
unset HOST
unset SOCKS5_PORT
unset HTTP_PORT


function check_command() {
	command -v "$1" >/dev/null 2>&1
}

# bash completion for stack
check_command "stack" && eval "$(stack --bash-completion-script stack)"

# thefuck
check_command "thefuck" && eval $(thefuck --alias)

# ROS
check_command "catkin_make" && {
	source "/opt/ros/melodic/setup.bash"
	source "$HOME/catkin_ws/devel/setup.bash"
	# see https://wiki.ros.org/ROS/EnvironmentVariables#ROS_PARALLEL_JOBS
	export ROS_PARALLEL_JOBS="-j4 -l4"
	# actual uri & ip set in .bachrc_not_synced
	export ROS_MASTER_URI=http://255.255.255.255:11311
	export ROS_IP=255.255.255.255
}

# Gazebo
check_command "gzserver" && {
	source "/usr/share/gazebo/setup.sh"
	export GAZEBO_MODEL_DATABASE_URI=http://models.gazebosim.org
	export GAZEBO_MODEL_PATH="$HOME/Documents/gazebo-9/models"
}

# include platform specific bashrcs
source_if_exists "$HOME/.bashrc_local"

