-- -*- lua -*-

prereq("openmpi")
conflict("OpenFOAM", "FOAM-extend")

whatis("OpenFOAM 2.3.x")

local version="2.3.x"
local foamRoot=os.getenv("HOME")

setenv("WM_PROJECT", "OpenFOAM")
setenv("WM_PROJECT_VERSION", version)
setenv("WM_PROJECT_INST_DIR", pathJoin(foamRoot, os.getenv("WM_PROJECT")))
setenv("WM_PROJECT_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), os.getenv("WM_PROJECT").."-"..version))
setenv("WM_THIRD_PARTY_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "ThirdParty-"..version))
setenv("WM_PROJECT_USER_DIR", pathJoin(os.getenv("HOME"), os.getenv("WM_PROJECT"), os.getenv("USER").."-"..version))
setenv("WM_DIR", pathJoin(os.getenv("WM_PROJECT_DIR"), "wmake"))

setenv("WM_ARCH", "linux64")
setenv("WM_ARCH_OPTION", "64")

setenv("WM_CC", os.getenv("CC"))
setenv("WM_CXX", os.getenv("CXX"))
setenv("WM_CFLAGS", "-O3 -fPIC")
setenv("WM_CXXFLAGS", "-O3 -fPIC")
setenv("WM_LDFLAGS", "-O3")

if (os.getenv("WM_CC") == "gcc") then
  setenv("WM_COMPILER", "Gcc")
elseif (os.getenv("WM_CC") == "icc") then
  setenv("WM_COMPILER", "Icc")
elseif (os.getenv("WM_CC") == "clang") then
  setenv("WM_COMPILER", "Clang")
end
setenv("WM_COMPILER_LIB_ARCH", os.getenv("WM_ARCH_OPTION"))
setenv("WM_COMPILE_OPTION", "Opt")

setenv("WM_PRECISION_OPTION", "DP")
setenv("WM_MPLIB", "SYSTEMOPENMPI")
setenv("WM_OSTYPE", "POSIX")
setenv("WM_OPTIONS", os.getenv("WM_ARCH")..os.getenv("WM_COMPILER")..os.getenv("WM_PRECISION_OPTION")..os.getenv("WM_COMPILE_OPTION"))

setenv("WM_LINK_LANGUAGE", "c++")
setenv("WM_NCOMPPROCS", capture("expr `nproc` / 2"))

setenv("BOOST_VERSION", "1_54_0")
setenv("BOOST_ARCH_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"),"platforms", os.getenv("WM_ARCH")..os.getenv("WM_COMPILER"), "boost_"..os.getenv("BOOST_VERSION")))
setenv("CGAL_VERSION", "4.7")
setenv("CGAL_ARCH_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "platforms", os.getenv("WM_ARCH")..os.getenv("WM_COMPILER"), "CGAL-"..os.getenv("CGAL_VERSION")))

setenv("FOAM_APPBIN", pathJoin(os.getenv("WM_PROJECT_DIR"), "platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("FOAM_APP", pathJoin(os.getenv("WM_PROJECT_DIR"), "applications"))
setenv("FOAM_EXT_LIBBIN", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "platforms", os.getenv("WM_OPTIONS"), "lib"))
setenv("FOAM_INST_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR")))
setenv("FOAM_JOB_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "jobControl"))
setenv("FOAM_LIBBIN", pathJoin(os.getenv("WM_PROJECT_DIR"), "platforms", os.getenv("WM_OPTIONS"), "lib"))
setenv("FOAM_MPI", "mpi")
setenv("FOAM_RUN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "run"))
setenv("FOAM_SETTINGS", "")
setenv("FOAM_SIGFPE", "")
setenv("FOAM_SITE_APPBIN", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "site", version, "platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("FOAM_SITE_LIBBIN", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "site", version, "platforms", os.getenv("WM_OPTIONS"), "lib"))
setenv("FOAM_SOLVERS", pathJoin(os.getenv("WM_PROJECT_DIR"), "applications/solvers"))
setenv("FOAM_SRC", pathJoin(os.getenv("WM_PROJECT_DIR"), "src"))
setenv("FOAM_TUTORIALS", pathJoin(os.getenv("WM_PROJECT_DIR"), "tutorials"))
setenv("FOAM_USER_APPBIN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("FOAM_USER_LIBBIN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "platforms", os.getenv("WM_OPTIONS"), "lib"))
setenv("FOAM_UTILITIES", pathJoin(os.getenv("WM_PROJECT_DIR"), "applications/utilities"))

-- MPI setup
setenv("MPI_ARCH_PATH", os.getenv("MPICH_HOME"))
setenv("MPI_BUFFER_SIZE", "20000000")
if (isloaded("openmpi")) then
  local PINC=capture("mpicc -showme:compile")
  local PLIBS=capture("mpicc -showme:link")
  setenv("PINC", PINC)
  setenv("PLIBS", PLIBS)
elseif (isloaded("mvapich2") or isloaded("mpich2")) then
  local PINC=capture("mpicc -show -cc= -nativelinking")
  local PLIBS=capture("mpicc -show -cc= | sed \"s%"..PINC.."%%\"")
  setenv("PINC", PINC)
  setenv("PLIBS", PLIBS)
end

-- PATH setup
prepend_path("PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "platforms", os.getenv("WM_ARCH")..os.getenv("WM_COMPILER"), "gperftools-svn/bin"))
prepend_path("PATH", os.getenv("FOAM_USER_APPBIN"))
prepend_path("PATH", os.getenv("FOAM_SITE_APPBIN"))
prepend_path("PATH", os.getenv("FOAM_APPBIN"))
prepend_path("PATH", pathJoin(os.getenv("WM_PROJECT_DIR"), "bin"))
prepend_path("PATH", os.getenv("WM_DIR"))

-- LD_LIBRARY_PATH setup
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("FOAM_LIBBIN"), "dummy"))
prepend_path("LD_LIBRARY_PATH", os.getenv("FOAM_EXT_LIBBIN"))
prepend_path("LD_LIBRARY_PATH", os.getenv("FOAM_LIBBIN"))
prepend_path("LD_LIBRARY_PATH", os.getenv("FOAM_SITE_LIBBIN"))
prepend_path("LD_LIBRARY_PATH", os.getenv("FOAM_USER_LIBBIN"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("FOAM_EXT_LIBBIN"), os.getenv("FOAM_MPI")))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("FOAM_LIBBIN"), os.getenv("FOAM_MPI")))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "platforms", os.getenv("WM_ARCH")..os.getenv("WM_COMPILER"), "gperftools-svn/lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("BOOST_ARCH_PATH"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("CGAL_ARCH_PATH"), "lib"))


-- Following alias is not working in sub shell so comment it out
-- set_alias("app", "cd "..os.getenv("FOAM_APP"))
-- set_alias("foam", "cd "..os.getenv("WM_PROJECT_DIR"))
-- set_alias("foam3rdParty", "cd "..os.getenv("WM_THIRD_PARTY_DIR"))
-- set_alias("foamApps", "cd "..os.getenv("FOAM_APP"))
-- set_alias("foamSite", "cd "..pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "site"))
-- set_alias("foamSol", "cd "..os.getenv("FOAM_SOLVERS"))
-- set_alias("foamTuts", "cd "..os.getenv("FOAM_TUTORIALS"))
-- set_alias("foamUtils", "cd "..os.getenv("FOAM_UTILITIES"))
-- set_alias("foamfv", "cd "..pathJoin(os.getenv("FOAM_SRC"), "finiteVolume"))
-- set_alias("foamsrc", "cd "..pathJoin(os.getenv("FOAM_SRC"), os.getenv("WM_PROJECT")))
-- set_alias("lib", "cd "..os.getenv("FOAM_LIBBIN"))
-- set_alias("run", "cd "..os.getenv("FOAM_RUN"))
-- set_alias("sol", "cd "..os.getenv("FOAM_SOLVERS"))
-- set_alias("src", "cd "..os.getenv("FOAM_SRC"))
-- set_alias("tut", "cd "..os.getenv("FOAM_TUTORIALS"))
-- set_alias("util", "cd "..os.getenv("FOAM_UTILITIES"))
-- set_alias("wm32", "wmSET WM_ARCH_OPTION=32")
-- set_alias("wm64", "wmSET WM_ARCH_OPTION=64")
-- set_alias("wmDP", "wmSET WM_PRECISION_OPTION=DP")
-- set_alias("wmREFRESH", "wmSET "..os.getenv("FOAM_SETTINGS"))
-- set_alias("wmSET", ". "..pathJoin(os.getenv("WM_PROJECT_DIR"), "etc/bashrc"))
-- set_alias("wmSP", "wmSET WM_PRECISION_OPTION=SP")
-- set_alias("wmSchedOFF", "unset WM_SCHEDULER")
-- set_alias("wmSchedON", "export WM_SCHEDULER="..pathJoin(os.getenv("WM_PROJECT_DIR"), "wmake/wmakeScheduler"))
-- set_alias("wmUNSET", ". "..pathJoin(os.getenv("WM_PROJECT_DIR"), "etc/config/unset.sh"))
