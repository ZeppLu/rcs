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
PS1='${arch_chroot:+($arch_chroot)}\[\033[01;33m\]\u\[\033[01;30m\]@\h\[\033[37m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

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
function flags_clang() {
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

# stack's suggestion
export PATH="$HOME/.local/bin:$PATH"
# bash completion for stack
type -P "stack" && eval "$(stack --bash-completion-script stack)"

# thefuck
command -v thefuck >/dev/null 2>&1 && \
	eval $(thefuck --alias)

# ROS
if [ -f "$HOME/catkin_ws/devel/setup.bash" ]; then
	source "/opt/ros/melodic/setup.bash"
	source "$HOME/catkin_ws/devel/setup.bash"
	# for ROS too, copied from hawkbot's
	export ROS_PARALLEL_JOBS=-j1
	export ROS_MASTER_URI=http://10.42.0.1:11311
	export ROS_IP=10.42.0.73
fi

######################
# used on HuanbaoYuan
function huanbaoyuan_setup() {
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
			. "$HOME/anaconda3/etc/profile.d/conda.sh"
		else
			export PATH="$HOME/anaconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
	# <<< conda initialize <<<

	# --- cuda9.2.148 + cudnn7.6.3
	export PATH="$HOME/cuda-9.2/bin:$PATH"
	export LD_LIBRARY_PATH="$HOME/cuda-9.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:$HOME/cudnn-7.6.3/lib64"
	export CUDA_HOME="$HOME/cuda-9.2"
}

if [ -f "$HOME/.HUANBAOYUAN" ]; then
	huanbaoyuan_setup
fi
