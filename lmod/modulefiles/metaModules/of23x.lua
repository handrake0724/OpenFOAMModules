-- -*- lua -*-

if (mode() == "load") then
   load("gcc/6.3.0", "openmpi/2.1.0", "OpenFOAM/2.3.x")
else
   load("OpenFOAM/2.3.x", "openmpi/2.1.0", "gcc/6.3.0")
end
