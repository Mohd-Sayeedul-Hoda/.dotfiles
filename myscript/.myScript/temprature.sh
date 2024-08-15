#!/bin/bash

ACTIVE=$(systemctl --user status wl-gammarelay.service | rg Active | awk '{$2}')
echo "$ACTIVE"
if [ "$ACTIVE" == "active" ]; then
 busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500
else
 systemctl --user start wl-gammarelay.service
fi

if [ "$1" == "true" ]; then
 busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500
else
 busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 4000
fi
