-- -*- lua -*-

whatis("adds your own modulefiles directory to MODULEPATH")

local ownmoddir=pathJoin(os.getenv("HOME"), "privatemodules")

if ( mode() == "load") then
  if ( not isDir(ownmoddir) ) then
      execute { cmd="mkdir "..ownmoddir, modeA={"load"}}
  end
  append_path("MODULEPATH", ownmoddir)
end
