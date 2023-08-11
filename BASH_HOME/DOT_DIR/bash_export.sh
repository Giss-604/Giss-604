##!/usr/bin/env sh
#bash_export.sh
#
printf "\n  %s\n" "+++ Start source file bash_export.sh +++"
################################################################################
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib64"  # for ALL OS !!!
################################################################################

#export BASH_HOME="$HOME/BASH_HOME"
#export BASH_HOME="$HOME/.shell.d/BASH_HOME"
export TNL_BIN="${BASH_HOME}/bin"
export PATH="${PATH}:${TNL_BIN}"

export TNL_SCRIPTS="${BASH_HOME}/TNL_SCRIPTS"
export PATH="${PATH}:${TNL_SCRIPTS}"

export TNL_TIPS="${BASH_HOME}/TNL_TIPS"

alias rg="${TNL_BIN}/rg "
alias tree="${TNL_BIN}/tree "
alias dispus="${TNL_SCRIPTS}/dispus"
alias fd="${TNL_BIN}/fd "

alias cdi="fasd_cd -d -i "
alias cdf="fasd -sif "
#Fasd ships with the following useful default aliases:

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

#Problem get interactive
#eval "$(lua z.lua --init bash enhanced once echo)"
#alias cdi="z -i"
#alias cdp="z -b" # quickly cd to the parent directory

# use for instance LS_COLORS="$LS_COLORS:di=1;33" to get
# a nice readable bold orange text on black background:
LS_COLORS="$LS_COLORS:di=1;33"
#
# make grep highlight results using color
export GREP_OPTIONS='--color=auto'

# Add some colour to LESS/MAN pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
#
export MySysDir="$HOME/MySysDir"
#export TMPDIR="/tmp/${USERNAME}"   # Let ok to print

alias mpksh="more ${TNL_TIPS}/profile_ksh "
alias mtips="more ${TNL_TIPS}/mytips "
alias vtips="nvim ${TNL_TIPS}/mytips "

alias sbrc="source ~/.bashrc"
alias mbrc="more   ~/.bashrc"
alias vbrc="nvim   ~/.bashrc"

alias gbh="cd ${BASH_HOME}; ls"    # Go Bash Home
alias gbhb="cd ${TNL_BIN}; ls"     # Go Bash Home
alias gbhd="cd ${DOT_DIR}; ls"     # Go Bash Home
alias gbhs="cd ${TNL_SCRIPTS}; ls" # Go Bash Home
alias gbht="cd ${TNL_TIPS}; ls"    # Go Bash Home

alias gdot="cd ${DOT_DIR}; ls " # Go DOT dir
alias gdwn="cd ${HOME}/Downloads; ls"

################################################################################
################################################################################
function set_trash_dir() {
	case ${OS_NAME} in
	SLES) TRASH_DIR="${NOBACKUP}/Z_Deleted_Files" ;;
	Oracle) TRASH_DIR="${HOME}/TRASH_DIR" ;;
	Fedora) TRASH_DIR="${HOME}/TRASH_DIR" ;;
	*) echo "Unknown OS name in function set_trash_dir!!!" ;;
	esac
}
eval set_trash_dir
export TRASH_CLI="$HOME/trash-cli"
export TRASH_DIR=set_trash_dir

################################################################################
function set_os() {
	case ${OS_NAME} in
	SLES) set_SLES _ ;;
	Oracle) set_Oracle ;;
	Fedora) set_Fedora ;;
	*) echo "Unknown OS name  in set_rust!!!" ;;
	esac
} # end function set_os

################################################################################

################################################################################
################################################################################
################################################################################
################################################################################
function set_SLES() {
	alias wh_sles="echo -n 'SuSE ';cat /etc/SuSE-release | grep VERSION" # Version SuSE
	if [[ ${SLES_VERSION} = "12" ]]; then
		printf "     Include here some stuff for SLESS = 12"
	fi # [[ ${SLES_VERSION} = "12"  ]]

	export NOBACKUP="/discover/nobackup/${USERNAME}"
	export ARCHIVE="/archive/u/${USERNAME}"
	export CMRUNDIR="/discover/nobackup/ntausnev/RUNS_ME" # TNL

	export GODIR="${NOBACKUP}/GO" # for go_run
	export TRASH_DIR="${ZDIR}/Z_" # will append Trash

	export XCLIP_HOME="/usr/local/other/xclip/bin"
	export PATH="${XCLIP_HOME}:$PATH" # add xclip for nvim

	export RUST_HOME="/discover/nobackup/ntausnev/RUST_2"
	export TRASH_DIR="/discover/nobackup/ntausnev/Z_Deleted_Files"

	export PATH="${RUST_HOME}/rust/rustc/bin:$PATH" # rustc
	export PATH="${RUST_HOME}/rust/cargo/bin:$PATH" # cargo

	export LD_LIBRARY_PATH="${RUST_HOME}/rust/rustc/lib:$LD_LIBRARY_PATH"
} # end function set_SLES
################################################################################
function set_Oracle() {
	export RUST_HOME="/usr/bin"
	export TRASH_DIR="/home/ntausnev/TRASH_DIR"
	alias nvim="/usr/bin/nvim -c 'set guicursor=n-v-c-i:block' "
	alias ok="/usr/bin/okular "
	export P4merge="/opt/p4v-2023.2.2446649/bin"
	export PATH="$PATH:${P4merge}"
	export XXDIFF="/opt/xxdiff-5.1/bin"
	export PATH="$PATH:${XXDIFF}"
        
} # end function set_Oracle
################################################################################
function set_Fedora() {
	export RUST_HOME="/usr/bin"
	export TRASH_DIR="/home/ntausnev/TRASH_DIR"
	export P4merge="/opt/p4merge/bin"
	export PATH="$PATH:${P4merge}"
	export TMPDIR="/tmp/" # It requires git difftool with P4merge
	export PATH="/home/tnl/.local/bin:$PATH"

	alias nvim="/usr/bin/nvim -c 'set guicursor=n-v-c-i:block' "
	alias ok="/usr/bin/okular "
} # end function set_Fedora
################################################################################
################################################################################
#
set_os
#eval "$(fasd --init auto)" # The same as Fedora???
#
printf "\n  %s\n" "+++ Ended source file bash_export.sh +++"
################################################################################
#vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
################################################################################
