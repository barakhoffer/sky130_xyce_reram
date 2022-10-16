#!/bin/bash
SCRIPT_DIR="$(realpath $( dirname -- "$0"; ))"
XYCE_BIN="$(dirname -- $(which Xyce);)"
XYCE_LIB="$(realpath "$XYCE_BIN/../lib")"

if [ -x "$(which buildxyceplugin.sh)" ]; then
    BUILD_SCRIPT=buildxyceplugin.sh
elif [ -x "$(which buildxyceplugin)" ]; then
    BUILD_SCRIPT=buildxyceplugin
else
    echo "Can not find build xyce plugin script."
    exit 1
fi

cp "$SCRIPT_DIR/xyce/XyceLP.sh" "$XYCE_BIN"
chmod +x "$XYCE_BIN/XyceLP.sh"

mkdir -p "$SCRIPT_DIR/build"
mkdir -p "$XYCE_LIB/plugins"

git clone https://github.com/google/skywater-pdk-libs-sky130_fd_pr_reram sky130_fd_pr_reram
cp sky130_fd_pr_reram/cells/reram_cell/sky130_fd_pr_reram__reram_cell.va $SCRIPT_DIR/xyce/sky130_fd_pr_reram__reram_module.va
patch "$SCRIPT_DIR/xyce/sky130_fd_pr_reram__reram_module.va" < "$SCRIPT_DIR/xyce/va_model_patch"
$BUILD_SCRIPT -o sky130_fd_pr_reram__reram_module "$SCRIPT_DIR/xyce/sky130_fd_pr_reram__reram_module.va" "$SCRIPT_DIR/build"
cp "$SCRIPT_DIR/build"/*.so "$XYCE_LIB/plugins"

mkdir -p ${PDK_ROOT}/sky130B/libs.tech
cp -r "$SCRIPT_DIR/xyce" ${PDK_ROOT}/sky130B/libs.tech
cp -r "$SCRIPT_DIR/xschem" ${PDK_ROOT}/sky130B/libs.tech