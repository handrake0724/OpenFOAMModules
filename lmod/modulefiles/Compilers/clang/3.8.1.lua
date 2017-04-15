-- -*- lua -*-

conflict("intel", "gcc")

whatis("Name: Intel 64 Compiler XE")
whatis("Version: 16.0.7")
whatis("Description: Intel compiler can be used as an alternative to GNU's compiler")

local major=3
local minor=8
local patch=1
local version=major.."."..minor.."."..patch
local gnu_prefix="/usr"
local clang_prefix="/usr"


setenv("COMPILER_PREFIX", clang_prefix)
setenv("COMPILER", "clang")
setenv("COMPILER_TYPE", "clang")
setenv("COMPILER_VERSION", version)
setenv("FORTRAN_TYPE", "gfortran")
setenv("CC", "clang")
setenv("CXX", "clang++")
setenv("FC", "gfortran")

setenv("COMPILER_OF_TYPE", "Clang")

prepend_path("PATH", pathJoin(clang_prefix, "bin"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib/gcc/x86_64-pc-linux-gnu", $version))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib64"))
