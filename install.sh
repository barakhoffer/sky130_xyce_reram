#!/bin/bash
XYCE_BIN=$(dirname $(which Xyce))
XYCE_LIB=$(realpath "$XYCE_BIN/../lib")
cp xyce/XyceLP.sh "$XYCE_BIN"
chmod +x "$XYCE_BIN/XyceLP.sh"
mkdir -p "$XYCE_LIB/plugins"
mkdir build
git clone https://github.com/google/skywater-pdk-libs-sky130_fd_pr_reram sky130_fd_pr_reram
cp sky130_fd_pr_reram/cells/reram_cell/sky130_fd_pr_reram__reram_cell.va xyce/sky130_fd_pr_reram__reram_module.va
patch xyce/sky130_fd_pr_reram__reram_module.va < xyce/va_model_patch
buildxyceplugin -o sky130_fd_pr_reram__reram_module $(realpath xyce/sky130_fd_pr_reram__reram_module.va) $(realpath build)
cp build/sky130_fd_pr_reram__reram_module.so "$XYCE_LIB/plugins"

mkdir -p ${PDK_ROOT}/sky130B/libs.tech
cp -r xyce ${PDK_ROOT}/sky130B/libs.tech
cp -r xschem ${PDK_ROOT}/sky130B/libs.tech