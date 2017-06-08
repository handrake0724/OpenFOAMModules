-- -*- lua -*-

conflict("StarCCM+")

whatis("Name: StarCCM+")
whatis("Version: "..myModuleVersion())
whatis("Description: StarCCM+")

local version = {}
local key=1
for num in string.gmatch(myModuleVersion(), "(%d+)") do
    version[key]=num
    key = key + 1
end

local major=version[1]
local minor=version[2]
local patch=version[3]
local release="R8"
local version=major.."."..minor.."."..patch
local prefix=pathJoin("/opt/HPC/CD-adapco", myModuleVersion().."-"..release, "STAR-CCM+"..myModuleVersion().."-"..release)

prepend_path("PATH", pathJoin(prefix, "star/bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "star/lib"))
setenv("CDLMD_LICENSE_FILE", "/opt/HPC/CD-adapco")
