# Traffic Light Controller Using Verilog

## 1. Project Overview

This project implements a four-state traffic light controller using Verilog HDL.

The controller manages traffic signals for two directions:
- North-South (NS)
- East-West (EW)

It uses a Finite State Machine (FSM) and Moore output logic to control the traffic signals.

## 2. Objectives

- Design a four-state traffic light controller.
- Implement state transitions using Verilog.
- Control red, yellow and green signals for both directions.
- Verify the design using a Verilog testbench.
- Simulate the design using Icarus Verilog.
- Inspect simulation waveforms using GTKWave.
- Perform logic synthesis using Yosys.

## 3. State Sequence

| State | North-South | East-West |
|---|---|---|
| S0 | Green | Red |
| S1 | Yellow | Red |
| S2 | Red | Green |
| S3 | Red | Yellow |

Sequence:

S0 -> S1 -> S2 -> S3 -> S0

The controller advances to the next state on each rising clock edge. Reset returns it to S0.

## 4. Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- Ubuntu on WSL

## 5. Project Structure

```text
Traffic_Light_Controller/
├── rtl/
│   └── traffic_light_controller.v
├── tb/
│   └── tb_traffic_light_controller.v
├── simulation/
│   ├── full_synthesis.log
│   ├── traffic_light_synth.v
│   └── yosys_synthesis.log
├── waveforms/
│   └── traffic_light.vcd
├── docs/
│   ├── PROJECT_REPORT.md
│   └── screenshots/
│       └── traffic_light_waveform.png
├── scripts/
│   └── run_simulation.sh
├── .gitignore
└── README.md
```
