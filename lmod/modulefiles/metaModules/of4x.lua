-- -*- lua -*-
whatis("Name: OpenFOAM Metamodule")
whatis("Version: 4.x")
whatis("Description: Metamodule for OpenFOAM 4.x (Optimized)")

if (mode() == "load") then
   load("gcc/6.3.0", "openmpi/2.1.0", "OpenFOAM/4.x")
else
   load("OpenFOAM/4.x", "openmpi/2.1.0", "gcc/6.3.0")
end
