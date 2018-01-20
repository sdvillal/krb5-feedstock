#!/bin/bash

export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"

# https://github.com/conda-forge/bison-feedstock/issues/7
export M4="${BUILD_PREFIX}/bin/m4"

pushd src
  autoreconf -i
  ./configure --prefix=${PREFIX}    \
              --host=${HOST}        \
              --build=${BUILD}      \
              --with-tcl=${PREFIX}  \
              --without-readline    \
              --with-libedit
  make -j${CPU_COUNT} ${VERBOSE_AT}
  if [ "${PY_VER}" == "2.7" ]; then
    make check
  fi
  make install
popd
