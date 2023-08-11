#!/bin/ksh
#
# SCRIPT: mail2local.ksh
USAGE=" $0 name_file [name_file ...]"
# AUTHOR: Nick Tausnev, ntausnev@giss.nasa.gov
# DATE:   Jan 14  2005
# REV:    1.1.A (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: (SPECIFY: AIX, HP-UX, Linux, Solaris
#                      or Not platform dependent)
#
# PURPOSE: Send file to  mail
#
# REV LIST:
#        DATE: DATE_of_REVISION
#        BY:      AUTHOR_of_MODIFICATION
#        MODIFICATION: Describe what was modified, new features, etc-
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################

TEMP_DIR=/tmp/ntausnev
TEMP_DIR=${TMPDIR}              # from .profile
mkdir -p ${TEMP_DIR}
SCRIPTS_DIR=/home/ntausnev/BASH_HOME/TNL_SCRIPTS  # CHANGE !!!!
ACK_CMD="perl ${SCRIPTS_DIR}/ack.pl "

##########################################################
############### DEFINE FUNCTIONS HERE ####################
##########################################################

##########################################################
################ BEGINNING OF MAIN #######################
##########################################################

print "##################################################################################"
print "\n            $0                                       "
print "\nScript \"   $0   \" starts: ==========> "

if (( $# < 1 ))
then
    print "\nABORT: You should supply name(s) of file(s)"
    print "USAGE: $USAGE"
    print "\n"
    exit 1
fi

#file=$1
file_sent=""
randNum=$RANDOM # Generate random number for indefication file

for file in $*
do
   file_name=$(basename $file)
   if [[ $file = ${file_name} ]]
   then
      abs_path=$PWD/$file
   else
      abs_path=$file
   fi

   if [[ ! -f $file  || ! -s $file ]]
   then
      print "File \"$file\" does not exit or empty: ls -la $file "
      ls -la $file
      print "#### Can't find file:\n ${abs_path}\nto send to local machine ####"
      print "#### Skip this file ###\n"
   fi

   file_num=${abs_path}__${randNum}
   file_ps=${file_num}.ps
   file_pdf=${file_num}.pdf
   file_pages=${abs_num}.pages
   name_file2send=$(basename $file_num)

   # Insert number each 10th lines:
   ${SCRIPTS_DIR}/add_num.pl ${abs_path} > ${file_num}

   suffix=${abs_path##*.}
   if [[ $suffix = f || $suffix = f90  \
      || $suffix = F || $suffix = F90 || $suffix = h ]]
    then
     perl ${SCRIPTS_DIR}/insertPagesInFile.pl ${file_num} ${file_pages}
     mv ${file_pages} ${file_num}
     print "" >> ${file_num}
     print "List of program | module(s) | subroutine(s) | function(s) at file ${file_name}:" >> ${file_num}
     ${ACK_CMD} -H -i --nocolor '^\s*(program|module|subroutine|function)' ${file_name} |  \
                sort +2 | awk ' { print " " $0; print ""; }' >> ${file_num}
   fi

   if [[ $suffix = ksh ]]
   then
     pretty_print="--pretty-print=ksh"
   fi

   if [[ $suffix = pl ]]
   then
     pretty_print="--pretty-print=perl"
   fi


   chmod ug+rw ${file_num}

# --margins=left:right:top:bottom
#
    pretty_print=" "
    enscript -p${file_ps}  ${pretty_print} \
    --font=Courier-Bold11 \
    --header-font=Courier6  \
    --underlay="NASA/GISS" --ul-gray=0.95 --ul-style=filled \
              --ul-font=Times-Roman120 --ul-position='+90-150' \
    --fancy=a2ps --borders \
    --lines-per-page=55 \
    --mark-wrapped-lines=arrow \
    --margins=12:12:20:20 \
    --landscape \
    ${file_num}
   chmod ug+rw ${file_ps}
   /usr/bin/ps2pdf ${file_ps} ${file_pdf}
   chmod ug+rw ${file_pdf}

# insert before the first line of ps file:
#   perl -i -ple  \
#    "print q{<--- CUT HERE above to start ${name_file2send} --->} if $.==1;
#      close ARGV if eof " ${file_ps}

# insert after the last line of ps pile:
# print "<--- CUT HERE below to end ${name_file2send} --->" >> ${file_ps}

#  command="cat ${file_ps} | Mail -s ${name_file2send} nick@poncho.giss.nasa.gov"
   command="cat ${file_ps} | Mail -s ${name_file2send} -a ${file_ps} ntausnev@gmail.com"
   command="echo SeeAttachment | Mail -s ${name_file2send} -a ${file_ps} ntausnev@gmail.com"
   command="echo SeeAttachment | Mail -s ${name_file2send} -a ${file_pdf} ntausnev@gmail.com"
   print "Now execute : $command  ... "
   eval $command
   file_sent="$file_sent ${name_file2send}"
#  \rm -f ${file_ps} ${file_num}
   \rm -f  ${file_num}
   print "file_ps=${file_ps}"
   print "file_pdf=${file_pdf}"

#  \rm -f ${file_prt}
done
print "\nNext files sent to local machine by mail for printing:"
print " $file_sent"

print "\nGet printing on Local ACES machine\n export PRINTER=BANDW6;\n print4mail $file_sent"

print "\nScript \"  $0  \" ended : <========== \n"
# End of script

