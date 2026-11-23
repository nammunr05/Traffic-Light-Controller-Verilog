#!/bin/bash
set -e

cd "$(dirname "$0")/.."

mkdir -p simulation waveforms

echo "===== RTL SIMULATION ====="
iverilog -Wall -g2012 \
    -s tb_traffic_light_controller \
    -o simulation/traffic_light_sim \
    rtl/traffic_light_controller.v \
    tb/tb_traffic_light_controller.v

vvp simulation/traffic_light_sim

echo
echo "===== SIMULATION COMPLETED ====="
echo "Waveform: waveforms/traffic_light.vcd"
