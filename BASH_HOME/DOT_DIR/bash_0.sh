#bash_0.sh
# Note: there is no shebang in this script. This script sets my preferred shell
# configuration and should be able to be sourced from any Bash-like shell

# If we are not running interactively do not continue loading this file.
case $- in
*i*) ;;
*) return ;;
esac

#set -x
################################################################################
function get_os_name() {
        osname=$(cat /etc/os-release | grep "^NAME")
        echo ${osname#*\"} | {
                read b
                echo ${b%%\"*}
        } | awk '{ print $1  }'
}
export OS_NAME=$(get_os_name) # Fedora Oracle SLES
################################################################################

printf "\n%s\n" "START execution script init_bash.sh "
# Source any files in our ${DOT_DIR} folder.
if [ -r "${DOT_DIR}" ]; then

	cd "${DOT_DIR}" || {
		echo "Can't cd ${DOT_DIR}"
		exit 1
	}

	list_bash_src=(
		bash_modules.sh
		bash_ls_color.sh
		set_ps1_tnl.sh
		bash_prompt
		bash_profile
		bash_aliases_suse.sh
		bash_functions.sh
		bash_export.sh
    git_aliases.sh
	)
	#   pwd; ls -la
	echo "List bash files for sourcing: " 
	echo "${list_bash_src[@]} " | tr ' ' '\n'

	for shellfile in "${list_bash_src[@]}"; do
		printf "\n   %s\n" "shellfile= ${shellfile} will source "
		#       ls -la "./${shellfile}"
		[ -r "./$shellfile" ] && source "./$shellfile"
	done
	unset shellfile
fi

# Set our preferred editor (both visual and line mode to be safe).
EDITOR=vi
VISUAL=vi

# The code below is an example of a more sophisticated way to select the first
# available editor from a list of preferred editors:

# # Set our preferred editor to the first available editor in the array below.
# preferred_editors=(nano vi)
# for editor in ${preferred_editors[@]}; do
#     if command -v "${editor}" >/dev/null 2>&1; then
#         # Note that 'VISUAL' can be a full screen terminal editor. On legacy
#         # systems 'EDITOR' was normally a line mode editor but there is
#         # generally no need to differentiate any more.
#         VISUAL="$(command -v ${editor})"
#         EDITOR="${VISUAL}"
#         break
#     fi
# done
# unset editor preferred_editors

# Allow us to use Ctrl+S to perform forward search, by disabling the start and
# stop output control signals, which are not needed on modern systems.
stty -ixon

# Set a shell option but don't fail if it doesn't exist!
safe_set() { shopt -s "$1" >/dev/null 2>&1 || true; }

# Set some options to make working with folders a little easier. Note that we
# send all output to '/dev/null' as startup files should not write to the
# terminal and older shells might not have these options.
safe_set autocd      # Enter a folder name to 'cd' to it.
safe_set cdspell     # Fix minor spelling issues with 'cd'.
safe_set dirspell    # Fix minor spelling issues for commands.
safe_set cdable_vars # Allow 'cd varname' to switch directory.

# Uncomment the below if you want to be able to 'cd' into directories that are
# not just relative to the current location. For example, if the below was
# uncommented we could 'cd my_project' from anywhere if 'my_project' is in
# the 'repos' folder.
# CDPATH="~:~/repos"

# Configure the history to make it large and support multi-line commands.
safe_set histappend         # Don't overwrite the history file, append.
safe_set cmdhist            # Multi-line commands are one entry only.
PROMPT_COMMAND='history -a' # Before we prompt, save the history.
HISTSIZE=10000              # A large number of commands per session.
HISTFILESIZE=100000         # A huge number of commands in the file.
# HISTCONTROL="ignorespace:ignoredup" # Ignore starting with space or duplicates?
# export HISTIGNORE="ls:history"     # Any commands we want to not record?
# HISTTIMEFORMAT='%F %T '            # Do we want a timestamp for commands?

# Set the theme. Do not fail if the function doesn't exist.
set_ps1 "tnl" || true

# vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
################################################################################
