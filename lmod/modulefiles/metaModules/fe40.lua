-- -*- lua -*-
whatis("Name: FOAM-extend Metamodule")
whatis("Version: 4.0")
whatis("Description: Metamodule for FOAM-extend 4.0 (Optimized)")

if (mode() == "load") then
   load("gcc/6.3.0", "openmpi/2.1.0", "FOAM-extend/4.0")
else
   load("FOAM-extend/4.0", "openmpi/2.1.0", "gcc/6.3.0")
end
