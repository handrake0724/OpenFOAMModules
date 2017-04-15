-- -*- lua -*-

conflict("intel", "gcc")

local major=6
local minor=3
local patch=1
local version=major.."."..minor.."."..patch
local gnu_prefix="/usr"
local gcc_prefix="/usr"

whatis("Name: gcc")
whatis("Version: "..version)
whatis("Description: gnu gcc")

setenv("COMPILER_PREFIX", gcc_prefix)
setenv("COMPILER", "gnu")
setenv("COMPILER_TYPE", "gcc")
setenv("COMPILER_VERSION", version)
setenv("FORTRAN_TYPE", "gfortran")
setenv("CC", "gcc")
setenv("CXX", "g++")
setenv("FC", "gfortran")
setenv("COMPILER_OF_TYPE",  "Gcc")

prepend_path("PATH", pathJoin(gcc_prefix,"/bin"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib/gcc/x86_64-pc-linux-gnu", version))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib64"))
