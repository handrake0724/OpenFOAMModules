-- -*- lua -*-

prereq("openmpi")
conflict("OpenFOAM", "FOAM-extend")

whatis("Name: FOAM-extend project")
whatis("Version: 4.0")
whatis("Description: OpenFOAM variant based on OpenFOAM 1.6")

local version="4.0"
local foamRoot=os.getenv("HOME")

local wm_project="foam"
local wm_fork="extend"
local wm_project_version=version
local wm_project_inst_dir=pathJoin(foamRoot, wm_project)
local wm_project_dir=pathJoin(wm_project_inst_dir, wm_project.."-"..wm_fork.."-"..version)
local wm_project_user_dir=pathJoin(os.getenv("HOME"), wm_project, os.getenv("USER").."-"..version)
local wm_third_party_dir=pathJoin(wm_project_dir, "ThirdParty")
local wm_dir=pathJoin(wm_project_dir, "wmake")
local nhp_lib_src=pathJoin(wm_project_inst_dir, "NavalHydro/src")

local wm_arch="linux64"
local wm_arch_option="64"

local wm_cc=os.getenv("CC")
local wm_cxx=os.getenv("CXX")
local wm_cflags="-m64 -fPIC"
local wm_cxxflags="-m64 -fPIC"
local wm_ldflags="-m64"

local wm_compiler
if (wm_cc == "gcc") then
  wm_compiler="Gcc"
elseif (wm_cc == "icc") then
  wm_compiler="Icc"
elseif (wm_cc == "clang") then
  wm_compiler="Clang"
end

local wm_compiler_arch=""
local wm_compiler_lib_arch="64"
local wm_compile_option="Opt"

local wm_precision_option="DP"
local wm_mplib="SYSTEMOPENMPI"
local wm_ostype="POSIX"
local wm_options=pathJoin(wm_arch..wm_compiler..wm_precision_option..wm_compile_option)

local wm_link_language="c++"
local wm_ncompprocs=capture("expr `nproc` / 2")

local pinc
local plibs

if (isloaded("openmpi")) then
  pinc=capture("mpicc -showme:compile")
  plibs=capture("mpicc -showme:link")
elseif (isloaded("mvapich2") or isloaded("mpich2")) then
  pinc=capture("mpicc -show -cc= -nativelinking")
  plibs=capture("mpicc -show -cc= "):gsub("-I.*/include", " ")
end


local wm_third_party_use_hwloc_1101="1"
local hwloc_bin_dir=pathJoin(wm_third_party_dir, "packages/hwloc-1.10.1/platforms", wm_options, "bin")
local hwloc_dir=pathJoin(wm_third_party_dir, "packages/hwloc-1.10.1/platforms", wm_options)

local wm_third_party_use_libccmio_261="1"
local libccmio_bin_dir=pathJoin(wm_third_party_dir, "packages/libccmio-2.6.1/platforms", wm_options, "bin")
local libccmio_dir=pathJoin(wm_third_party_dir, "packages/libccmio-2.6.1/platforms", wm_options)
local libccmio_include_dir=pathJoin(wm_third_party_dir, "packages/libccmio-2.6.1/platforms", wm_options, "include")
local libccmio_lib_dir=pathJoin(wm_third_party_dir, "packages/libccmio-2.6.1/platforms", wm_options, "lib")

local wm_third_party_use_mesquite_212="1"
local mesquite_bin_dir=pathJoin(wm_third_party_dir, "packages/mesquite-2.1.2/platforms", wm_options, "bin")
local mesquite_dir=pathJoin(wm_third_party_dir, "packages/mesquite-2.1.2/platforms", wm_options)
local mesquite_include_dir=pathJoin(wm_third_party_dir, "packages/mesquite-2.1.2/platforms", wm_options, "include")
local mesquite_lib_dir=pathJoin(wm_third_party_dir, "packages/mesquite-2.1.2/platforms", wm_options, "lib")

local wm_third_party_use_metis_510="1"
local metis_bin_dir=pathJoin(wm_third_party_dir, "packages/metis-5.1.0/platforms", wm_options, "bin")
local metis_dir=pathJoin(wm_third_party_dir, "packages/metis-5.1.0/platforms", wm_options)
local metis_include_dir=pathJoin(wm_third_party_dir, "packages/metis-5.1.0/platforms", wm_options, "include")
local metis_lib_dir=pathJoin(wm_third_party_dir, "packages/metis-5.1.0/platforms", wm_options, "lib")

local wm_third_party_use_parmetis_403="1"
local parmetis_bin_dir=pathJoin(wm_third_party_dir, "packages/parmetis-4.0.3/platforms", wm_options, "bin")
local parmetis_dir=pathJoin(wm_third_party_dir, "packages/parmetis-4.0.3/platforms", wm_options)
local parmetis_include_dir=pathJoin(wm_third_party_dir, "packages/parmetis-4.0.3/platforms", wm_options, "include")
local parmetis_lib_dir=pathJoin(wm_third_party_dir, "packages/parmetis-4.0.3/platforms", wm_options, "lib")

local wm_third_party_use_parmgridgen_10="1"
local parmgridgen_bin_dir=pathJoin(wm_third_party_dir, "packages/ParMGridGen-1.0/platforms", wm_options, "bin")
local parmgridgen_dir=pathJoin(wm_third_party_dir, "packages/ParMGridGen-1.0/platforms", wm_options)
local parmgridgen_include_dir=pathJoin(wm_third_party_dir, "packages/ParMGridGen-1.0/platforms", wm_options, "include")
local parmgridgen_lib_dir=pathJoin(wm_third_party_dir, "packages/ParMGridGen-1.0/platforms", wm_options, "lib")

local wm_third_party_use_scotch_604="1"
local scotch_bin_dir=pathJoin(wm_third_party_dir, "packages/scotch-6.0.4/platforms", wm_options, "bin")
local scotch_dir=pathJoin(wm_third_party_dir, "packages/scotch-6.0.4/platforms", wm_options)
local scotch_include_dir=pathJoin(wm_third_party_dir, "packages/scotch-6.0.4/platforms", wm_options, "include")
local scotch_lib_dir=pathJoin(wm_third_party_dir, "packages/scotch-6.0.4/platforms", wm_options, "lib")

local pyfoam_site_dir=pathJoin(wm_third_party_dir, "PyFoamSiteScripts")

local foam_inst_dir=wm_project_inst_dir
local foam_app=pathJoin(wm_project_dir, "applications")
local foam_appbin=pathJoin(foam_app, "bin", wm_options)
local foam_user_appbin=pathJoin(wm_project_user_dir, "applications/bin", wm_options)
local foam_solvers=pathJoin(foam_app, "solvers")
local foam_utilities=pathJoin(foam_app, "utilities")

local foam_dev="1"

local foam_run=pathJoin(wm_project_user_dir, "run")
local foam_sigfpe=""
local foam_job_dir=pathJoin(wm_project_inst_dir, "jobControl")

local foam_site_dir=pathJoin(wm_project_inst_dir, "site", version)
local foam_site_appbin=pathJoin(foam_site_dir, "bin", wm_options)
local foam_site_libbin=pathJoin(foam_site_dir, "lib", wm_options)

local foam_src=pathJoin(wm_project_dir, "src")
local foam_lib=pathJoin(wm_project_dir, "lib")

local foam_libbin=pathJoin(wm_project_dir, "lib", wm_options)
local foam_user_libbin=pathJoin(wm_project_user_dir, "lib", wm_options)

local foam_test_harness_dir=pathJoin(wm_project_dir, "testHarness", wm_project.."-"..wm_fork, version)
local foam_tutorials=pathJoin(wm_project_dir, "tutorials")
-- setup environment variables

setenv("WM_PROJECT", wm_project)
setenv("WM_FORK", wm_fork)
setenv("WM_PROJECT_VERSION", wm_project_version)
setenv("WM_PROJECT_INST_DIR", wm_project_inst_dir)
setenv("WM_PROJECT_DIR", wm_project_dir)
setenv("WM_PROJECT_USER_DIR", wm_project_user_dir)
setenv("WM_THIRD_PARTY_DIR", wm_third_party_dir)
setenv("WM_DIR", wm_dir)

-- Naval Hydro Pack specific
setenv("NHP_LIB_SRC", nhp_lib_src)

setenv("WM_ARCH", wm_arch)
setenv("WM_ARCH_OPTION", wm_arch_option)

setenv("WM_CC", wm_cc)
setenv("WM_CXX", wm_cxx)
setenv("WM_CFLAGS", wm_cflags)
setenv("WM_CXXFLAGS", wm_cxxflags)
setenv("WM_LDFLAGS", wm_ldflags)

setenv("WM_COMPILER", wm_compiler)
setenv("WM_COMPILER_ARCH", wm_compiler_arch)
setenv("WM_COMPILER_LIB_ARCH", wm_compiler_lib_arch)
setenv("WM_COMPILE_OPTION", wm_compile_option)

setenv("WM_PRECISION_OPTION", wm_precision_option)
setenv("WM_MPLIB", wm_mplib)
setenv("WM_OSTYPE", wm_ostype)
setenv("WM_OPTIONS", wm_options)

setenv("WM_LINK_LANGUAGE", wm_link_language)
setenv("WM_NCOMPPROCS", wm_ncompprocs)

setenv("PINC", pinc)
setenv("PLIBS", plibs)


setenv("WM_THIRD_PARTY_USE_HWLOC_1101", wm_third_party_use_hwloc_1101)
setenv("HWLOC_BIN_DIR", hwloc_bin_dir)
setenv("HWLOC_DIR", hwloc_dir)

setenv("WM_THIRD_PARTY_USE_LIBCCMIO_261", wm_third_party_use_libccmio_261)
setenv("LIBCCMIO_BIN_DIR", libccmio_bin_dir)
setenv("LIBCCMIO_DIR", libccmio_dir)
setenv("LIBCCMIO_INCLUDE_DIR", libccmio_include_dir)
setenv("LIBCCMIO_LIB_DIR", libccmio_lib_dir)

setenv("WM_THIRD_PARTY_USE_MESQUITE_212", wm_third_party_use_mesquite_212)
setenv("MESQUITE_BIN_DIR", mesquite_bin_dir)
setenv("MESQUITE_DIR", mesquite_dir)
setenv("MESQUITE_INCLUDE_DIR", mesquite_include_dir)
setenv("MESQUITE_LIB_DIR", mesquite_lib_dir)

setenv("WM_THIRD_PARTY_USE_METIS_510", wm_third_party_use_metis_510)
setenv("METIS_BIN_DIR", metis_bin_dir)
setenv("METIS_DIR", metis_dir)
setenv("METIS_INCLUDE_DIR", metis_include_dir)
setenv("METIS_LIB_DIR", metis_lib_dir)

setenv("WM_THIRD_PARTY_USE_PARMETIS_403", wm_third_party_use_parmetis_403)
setenv("PARMETIS_BIN_DIR", parmetis_bin_dir)
setenv("PARMETIS_DIR", parmetis_dir)
setenv("PARMETIS_INCLUDE_DIR", parmetis_include_dir)
setenv("PARMETIS_LIB_DIR", parmetis_lib_dir)

setenv("WM_THIRD_PARTY_USE_PARMGRIDGEN_10", wm_third_party_use_parmgridgen_10)
setenv("PARMGRIDGEN_BIN_DIR", parmgridgen_bin_dir)
setenv("PARMGRIDGEN_DIR", parmgridgen_dir)
setenv("PARMGRIDGEN_INCLUDE_DIR", parmgridgen_include_dir)
setenv("PARMGRIDGEN_LIB_DIR", parmgridgen_lib_dir)

setenv("WM_THIRD_PARTY_USE_SCOTCH_604", wm_third_party_use_scotch_604)
setenv("SCOTCH_BIN_DIR", scotch_bin_dir)
setenv("SCOTCH_DIR", scotch_dir)
setenv("SCOTCH_INCLUDE_DIR", scotch_include_dir)
setenv("SCOTCH_LIB_DIR", scotch_lib_dir)

setenv("PYFOAM_SITE_DIR", pyfoam_site_dir)

--
setenv("FOAM_INST_DIR", foam_inst_dir)
setenv("FOAM_APP", foam_app)
setenv("FOAM_APPBIN", foam_appbin)
setenv("FOAM_USER_APPBIN", foam_user_appbin)
setenv("FOAM_SOLVERS", foam_solvers)
setenv("FOAM_UTILITIES", foam_utilities)

setenv("FOAM_DEV", foam_dev)

setenv("FOAM_RUN", foam_run)
setenv("FOAM_SIGFPE", foam_sigfpe)
setenv("FOAM_JOB_DIR", foam_job_dir)

setenv("FOAM_SITE_DIR", foam_site_dir)
setenv("FOAM_SITE_APPBIN", foam_site_appbin)
setenv("FOAM_SITE_LIBBIN", foam_site_libbin)

setenv("FOAM_SRC", foam_src)
setenv("FOAM_LIB", foam_lib)

setenv("FOAM_LIBBIN", foam_libbin)
setenv("FOAM_USER_LIBBIN", foam_user_libbin)

setenv("FOAM_TEST_HARNESS_DIR", foam_test_harness_dir)
setenv("FOAM_TUTORIALS", foam_tutorials)

-- keep the order
prepend_path("PATH", pathJoin(wm_project_dir, "bin"))
prepend_path("PATH", wm_dir)
prepend_path("PATH", foam_appbin)
prepend_path("PATH", foam_site_appbin)
prepend_path("PATH", foam_user_appbin)
prepend_path("PATH", pathJoin(wm_third_party_dir, "PyFoamSiteScripts/bin"))

-- keep the order
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/scotch-6.0.4/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/parmetis-4.0.3/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/mesquite-2.1.2/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/libccmio-2.6.1/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/metis-5.1.0/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_third_party_dir, "packages/ParMGridGen-1.0/platforms", wm_options, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(wm_project_dir, "lib", wm_options))
prepend_path("LD_LIBRARY_PATH", foam_libbin)
prepend_path("LD_LIBRARY_PATH", foam_site_libbin)
prepend_path("LD_LIBRARY_PATH", foam_user_libbin)
