# Environment Module for OpenFOAM
This repository maintains environment module for OpenFOAM along with related packages such as compilers and MPIs.

## Environment Module

Environment Module is based on the latest Tcl version instead of out-dated C version because of its Emacs support of which it seems not perfect yet.

## How to install Environment Module (Tcl version)

* install environment module

`
  ./configure --prefix=/usr/share/Modules/1.775 --modulefilesdir=/usr/share/Modules/modulefiles
  make install
`

* copy my init/modulerc into init/modulerc

`
    cp init/modulerc /usr/share/Modules/1.775/init
`

* copy my modulefiles into /usr/share/Modules

`    cp -rf modulefiles /usr/share/Modules/
`
## How to use

* just call metaModules such as of4x, of4xdbg, etc.

### setups for OpenFOAM-2.x and OpenFOAM-[34].x are different

### Enjoy
