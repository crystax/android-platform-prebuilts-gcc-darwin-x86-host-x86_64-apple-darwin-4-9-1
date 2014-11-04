#!/bin/bash
#
# The script was used to build this GCC on radon with Mac OS X 10.8
#
# To use this script create directory structure like this:
#
# ./build.sh                   -- this script
# ./gcc-x.x.x                  -- GCC sources
# ./build                      -- directory where to build GCC
# ./x86_64-apple-darwin-x.x.x  -- directory where to install GCC
#
# Fix sysroot_dir variable to suit your needs.
# Then cd to your dir and run ./build.sh script
#

sysroot_dir="/Users/zuav/src/ndk/platform/prebuilts/sysroot/darwin-x86/MacOSX10.6.sdk"
gcc_version=4.9.1
ndk_version=10
gmp_version=6.0.0a
mpfr_version=3.1.2-p10
mpc_version=1.0.2
isl_version=0.12.2
cloog_version=0.18.1

cwd=`pwd`
install_dir="$cwd/x86_64-apple-darwin-$gcc_version"

cd ./build

../gcc-$gcc_version/configure                             \
    --with-pkgversion="Crystax NDK $ndk_version"          \
    --prefix=$install_dir                                 \
    --enable-checking=release                             \
    --program-prefix="x86_64-apple-darwin12-"             \
    --disable-libgomp                                     \
    --with-build-sysroot=$sysroot_dir                     \
    --with-gmp="/usr/local/Cellar/gmp/$gmp_version"       \
    --with-mpfr="/usr/local/Cellar/mpfr/$mpfr_version"    \
    --with-mpc="/usr/local/Cellar/libmpc/$mpc_version"    \
    --with-isl="/usr/local/Cellar/isl/$isl_version"       \
    --with-cloog="/usr/local/Cellar/cloog/$cloog_version" \
    --enable-languages="c,c++" &&                         \
                                                          \
make -j 8 && make install

cd -
