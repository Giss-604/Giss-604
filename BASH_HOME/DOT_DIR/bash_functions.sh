# bash_functions.sh
# Note: this script should be sourced into your shell. For this reason it does
# not specify a shebang.
#
printf "\n  %s\n" "+++ Start source file bash_functions.sh +++"

############################################################i###################
# show PATH elements one per line
#
function path {
	printf "$PATH" | tr ':' '\n'
	printf "\n"
} # end function path
############################################################i###################
function print_path_nice {
	echo "$PATH" | sed 's/:/\n/g' | sort | uniq -c
}

# Removing Duplicate PATH Entries:
function clean_up_path() {
	local _PATH=$PATH
	echo -n "$_PATH" | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}'
} # end function clean_up_path
############################################################i###################
function lib_path { # show PATH elements one per line
	printf "%s\n" "$LD_LIBRARY_PATH" | tr ':' '\n'
} # end function lib_path
############################################################i###################

# Bash Function To Extract File Archives Of Various Types
function extract() {
	if [ -f "$1" ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) rar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
			#            *.tgz)       tar xzf $1     ;;
		*.tgz) tar zxvf $1 ;;
		*.xz) tar xJf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "$1" " Cannot be extracted via extract()" ;;
		esac
	else
		echo "$1" " is not a valid file"
	fi
}
################################################################################

function print_array() {
	# run through array and print each entry:
	#usage:
	#print_array "${array_name[@]}"
	#
	#example:
	#array01=(one two three)
	#print_array "${array01[@]}"
	#echo "this should be a new line"
	#
	#output:
	#one two three
	#this should be a new line
	local array
	array=("$@")
	for i in "${array[@]}"; do
		printf '%s ' "$i"
	done
	# print a new line
	printf '\n'
}

# Sometimes I need to look for a file object of the command and not for the
# command itself; so I wrote a little function:
function cmd {
	# USAGE: cmd patern from_last_lines history
	history 999 | tail -${2:-999} | awk -v tofind=${1:-[0-9]} '($0!~/ cmd /) &&
    ($0~tofind) { print }'
}

printf "\n  %s\n" "+++ Ended source file bash_functions.sh +++"
################################################################################
function gac () {
  # Usage: gac [files] [message]
  # gac (git add commit) stages files specified by the first argument
  # and commits the changes with a message specified by the second argument.
  # Using quotes one can add multiple files at once: gac "file1 file2" "Message".
  git add $1 && git commit -m "$2"
}
################################################################################
function kde_ver () {
   kf5-config --version
   plasmashell --version
   # plasma-desktop --version
   konsole --version
} # end  kde_version
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
# vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
################################################################################
#
