-- -*- lua -*-

conflict("intel", "gcc")

local version="2016"
local xeversion=version..".".."1.40.463413"
local intel_prefix="/opt/intel"
local intelxe_prefix=pathJoin(intel_prefix, version)
local icc_prefix=pathJoin(intelxe_prefix, "compilers_and_libraries_2016.3.210/linux")

whatis("Name: Intel 64 Compiler XE")
whatis("Version: 16.0.7")
whatis("Description: Intel compiler can be used as an alternative to GNU's compiler")

setenv("COMPILER_PREFIX", intel_prefix)
setenv("COMPILER", "intel")
setenv("COMPILER_TYPE", "intel")
setenv("COMPILER_VERSION", version)
setenv("FORTRAN_TYPE", "ifort")
pushenv("CC", "icc")
pushenv("CXX", "icpc")
pushenv("FC", "ifort")

setenv("DAALROOT", pathJoin(icc_prefix, "daal"))
setenv("IPPROOT", pathJoin(icc_prefix, "ipp"))
setenv("MKLROOT", pathJoin(icc_prefix, "mkl"))
setenv("TBBROOT", pathJoin(icc_prefix, "tbb"))
setenv("MPM_LAUNCHER", pathJoin(intelxe_prefix, "debugger_2016/mpm/mic/bin/start_mpm.sh"))
setenv("F77", "ifort")
setenv("F90", "ifort")

prepend_path("PATH", pathJoin(intelxe_prefix, "debugger_2016/gdb/intel64_mic/bin"))
prepend_path("PATH", pathJoin(icc_prefix, "bin/intel64"))

prepend_path("CLASSPATH", pathJoin(os.getenv("DAALROOT"), "lib/daal.jar"))

prepend_path("LD_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/intel64_lin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("IPPROOT"), "lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("MKLROOT"), "lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("TBBROOT"), "lib/intel64/gcc4.4"))
prepend_path("LD_LIBRARY_PATH", pathJoin(intelxe_prefix, "debugger_2016/libipt/intel64/lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "lib/intel64_lin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "../tbb/lib/intel64_lin/gcc4.4"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "../compiler/lib/intel64_lin"))

prepend_path("LIBRARY_PATH", pathJoin(os.getenv("IPPROOT"), "lib/intel64"))
prepend_path("LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/intel64"))
prepend_path("LIBRARY_PATH", pathJoin(os.getenv("MKLROOT"), "lib/intel64"))
prepend_path("LIBRARY_PATH", pathJoin(os.getenv("TBBROOT"), "lib/intel64/gcc4.4"))
prepend_path("LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "lib/intel64_lin"))
prepend_path("LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "../tbb/lib/intel64_lin/gcc4.4"))
prepend_path("LIBRARY_PATH", pathJoin(os.getenv("DAALROOT"), "../compiler/lib/intel64_lin"))

prepend_path("NLSPATH", pathJoin(icc_prefix, "compiler/lib/intel64/locale/%l_%t/%N"))
prepend_path("NLSPATH", pathJoin(os.getenv("MKLROOT"), "lib/intel64/locale/%l_%t/%N"))
prepend_path("NLSPATH", pathJoin(icc_prefix, "debugger_2016/gdb/intel64_mic/share/locale/%l_%t/%N"))
prepend_path("NLSPATH", pathJoin(icc_prefix, "debugger_2016/gdb/intel64/share/locale/%l_%t/%N"))

prepend_path("CPATH", pathJoin(os.getenv("IPPROOT"), "ipp/include"))
prepend_path("CPATH", pathJoin(os.getenv("MKLROOT"), "include"))
prepend_path("CPATH", pathJoin(os.getenv("TBBROOT"), "tbb/include"))
prepend_path("CPATH", pathJoin(os.getenv("DAALROOT"), "daal/include"))

prepend_path("MIC_LD_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/mic"))
prepend_path("MIC_LD_LIBRARY_PATH", pathJoin(os.getenv("IPPROOT"), "lib/mic"))
prepend_path("MIC_LD_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/mic"))
prepend_path("MIC_LD_LIBRARY_PATH", pathJoin(os.getenv("MKLROOT"), "lib/mic"))
prepend_path("MIC_LD_LIBRARY_PATH", pathJoin(os.getenv("TBBROOT"), "lib/mic"))

prepend_path("MIC_LIBRARY_PATH", pathJoin(icc_prefix, "compiler/lib/mic"))
prepend_path("MIC_LIBRARY_PATH", pathJoin(os.getenv("TBBROOT"), "lib/mic"))

prepend_path("FPATH", pathJoin(os.getenv("MKLROOT"), "include"))
prepend_path("GDB_CROSS", pathJoin(intelxe_prefix, "debugger_2016/gdb/intel64_mic/bin/gdb-mic"))
prepend_path("GDBSERVER_MIC", pathJoin(intelxe_prefix, "debugger_2016/gdb/targets/mic/bin/gdbserver"))
prepend_path("INFOPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-ia/info"))
prepend_path("INFOPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-mic/info"))
prepend_path("INFOPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-igfx/info"))
prepend_path("INTEL_PYTHONHOME", pathJoin(intelxe_prefix, "debugger_2016/python/intel64"))
prepend_path("INTEL_LICENSE_FILE", pathJoin(intelxe_prefix, "licenses"))

prepend_path("MANPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-ia/man/"))
prepend_path("MANPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-mic/man/"))
prepend_path("MANPATH", pathJoin(intelxe_prefix, "documentation_2016/en/debugger/gdb-igfx/man/"))
