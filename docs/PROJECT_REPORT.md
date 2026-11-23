# MINOR PROJECT 2
# DESIGN OF A TRAFFIC LIGHT CONTROLLER USING VERILOG

## 1. Introduction

A traffic light controller is a digital control system used to manage vehicle movement at road intersections. It controls traffic signals in a predefined sequence to allow safe movement in different directions.

This project implements a traffic light controller using Verilog HDL and a Finite State Machine (FSM).

## 2. Objectives

- Design a four-state traffic light controller using Verilog.
- Implement FSM-based state transitions.
- Control North-South and East-West traffic signals.
- Apply reset functionality.
- Verify the design using a testbench.
- Simulate the design using Icarus Verilog.
- Observe signal waveforms using GTKWave.
- Perform logic synthesis using Yosys.

## 3. Software and Tools Required

- Verilog HDL – Hardware description language.
- Icarus Verilog – Verilog compilation and simulation.
- GTKWave – Simulation waveform viewer.
- Yosys – Open-source logic synthesis tool.
- Ubuntu on WSL – Development environment.

## 4. System Description

The controller manages two traffic directions:

1. North-South (NS)
2. East-West (EW)

Each direction has three signal outputs:
- Red
- Yellow
- Green

The controller uses four states to manage the traffic sequence.

## 5. Finite State Machine Design

The four states are:

| State | North-South Signal | East-West Signal |
|---|---|---|
| S0 | Green | Red |
| S1 | Yellow | Red |
| S2 | Red | Green |
| S3 | Red | Yellow |

State transition sequence:

S0 -> S1 -> S2 -> S3 -> S0

The controller moves to the next state on every rising edge of the clock.

When reset is activated, the controller returns to S0.

## 6. Working Principle

1. The clock provides timing for state transitions.
2. When reset is activated, the controller enters S0.
3. In S0, North-South traffic receives Green and East-West traffic receives Red.
4. In S1, North-South changes to Yellow while East-West remains Red.
5. In S2, North-South changes to Red and East-West changes to Green.
6. In S3, North-South remains Red and East-West changes to Yellow.
7. The sequence repeats continuously.

The design uses Moore output logic, where outputs depend on the present state.

Note: This educational implementation advances one state per clock cycle. It does not include separate traffic-light duration counters.

## 7. Verilog Implementation

The main RTL source file is:

`rtl/traffic_light_controller.v`

The module uses:
- Clock input
- Active-high asynchronous reset
- Six traffic signal output ports
- Two-bit state register
- State transition logic
- Moore output logic

## 8. Testbench

The testbench is available at:

`tb/tb_traffic_light_controller.v`

The testbench generates a clock with a 10 ns period and verifies the controller's output signals.

The following conditions are tested:

| Test | Expected Result |
|---|---|
| Reset | NS Green, EW Red |
| State S1 | NS Yellow, EW Red |
| State S2 | NS Red, EW Green |
| State S3 | NS Red, EW Yellow |
| Complete cycle | Returns to NS Green |
| Reset during operation | Returns to NS Green |

## 9. Simulation Procedure

The design is compiled and simulated using Icarus Verilog.

Run the simulation with:

`./scripts/run_simulation.sh`

The simulation generates:

`waveforms/traffic_light.vcd`

The waveform can be viewed using GTKWave:

`gtkwave waveforms/traffic_light.vcd`

## 10. Simulation Results

All six testbench checks passed successfully.

The verified results are:
- Reset - NS Green: PASS
- NS Yellow: PASS
- EW Green: PASS
- EW Yellow: PASS
- Cycle back to NS Green: PASS
- Reset during operation: PASS

## 11. Logic Synthesis

The design was synthesized using Yosys.

The synthesis process completed successfully.

The synthesized netlist is available at:

`simulation/traffic_light_synth.v`

The synthesis log is available at:

`simulation/full_synthesis.log`

Yosys reported zero structural problems during the final design check.

## 12. Advantages

- Simple FSM-based design.
- Easy to understand and modify.
- Automatic traffic signal sequence.
- Reset functionality.
- Verified through simulation.
- Uses open-source development tools.

## 13. Applications

- Educational digital electronics projects.
- FPGA-based traffic signal demonstrations.
- Learning FSM design and Verilog programming.
- Basic traffic control system prototypes.

## 14. Conclusion

The traffic light controller was successfully designed using Verilog HDL and a four-state Finite State Machine.

The design was simulated using Icarus Verilog, and all six testbench checks passed. The simulation waveform was generated and the design was synthesized successfully using Yosys.

This project demonstrates the practical application of FSM concepts in digital system design.

## 15. Project Files

- RTL source: `rtl/traffic_light_controller.v`
- Testbench: `tb/tb_traffic_light_controller.v`
- Simulation script: `scripts/run_simulation.sh`
- Waveform: `waveforms/traffic_light.vcd`
- Synthesized netlist: `simulation/traffic_light_synth.v`
- Synthesis logs: `simulation/`
