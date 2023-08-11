#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# inline.sh - Replacing "source file" with its content

# Copyright 2023,  ntausnev@gmail.com
# All rights reserved.

# Usage: inline.sh [-h|--help] [-n]

# Revision history:
# 2023-04-28 Created by new_bash_script.sh ver. 3.3
# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"
#SCRIPT_DIR="/home/ntausnev/BASH_HOME/TNL_SCRIPTS"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
printf "SCRIPT_DIR=${SCRIPT_DIR}"

clean_up() { # Perform pre-exit housekeeping
	return
}

error_exit() {
	echo -e "${PROGNAME}: ${1:-"Unknown Error"}" >&2
	clean_up
	exit 1
}

graceful_exit() {
	clean_up
	exit
}

signal_exit() { # Handle trapped signals
	case $1 in
	INT)
		error_exit "Program interrupted by user"
		;;
	TERM)
		echo -e "\n$PROGNAME: Program terminated" >&2
		graceful_exit
		;;
	*)
		error_exit "$PROGNAME: Terminating on unknown signal"
		;;
	esac
}

usage() {
	echo -e "Usage: $PROGNAME fileIn"
}

help_message() {
	cat <<-_EOF_
		  $PROGNAME ver. $VERSION
		  Replacing "source file" with its content

		  $(usage)

		  Options:
		  -h, --help  Display this help message and exit.
		  -n

	_EOF_
	return
}

# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT" INT

# Main logic
while read line; do
	if [[ "$line" =~ (\.|source)\s+.+ ]]; then
		file="$(echo $line | cut -d' ' -f2)"
		echo "$(cat $file)"
	else
		echo "$line"
	fi
done <"$1"

graceful_exit

# vim: set filetype=shell: syntax=sh: cc=80 tw=79 ts=2 sw=2 sts=2 et sr
