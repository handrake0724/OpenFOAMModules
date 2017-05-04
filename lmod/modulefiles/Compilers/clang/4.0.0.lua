-- -*- lua -*-

conflict("intel", "gcc")

whatis("Name: Clang")
whatis("Version: "..myModuleVersion())
whatis("Description: Compiler front end for the programming languages C, C++, Objective-C, Objective-C++, OpenMP, OpenCL and CUDA with LLVM as backend.")

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
local gnu_prefix="/usr"
local clang_prefix="/usr"


setenv("COMPILER_PREFIX", clang_prefix)
setenv("COMPILER", "clang")
setenv("COMPILER_TYPE", "clang")
setenv("COMPILER_VERSION", myModuleVersion())
setenv("FORTRAN_TYPE", "gfortran")
pushenv("CC", "clang")
pushenv("CXX", "clang++")
pushenv("FC", "gfortran")

prepend_path("PATH", pathJoin(clang_prefix, "bin"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib/gcc/x86_64-pc-linux-gnu", $version))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(clang_prefix, "lib64"))
