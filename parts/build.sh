#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))

cd $SCRIPT_DIR

/usr/lib/qt6/bin/qsb \
  --glsl "100 es,120,150" \
  --hlsl 50 \
  --msl 12 \
  -o squircle.frag.qsb \
  squircle.frag
