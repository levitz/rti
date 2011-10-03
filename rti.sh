#!/bin/sh
#Directory settings
PACKAGE_DIR=`cd $1; pwd`
WORKBENCH_DIR=`cd $2; pwd`

SILENT_OUTPUT="/dev/null"

#Archive settings
BINUTILS_ARCHIVE="binutils-2.18.tar.bz2"
GCC_ARCHIVE="gcc-4.2.2.tar.bz2"
NEWLIB_ARCHIVE="newlib-1.15.0.tar.gz"
#Patch files
BINUTILS_PATCH="binutils-2.18-rtems4.8-20071104.diff"
GCC_PATCH="gcc-core-4.2.2-rtems4.8-20071127.diff"
NEWLIB_PATCH="newlib-1.15.0-rtems4.8-20080903.diff"

#Temp directory settings
BINUTILS_DIR="binutils-2.18"
BINUTILS_B_DIR="${BINUTILS_DIR}-b"
GCC_DIR="gcc-4.2.2"
NEWLIB_DIR="newlib-1.15.0"

#Commands settings
TAR_CMD="tar"
MKDIR_CMD="mkdir"
CD_CMD="cd"
CAT_CMD="cat"

#Flasg settings
TARBZ2_FLAGS="-jxvf"
TARGZ_FLAGS="-zxvf"
TAR_REDIRECT_FLAGS="-C"
#export PREFIX=$PACKAGE_DIR
#export PATH=$PATH:$PREFIX/bin

echo "[@ `date +"%T"`] Archive decompression in progress ..."
${TAR_CMD} ${TARBZ2_FLAGS} ${PACKAGE_DIR}/${BINUTILS_ARCHIVE} ${TAR_REDIRECT_FLAGS} ${WORKBENCH_DIR} &> ${SILENT_OUTPUT}
${TAR_CMD} ${TARBZ2_FLAGS} ${PACKAGE_DIR}/${GCC_ARCHIVE} ${TAR_REDIRECT_FLAGS} ${WORKBENCH_DIR} &> ${SILENT_OUTPUT}
${TAR_CMD} ${TARGZ_FLAGS} ${PACKAGE_DIR}/${NEWLIB_ARCHIVE} ${TAR_REDIRECT_FLAGS} ${WORKBENCH_DIR} &> ${SILENT_OUTPUT}

echo "[@ `date +"%T"`] Applying patch to Binutils ..."
${CD_CMD} ${WORKBENCH_DIR}/${BINUTILS_DIR}
${CAT_CMD} ${PACKAGE_DIR}/${BINUTILS_PATCH} | patch -p1
${CD_CMD} ..

echo "[@ `date +"%T"`] Applying patch to Gcc ..."
${CD_CMD} ${WORKBENCH_DIR}/${GCC_DIR}
${CAT_CMD} ${PACKAGE_DIR}/${GCC_PATCH} | patch -p1
${CD_CMD} ..

echo "[@ `date +"%T"`] Applying patch to Newlib ..."
${CD_CMD} ${WORKBENCH_DIR}/${NEWLIB_DIR}
${CAT_CMD} ${PACKAGE_DIR}/${NEWLIB_PATCH} | patch -p1
${CD_CMD} ..
