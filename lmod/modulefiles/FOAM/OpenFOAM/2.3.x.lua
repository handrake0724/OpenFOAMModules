-- -*- lua -*-

prereq("openmpi")
conflict("OpenFOAM", "FOAM-extend")

whatis("OpenFOAM 2.3.x")

local version="2.3.x"
local foamRoot=os.getenv("HOME")

local wm_project="OpenFOAM"
local wm_project_version=version
local wm_project_inst_dir=pathJoin(foamRoot, wm_project)
local wm_project_dir=pathJoin(wm_project_inst_dir, wm_project.."-"..version)
local wm_third_party_dir=pathJoin(wm_project_inst_dir, "ThirdParty-"..version)
local wm_project_user_dir=pathJoin(os.getenv("HOME"), wm_project, os.getenv("USER").."-"..version)
local wm_dir=pathJoin(wm_project_dir, "wmake")

local wm_arch="linux64"
local wm_arch_option="64"

local wm_cc=os.getenv("CC")
local wm_cxx=os.getenv("CXX")
local wm_cflags="-O3 -fPIC"
local wm_cxxflags="-O3 -fPIC"
local wm_ldflags="-O3"

local wm_compiler
if (wm_cc == "gcc") then
  wm_compiler="Gcc"
elseif (wm_cc == "icc") then
  wm_compiler="Icc"
elseif (os.getenv("WM_CC") == "clang") then
  wm_compiler="Clang"
end

local wm_compiler_lib_arch=wm_arch_option
local wm_compile_option="Opt"

local wm_precision_option="DP"
local wm_mplib="SYSTEMOPENMPI"
local wm_ostype="POSIX"
local wm_options=wm_arch..wm_compiler..wm_precision_option..wm_compile_option

local wm_link_language="c++"
local wm_ncompprocs=capture("expr `nproc` / 2")

local boost_version="1_54_0"
local boost_arch_path=pathJoin(wm_third_party_dir,"platforms", wm_arch..wm_compiler, "boost_"..boost_version)
local cgal_version="4.7"
local cgal_arch_path=pathJoin(wm_third_party_dir, "platforms", wm_arch..wm_compiler, "CGAL-"..cgal_version)

local foam_appbin=pathJoin(wm_project_dir, "platforms", wm_options, "bin")
local foam_app=pathJoin(wm_project_dir, "applications")
local foam_ext_libbin=pathJoin(wm_third_party_dir, "platforms", wm_options, "lib")
local foam_inst_dir=pathJoin(wm_project_inst_dir)
local foam_job_dir=pathJoin(wm_project_inst_dir, "jobControl")
local foam_libbin=pathJoin(wm_project_dir, "platforms", wm_options, "lib")
local foam_mpi="mpi"
local foam_run=pathJoin(wm_project_user_dir, "run")
local foam_settings=""
local foam_sigfpe=""
local foam_site_appbin=pathJoin(wm_project_inst_dir, "site", version, "platforms", wm_options, "bin")
local foam_site_libbin=pathJoin(wm_project_inst_dir, "site", version, "platforms", wm_options, "lib")
local foam_solvers=pathJoin(wm_project_dir, "applications/solvers")
local foam_src=pathJoin(wm_project_dir, "src")
local foam_tutorials=pathJoin(wm_project_dir, "tutorials")
local foam_user_appbin=pathJoin(wm_project_user_dir, "platforms", wm_options, "bin")
local foam_user_libbin=pathJoin(wm_project_user_dir, "platforms", wm_options, "lib")
local foam_utilities=pathJoin(wm_project_dir, "applications/utilities")

local mpi_arch_path=os.getenv("MPICH_HOME")
local mpi_buffer_size="20000000"

local pinc
local plibs
if (isloaded("openmpi")) then
  pinc=capture("mpicc -showme:compile")
  plibs=capture("mpicc -showme:link")
elseif (isloaded("mvapich2") or isloaded("mpich2")) then
  pinc=capture("mpicc -show -cc= -nativelinking")
  plibs=capture("mpicc -show -cc= "):gsub("-I.*/include", " ")
end
-- setup environment variables
setenv("WM_PROJECT", wm_project)
setenv("WM_PROJECT_VERSION", wm_project_version)
setenv("WM_PROJECT_INST_DIR", wm_project_inst_dir)
setenv("WM_PROJECT_DIR", wm_project_dir)
setenv("WM_THIRD_PARTY_DIR", wm_third_party_dir)
setenv("WM_PROJECT_USER_DIR", wm_project_user_dir)
setenv("WM_DIR", wm_dir)

setenv("WM_ARCH", wm_arch)
setenv("WM_ARCH_OPTION", wm_arch_option)

setenv("WM_CC", wm_cc)
setenv("WM_CXX", wm_cxx)
setenv("WM_CFLAGS", wm_cflags)
setenv("WM_CXXFLAGS", wm_cxxflags)
setenv("WM_LDFLAGS", wm_ldflags)
setenv("WM_COMPILER", wm_compiler)

setenv("WM_COMPILER_LIB_ARCH", wm_compiler_lib_arch)
setenv("WM_COMPILE_OPTION", wm_compile_option)

setenv("WM_PRECISION_OPTION", wm_precision_option)
setenv("WM_MPLIB", wm_mplib)
setenv("WM_OSTYPE", wm_ostype)
setenv("WM_OPTIONS", wm_options)

setenv("WM_LINK_LANGUAGE", wm_link_language)
setenv("WM_NCOMPPROCS", wm_ncompprocs)

setenv("BOOST_VERSION", boost_version)
setenv("BOOST_ARCH_PATH", boost_arch_path)
setenv("CGAL_VERSION", cgal_version)
setenv("CGAL_ARCH_PATH", cgal_arch_path)

setenv("FOAM_APPBIN", foam_appbin)
setenv("FOAM_APP", foam_app)
setenv("FOAM_EXT_LIBBIN", foam_ext_libbin)
setenv("FOAM_INST_DIR", foam_inst_dir)
setenv("FOAM_JOB_DIR", foam_job_dir)
setenv("FOAM_LIBBIN", foam_libbin)
setenv("FOAM_MPI", foam_mpi)
setenv("FOAM_RUN", foam_run)
setenv("FOAM_SETTINGS", foam_settings)
setenv("FOAM_SIGFPE", foam_sigfpe)
setenv("FOAM_SITE_APPBIN", foam_site_appbin)
setenv("FOAM_SITE_LIBBIN", foam_site_libbin)
setenv("FOAM_SOLVERS", foam_solvers)
setenv("FOAM_SRC", foam_src)
setenv("FOAM_TUTORIALS", foam_tutorials)
setenv("FOAM_USER_APPBIN", foam_user_appbin)
setenv("FOAM_USER_LIBBIN", foam_user_libbin)
setenv("FOAM_UTILITIES", foam_utilities)

-- MPI setup
setenv("MPI_ARCH_PATH", mpi_arch_path)
setenv("MPI_BUFFER_SIZE", mpi_buffer_size)
setenv("PINC", pinc)
setenv("PLIBS", plibs)

-- PATH setup
prepend_path("PATH", pathJoin(wm_third_party_dir, "platforms", wm_arch..wm_compiler, "gperftools-svn/bin"))
prepend_path("PATH", foam_user_appbin)
prepend_path("PATH", foam_site_appbin)
prepend_path("PATH", foam_appbin)
prepend_path("PATH", pathJoin(wm_project_dir, "bin"))
prepend_path("PATH", wm_dir)

-- LD_LIBRARY_PATH setup
prepend_path("LD_LIBRARY_PATH", pathJoin(foam_libbin, "dummy"))
prepend_path("LD_LIBRARY_PATH", foam_ext_libbin)
prepend_path("LD_LIBRARY_PATH", foam_libbin)
prepend_path("LD_LIBRARY_PATH", foam_site_libbin)
prepend_path("LD_LIBRARY_PATH", foam_user_libbin)
prepend_path("LD_LIBRARY_PATH", pathJoin(foam_ext_libbin, foam_mpi))
prepend_path("LD_LIBRARY_PATH", pathJoin(foam_libbin, foam_mpi))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "platforms", wm_arch..wm_compiler, "gperftools-svn/lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(boost_arch_path, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(cgal_arch_path, "lib"))


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
