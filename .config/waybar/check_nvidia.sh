#!/usr/bin/env bash

if grep -q "D3cold" /sys/bus/pci/devices/0000:01:00.0/power_state; then
    echo "RTX Off"   
else
    echo "RTX On"
fi

