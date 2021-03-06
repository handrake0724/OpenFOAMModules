#%Module########################################################################
##
## openfoam modulefile
##
proc ModulesHelp { } {
   global version foamRoot COMPILER

   puts stderr " This module defines environment variables, aliases and add PATH, LD_LIBRARY_PATH for OpenFOAM"
   puts stderr "
   Version $version
   "
}

prereq   openmpi
conflict OpenFOAM FOAM-extend

module-whatis "OpenFOAM 2.3.x"

# for Tcl script use only

set              version                   "2.3.x"
set              majorVersion              "[lindex [split $version .] 0]"
set              foamRoot                  "$env(HOME)"

setenv WM_PROJECT                          "OpenFOAM"
setenv WM_PROJECT_VERSION                  "$version"
setenv WM_COMPILER                         "$env(COMPILER_OF_TYPE)"
setenv WM_COMPILE_OPTION                   "Opt"
setenv WM_ARCH                             "linux64"
setenv WM_ARCH_OPTION                      "64"
setenv WM_PRECISION_OPTION                 "DP"
setenv WM_MPLIB                            "SYSTEMOPENMPI"
setenv WM_OSTYPE                           "POSIX"

setenv WM_PROJECT_INST_DIR                 "$foamRoot/$env(WM_PROJECT)"
setenv WM_PROJECT_DIR                      "$env(WM_PROJECT_INST_DIR)/OpenFOAM-$version"
#setenv WM_THIRD_PARTY_DIR                  $env(WM_PROJECT_INST_DIR)/ThirdParty-$version
setenv WM_THIRD_PARTY_DIR                  "$env(WM_PROJECT_INST_DIR)/ThirdParty-$majorVersion"
setenv WM_PROJECT_USER_DIR                 "$env(HOME)/$env(WM_PROJECT)/$env(USER)-$version"
setenv WM_DIR                              "$env(WM_PROJECT_DIR)/wmake"

setenv WM_COMPILER_LIB_ARCH                "$env(WM_ARCH_OPTION)"
setenv WM_CC                               "$env(CC)"
setenv WM_CXX                              "$env(CXX)"
setenv WM_CFLAGS                           "-O3 -fPIC"
setenv WM_CXXFLAGS                         "-O3 -fPIC"
setenv WM_LDFLAGS                          "-O3"
setenv WM_LINK_LANGUAGE                    "c++"
setenv WM_OPTIONS                          "$env(WM_ARCH)$env(WM_COMPILER)$env(WM_PRECISION_OPTION)$env(WM_COMPILE_OPTION)"
setenv WM_NCOMPPROCS                       "[exec expr [exec nproc] / 2]"

setenv BOOST_VERSION                       "1_54_0"
setenv BOOST_ARCH_PATH                     "$env(WM_THIRD_PARTY_DIR)/platforms/$env(WM_ARCH)$env(WM_COMPILER)/boost_$env(BOOST_VERSION)"
setenv CGAL_VERSION                        "4.7"
setenv CGAL_ARCH_PATH                      "$env(WM_THIRD_PARTY_DIR)/platforms/$env(WM_ARCH)$env(WM_COMPILER)/CGAL-$env(CGAL_VERSION)"

setenv FOAM_APPBIN                         "$env(WM_PROJECT_DIR)/platforms/$env(WM_OPTIONS)/bin"
setenv FOAM_APP                            "$env(WM_PROJECT_DIR)/applications"
setenv FOAM_EXT_LIBBIN                     "$env(WM_THIRD_PARTY_DIR)/platforms/$env(WM_OPTIONS)/lib"
setenv FOAM_INST_DIR                       "$env(WM_PROJECT_INST_DIR)"
setenv FOAM_JOB_DIR                        "$env(WM_PROJECT_INST_DIR)/jobControl"
setenv FOAM_LIBBIN                         "$env(WM_PROJECT_DIR)/platforms/$env(WM_OPTIONS)/lib"
setenv FOAM_MPI                            "mpi"
setenv FOAM_RUN                            "$env(WM_PROJECT_USER_DIR)/run"
setenv FOAM_SETTINGS                       ""
setenv FOAM_SIGFPE                         ""
setenv FOAM_SITE_APPBIN                    "$env(WM_PROJECT_INST_DIR)/site/$version/platforms/$env(WM_OPTIONS)/bin"
setenv FOAM_SITE_LIBBIN                    "$env(WM_PROJECT_INST_DIR)/site/$version/platforms/$env(WM_OPTIONS)/lib"
setenv FOAM_SOLVERS                        "$env(WM_PROJECT_DIR)/applications/solvers"
setenv FOAM_SRC                            "$env(WM_PROJECT_DIR)/src"
setenv FOAM_TUTORIALS                      "$env(WM_PROJECT_DIR)/tutorials"
setenv FOAM_USER_APPBIN                    "$env(WM_PROJECT_USER_DIR)/platforms/$env(WM_OPTIONS)/bin"
setenv FOAM_USER_LIBBIN                    "$env(WM_PROJECT_USER_DIR)/platforms/$env(WM_OPTIONS)/lib"
setenv FOAM_UTILITIES                      "$env(WM_PROJECT_DIR)/applications/utilities"

setenv MPI_ARCH_PATH                       "$env(MPICH_HOME)"
setenv MPI_BUFFER_SIZE                     "20000000"
setenv PINC                                "[exec mpicc -show -cc= -nativelinking]"
setenv PLIBS                               "[exec mpicc -show -cc= | sed "s%$env(PINC)%%"]"

prepend-path PATH                          "$env(WM_THIRD_PARTY_DIR)/platforms/$env(WM_ARCH)$env(WM_COMPILER)/gperftools-svn/bin"
prepend-path PATH                          "$env(FOAM_APPBIN)"
prepend-path PATH                          "$env(FOAM_SITE_APPBIN)"
prepend-path PATH                          "$env(FOAM_USER_APPBIN)"
prepend-path PATH                          "$env(WM_PROJECT_DIR)/bin"
prepend-path PATH                          "$env(WM_DIR)"

prepend-path LD_LIBRARY_PATH               "$env(FOAM_LIBBIN)/dummy"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_EXT_LIBBIN)"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_LIBBIN)"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_SITE_LIBBIN)"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_USER_LIBBIN)"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_EXT_LIBBIN)/$env(FOAM_MPI)"
prepend-path LD_LIBRARY_PATH               "$env(FOAM_LIBBIN)/$env(FOAM_MPI)"
prepend-path LD_LIBRARY_PATH               "$env(WM_THIRD_PARTY_DIR)/platforms/$env(WM_ARCH)$env(WM_COMPILER)/gperftools-svn/lib"
prepend-path LD_LIBRARY_PATH               "$env(BOOST_ARCH_PATH)/lib"
prepend-path LD_LIBRARY_PATH               "$env(CGAL_ARCH_PATH)/lib"


# Following alias is not working in sub shell so comment it out
#set-alias app               "cd $env(FOAM_APP)"
#set-alias foam              "cd $env(WM_PROJECT_DIR)"
#set-alias foam3rdParty      "cd $env(WM_THIRD_PARTY_DIR)"
#set-alias foamApps          "cd $env(FOAM_APP)"
#set-alias foamSite          "cd $env(WM_PROJECT_INST_DIR)/site"
#set-alias foamSol           "cd $env(FOAM_SOLVERS)"
#set-alias foamTuts          "cd $env(FOAM_TUTORIALS)"
#set-alias foamUtils         "cd $env(FOAM_UTILITIES)"
#set-alias foamfv            "cd $env(FOAM_SRC)/finiteVolume"
#set-alias foamsrc           "cd $env(FOAM_SRC)/$env(WM_PROJECT)"
#set-alias lib               "cd $env(FOAM_LIBBIN)"
#set-alias run               "cd $env(FOAM_RUN)"
#set-alias sol               "cd $env(FOAM_SOLVERS)"
#set-alias src               "cd $env(FOAM_SRC)"
#set-alias tut               "cd $env(FOAM_TUTORIALS)"
#set-alias util              "cd $env(FOAM_UTILITIES)"
#set-alias wm32              "wmSET WM_ARCH_OPTION=32"
#set-alias wm64              "wmSET WM_ARCH_OPTION=64"
#set-alias wmDP              "wmSET WM_PRECISION_OPTION=DP"
#set-alias wmSET             ". $env(WM_PROJECT_DIR)/etc/bashrc"
#set-alias wmSP              "wmSET WM_PRECISION_OPTION=SP"
#set-alias wmSchedOFF        "unset WM_SCHEDULER"
#set-alias wmSchedON         "export WM_SCHEDULER=$env(WM_PROJECT_DIR)/wmake/wmakeScheduler"
#set-alias wmUNSET           ". $env(WM_PROJECT_DIR)/etc/config/unset.sh"
