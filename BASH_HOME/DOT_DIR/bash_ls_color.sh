##!/usr/bin/env sh
#
printf "\n  %s\n" "+++ Start source file bash_ls_color.sh  +++"

function show_dircolors() {
	############################################################i###################
	for i in 00{2..8} {0{3,4,9},10}{0..7}; do
		echo -e "$i \e[0;${i}mSubdermatoglyphic text\e[00m  \e[1;${i}mSubdermatoglyphic text\e[00m"
	done

	for i in 00{2..8} {0{3,4,9},10}{0..7}; do
		for j in 0 1; do
			echo -e "$j;$i \e[$j;${i}mSubdermatoglyphic text\e[00m"
		done
	done
}
show_dircolors
dir_colors_file="${HOME}/z_trash/dir_colors_file"
dircolors --print-database > ${dir_colors_file}
printf "Now edit file temp or copy temp to .dircolors"
# edit vi temp  #
eval $(dircolors -b ${dir_colors_file})
ls --color=auto $HOME

printf "\nLS_COLORS:"
printf " $LS_COLORS"

printf "\n  %s\n" "+++ Ended source file bash_ls_color.sh  +++"
###################################################################################
# vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
#
