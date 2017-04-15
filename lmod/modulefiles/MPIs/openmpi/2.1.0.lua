-- -*- lua -*-

conflict("openmpi")


local name="openmpi"
local major=2
local minor=1
local patch=0
local version=major.."."..minor.."."..patch
local prefix=pathJoin("/opt/HPC/MPIs", os.getenv("COMPILER_TYPE"), os.getenv("COMPILER_VERSION"), name, version)

whatis("loads the $name environment")

setenv("MPI", name)
setenv("MPI_VER", version)

setenv("MPI_HOME", prefix)
setenv("MPICH_HOME", prefix)
setenv("MPI_BUFFER_SIZE", "2000000")

prepend_path("PATH", pathJoin(prefix, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "lib"))
append_path("MANPATH", pathJoin(prefix, "share/man"))

