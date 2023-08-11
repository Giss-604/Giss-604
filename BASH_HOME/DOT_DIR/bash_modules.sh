#
printf "\n  %s\n" "+++ Start source  bash_modules.sh +++"

USERNAME="$(logname)" # has problem when start job from qsub on discover
export USERNAME

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib64"

SLES_VERSION_CURRENT="12"
SLES_VERSION=$(lsb_release -a | grep Release: | awk '{ print $2 }' | cut -d. -f1)
if [[ ${SLES_VERSION} = ${SLES_VERSION_CURRENT} ]]; then

	# export USERNAME="$(logname)" # has problem when start job from qsub on discover
	export USERNAME="ntausnev" # TNL this a temporary fix
	export NOBACKUP="/discover/nobackup/${USERNAME}"

	##############
	##          ##
	##  MODULES ##
	##          ##
	##############
	#
	# module show module_examp;e # shows details about the module

	#source  "${MODULESHOME}/init/bash"  # complain so use hardwrting:
	source /usr/share/lmod/lmod/init/bash

	PATH="/usr/slurm/bin:/usr/local/bin:/bin:/usr/bin:." # ???

	module purge

	printf "\n +++ SLES version is %s %s" "${SLES_VERSION}" " +++ "

	module load vim/8.1.2233

	### NCO lines start ###
	module load nco/5.1.4 # 03.10.2023
	NCO_HOME="/usr/local/other/nco/5.1.4/bin"
	export PATH=$PATH:${NCO_HOME}/bin
	export MANPATH=$MANPATH:${NCO_HOME}/man
	### NCO   lines end   ###

	module load comp/intel/2021.4.0
	#module load mpi/impi/2021.3.0
	module load mpi/impi/2021.4.0 # 03.10.2023

	module load netcdf4/4.8.1-serial
	export NETCDF_HOME="/gpfsm/dulocal/sles12/other/netcdf4/4.7.2/gcc-9.2"

	### CDO lines start ###
	module load cdo/1.9.10                            # 06.15.22
	export CDO_HOME="/usr/local/other/cdo/1.9.10/bin" # 06.15.22 - 17:23
	alias cdo="${CDO_HOME}/cdo "
	function cdog { # cdo grid shows
		local nameFileCDF=$1
		"${CDO_HOME}"/cdo infon "${nameFileCDF}" | more
	}
	### CDO   lines end   ###

	module load git/2.39.2

	module load arm-forge/21.1.2

	module load ferret/7.6.0
	alias ferret="/usr/local/other/ferret/Ferret-7.6.0-RHEL7/bin/ferret"

	module load python/GEOSpyD/Ana2019.10_py3.7
	#module load python/GEOSpyD/Min4.11.0_py3.9
	############################### NEED WORK ################################
	PATH=$PATH:/usr/local/other/python/GEOSpyD/2019.10_py3.7/2020-01-15/bin
	############################### NEED WORK ################################

	module load xxdiff/4.0.1
	alias xdiff="/gpfsm/dulocal/sles12/other/xxdiff/4.0.1/bin/xxdiff"

	module load meld/3.18.2
	module load ncview/2.1.7

	module load panoply/5.0.6

	module list

	# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/other/netcdf/4.1.2_intel-14.0.3/lib # share library
	PATH=$PATH:${NETCDF_HOME}/bin
	export MPI_HOME="???"

	### NCARG lines start ###
	#export NCARG_ROOT=/usr/local/other/ncl/5.1.1_intel-11.1.038  # idt did not work
	export NCARG_ROOT="/usr/local/other/ncl/6.6.2" # ???
	PATH="$PATH:${NCARG_ROOT}/bin"
	#   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/other/baselibs/v2_2r2_9.1.042.meta_new/Linux/lib # for idt
	### NCARG lines end   ###

	### CDAT lines start ###
	export CDAT_HOME="/usr/local/other/Cdat/5.2"
	PATH=$PATH:${CDAT_HOME}/bin
	function my_vcdat { # check out current modelE
		#  USAGE= my_vcdat name_dir
		local local_var
		local_var=${LD_LIBRARY_PATH}
		unset LD_LIBRARY_PATH

		export LD_LIBRARY_PATH="${CDAT_HOME}/lib:$LD_LIBRARY_PATH"
		export LD_LIBRARY_PATH="${CDAT_HOME}/Externals/lib:$LD_LIBRARY_PATH"
		vcdat
		export LD_LIBRARY_PATH="${local_var}"
	} # end function  my_vcdat
	######################################
	### CDAT lines end   ###
	#
	##
	PATH=$PATH:/discover/nobackup/projects/giss/exec                  # Reto's stuff
	alias goif="cd /discover/nobackup/projects/giss/prod_input_files" # go input files

fi # end if [[ ${SLES_VERSION} = "12" ]]



printf "\n  %s\n" "+++ Ended source file bash_modules.sh +++"
# vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
#
