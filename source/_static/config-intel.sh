export PATH="$PATH:/opt/intel/oneapi/compiler/latest/linux/bin/intel64/"

export CDFROOT="/usr"
export LD_LIBRARY_PATH="${CDFROOT}/lib:${LD_LIBRARY_PATH}"
export LDFLAGS="-L${CDFROOT}/lib -I${CDFROOT}/include":
export OPTIM="-O3 -mcmodel=large -fPIC ${LDFLAGS}"

export CC=icx
export CXX=icx
export FC=ifort
export F77=ifort
export F90=ifort
export CPP='icx -E -mcmodel=large'
export CXXCPP='icx -E -mcmodel=large'
export CPPFLAGS="-DNDEBUG -DpgiFortran ${LDFLAGS}"

export CFLAGS=" ${OPTIM}"
export CXXFLAGS=" ${OPTIM}"
export FCFLAGS=" ${OPTIM}"
export F77FLAGS=" ${OPTIM}"
export F90FLAGS=" ${OPTIM}"

./configure --prefix=/usr/local/netcdf-ifort/4.6.1 --enable-large-file-tests --with-pic
