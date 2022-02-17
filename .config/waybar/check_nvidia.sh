#!/usr/bin/env bash

if grep -q "Video Memory:[[:blank:]]*Off" /proc/driver/nvidia/gpus/0000:01:00.0/power; then
    echo "RTX Off"   
else
    echo "RTX On"
fi

