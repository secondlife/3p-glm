#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x

# make errors fatal
set -e

# complain about unreferenced environment variables
set -u

if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

top="$(pwd)"
stage="$top/stage"

# load autobuild provided shell functions and variables
glm_SOURCE_DIR="glm"

mkdir -p "$stage/include/glm"
cp -a $glm_SOURCE_DIR/* "$stage/include/glm"
mkdir -p "$stage/LICENSES"
cp -a LICENSE.glm "$stage/LICENSES/glm_license.txt"
echo "v1.0.1" > "$stage/include/glm/glm_version.txt"

