-- -*- lua -*-

prereq("openmpi")
conflict("OpenFOAM", "FOAM-extend")

whatis("FOAM-extend 4.0")

local version="4.0"
local foamRoot=os.getenv("HOME")

setenv("WM_PROJECT", "foam")
setenv("WM_FORK", "extend")
setenv("WM_PROJECT_VERSION", version)
setenv("WM_PROJECT_INST_DIR", pathJoin(foamRoot, os.getenv("WM_PROJECT")))
setenv("WM_PROJECT_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), os.getenv("WM_PROJECT").."-"..os.getenv("WM_FORK").."-"..version))
setenv("WM_PROJECT_USER_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), os.getenv("USER").."-"..version))
setenv("WM_THIRD_PARTY_DIR", pathJoin(os.getenv("WM_PROJECT_DIR"), "ThirdParty"))
setenv("WM_DIR", pathJoin(os.getenv("WM_PROJECT_DIR"), "wmake"))
-- Naval Hydro Pack specific
setenv("NHP_LIB_SRC", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "NavalHydro/src"))

setenv("WM_ARCH", "linux64")
setenv("WM_ARCH_OPTION", "64")

setenv("WM_CC", os.getenv("CC"))
setenv("WM_CXX", os.getenv("CXX"))
setenv("WM_CFLAGS", "-m64 -fPIC")
setenv("WM_CXXFLAGS", "-m64 -fPIC")
setenv("WM_LDFLAGS", "-m64")

if (os.getenv("WM_CC") == "gcc") then
  setenv("WM_COMPILER", "Gcc")
elseif (os.getenv("WM_CC") == "icc") then
  setenv("WM_COMPILER", "Icc")
elseif (os.getenv("WM_CC") == "clang") then
  setenv("WM_COMPILER", "Clang")
end
setenv("WM_COMPILER_ARCH", "")
setenv("WM_COMPILER_LIB_ARCH", "64")
setenv("WM_COMPILE_OPTION", "Opt")

setenv("WM_PRECISION_OPTION", "DP")
setenv("WM_MPLIB", "SYSTEMOPENMPI")
setenv("WM_OSTYPE", "POSIX")
setenv("WM_OPTIONS", pathJoin(os.getenv("WM_ARCH")..os.getenv("WM_COMPILER")..os.getenv("WM_PRECISION_OPTION")..os.getenv("WM_COMPILE_OPTION")))

setenv("WM_LINK_LANGUAGE", "c++")
setenv("WM_NCOMPPROCS", capture("expr `nproc` / 2"))

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


setenv("WM_THIRD_PARTY_USE_HWLOC_1101", "1")
setenv("HWLOC_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/hwloc-1.10.1/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("HWLOC_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/hwloc-1.10.1/platforms", os.getenv("WM_OPTIONS")))

setenv("WM_THIRD_PARTY_USE_LIBCCMIO_261", "1")
setenv("LIBCCMIO_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/libccmio-2.6.1/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("LIBCCMIO_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/libccmio-2.6.1/platforms", os.getenv("WM_OPTIONS")))
setenv("LIBCCMIO_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/libccmio-2.6.1/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("LIBCCMIO_LIB_DIR", "$env(WM_THIRD_PARTY_DIR)/packages/libccmio-2.6.1/platforms/$env(WM_OPTIONS)/lib")

setenv("WM_THIRD_PARTY_USE_MESQUITE_212", "1")
setenv("MESQUITE_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/mesquite-2.1.2/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("MESQUITE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/mesquite-2.1.2/platforms", os.getenv("WM_OPTIONS")))
setenv("MESQUITE_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/mesquite-2.1.2/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("MESQUITE_LIB_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/mesquite-2.1.2/platforms", os.getenv("WM_OPTIONS"), "lib"))

setenv("WM_THIRD_PARTY_USE_METIS_510", "1")
setenv("METIS_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/metis-5.1.0/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("METIS_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/metis-5.1.0/platforms", os.getenv("WM_OPTIONS")))
setenv("METIS_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/metis-5.1.0/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("METIS_LIB_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/metis-5.1.0/platforms", os.getenv("WM_OPTIONS"), "lib"))

setenv("WM_THIRD_PARTY_USE_PARMETIS_403", "1")
setenv("PARMETIS_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/parmetis-4.0.3/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("PARMETIS_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/parmetis-4.0.3/platforms", os.getenv("WM_OPTIONS")))
setenv("PARMETIS_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/parmetis-4.0.3/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("PARMETIS_LIB_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/parmetis-4.0.3/platforms", os.getenv("WM_OPTIONS"), "lib"))

setenv("WM_THIRD_PARTY_USE_PARMGRIDGEN_10", "1")
setenv("PARMGRIDGEN_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/ParMGridGen-1.0/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("PARMGRIDGEN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/ParMGridGen-1.0/platforms", os.getenv("WM_OPTIONS")))
setenv("PARMGRIDGEN_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/ParMGridGen-1.0/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("PARMGRIDGEN_LIB_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/ParMGridGen-1.0/platforms", os.getenv("WM_OPTIONS"), "lib"))

setenv("WM_THIRD_PARTY_USE_SCOTCH_604", "1")
setenv("SCOTCH_BIN_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/scotch-6.0.4/platforms", os.getenv("WM_OPTIONS"), "bin"))
setenv("SCOTCH_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/scotch-6.0.4/platforms", os.getenv("WM_OPTIONS")))
setenv("SCOTCH_INCLUDE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/scotch-6.0.4/platforms", os.getenv("WM_OPTIONS"), "include"))
setenv("SCOTCH_LIB_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/scotch-6.0.4/platforms", os.getenv("WM_OPTIONS"), "lib"))

setenv("PYFOAM_SITE_DIR", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "PyFoamSiteScripts"))

setenv("FOAM_INST_DIR", os.getenv("WM_PROJECT_INST_DIR"))
setenv("FOAM_APP", pathJoin(os.getenv("WM_PROJECT_DIR"), "applications"))
setenv("FOAM_APPBIN", pathJoin(os.getenv("FOAM_APP"), "bin", os.getenv("WM_OPTIONS")))
setenv("FOAM_USER_APPBIN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "applications/bin", os.getenv("WM_OPTIONS")))
setenv("FOAM_SOLVERS", pathJoin(os.getenv("FOAM_APP"), "solvers"))
setenv("FOAM_UTILITIES", pathJoin(os.getenv("FOAM_APP"), "utilities"))

setenv("FOAM_DEV", "1")

setenv("FOAM_RUN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "run"))
setenv("FOAM_SIGFPE", "")
setenv("FOAM_JOB_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "jobControl"))

setenv("FOAM_SITE_DIR", pathJoin(os.getenv("WM_PROJECT_INST_DIR"), "site", version))
setenv("FOAM_SITE_APPBIN", pathJoin(os.getenv("FOAM_SITE_DIR"), "bin", os.getenv("WM_OPTIONS")))
setenv("FOAM_SITE_LIBBIN", pathJoin(os.getenv("FOAM_SITE_DIR"), "lib", os.getenv("WM_OPTIONS")))

setenv("FOAM_SRC", pathJoin(os.getenv("WM_PROJECT_DIR"), "src"))
setenv("FOAM_LIB", pathJoin(os.getenv("WM_PROJECT_DIR"), "lib"))

setenv("FOAM_LIBBIN", pathJoin(os.getenv("WM_PROJECT_DIR"), "lib", os.getenv("WM_OPTIONS")))
setenv("FOAM_USER_LIBBIN", pathJoin(os.getenv("WM_PROJECT_USER_DIR"), "lib", os.getenv("WM_OPTIONS")))

setenv("FOAM_TEST_HARNESS_DIR", pathJoin(os.getenv("WM_PROJECT_DIR"), "testHarness", os.getenv("WM_PROJECT").."-"..os.getenv("WM_FORK"), version))
setenv("FOAM_TUTORIALS", pathJoin(os.getenv("WM_PROJECT_DIR"), "tutorials"))

prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/scotch-6.0.4/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/parmetis-4.0.3/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/mesquite-2.1.2/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/libccmio-2.6.1/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/metis-5.1.0/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "packages/ParMGridGen-1.0/platforms", os.getenv("WM_OPTIONS"), "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("WM_PROJECT_DIR"), "lib", os.getenv("WM_OPTIONS")))

prepend_path("PATH", pathJoin(os.getenv("WM_PROJECT_DIR"), "bin"))
prepend_path("PATH", os.getenv("WM_DIR"))
prepend_path("PATH", os.getenv("FOAM_APPBIN"))
prepend_path("PATH", os.getenv("FOAM_SITE_APPBIN"))
prepend_path("PATH", os.getenv("FOAM_USER_APPBIN"))
prepend_path("PATH", pathJoin(os.getenv("WM_THIRD_PARTY_DIR"), "PyFoamSiteScripts/bin"))
