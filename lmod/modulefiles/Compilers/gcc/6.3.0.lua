-- -*- lua -*-

conflict("intel", "gcc")

whatis("Name: GCC")
whatis("Version: "..myModuleVersion())
whatis("Description: GNU Compiler Collection (GCC) is a compiler system produced by the GNU Project supporting various programming languages.")

local version = {}
local key=1
for num in string.gmatch(myModuleVersion(), "(%d+)") do
    version[key]=num
    key = key + 1
end

local major=version[1]
local minor=version[2]
local patch=version[3]
local version=major.."."..minor.."."..patch
local gnu_prefix=pathJoin("/opt/HPC/Compilers/gcc", myModuleVersion())
local gcc_prefix=pathJoin("/opt/HPC/Compilers/gcc", myModuleVersion())

setenv("COMPILER_PREFIX", gcc_prefix)
setenv("COMPILER", "gnu")
setenv("COMPILER_TYPE", "gcc")
setenv("COMPILER_VERSION", myModuleVersion())
setenv("FORTRAN_TYPE", "gfortran")
pushenv("CC", "gcc")
pushenv("CXX", "g++")
pushenv("FC", "gfortran")

prepend_path("PATH", pathJoin(gcc_prefix,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib/gcc/x86_64-pc-linux-gnu", version))
prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(gcc_prefix, "lib64"))
