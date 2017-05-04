-- -*- lua -*-

conflict("openmpi")

whatis("Name: OpenMPI")
whatis("Version: "..myModuleVersion())
whatis("Description: Open source MPI implementation that is developed and maintained by a consortium of academic, research, and industry partners.")

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
local prefix=pathJoin("/opt/HPC/MPIs", os.getenv("COMPILER_TYPE"), os.getenv("COMPILER_VERSION"), myModuleName(), myModuleVersion())

setenv("MPI", myModuleName())
setenv("MPI_VER", myModuleVersion())

setenv("MPI_HOME", prefix)
setenv("MPICH_HOME", prefix)
setenv("MPI_BUFFER_SIZE", "2000000")

prepend_path("PATH", pathJoin(prefix, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "lib"))
append_path("MANPATH", pathJoin(prefix, "share/man"))

