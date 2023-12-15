# uma-535-635-project

Project files for ECE535/635 project

## Team Members
* Hakan Saplakoglu - [hsaplakoglu@umass.edu](mailto:hsaplakoglu@umass.edu)
* Tristan Liang - [tgliang@umass.edu](mailto:tgliang@umass.edu)

## Motivation
For low-power and non-internet connected remote sensors, it is not always possible to synchronize time effectively. This project aims to explore an alternative which uses similar events in the environment, recorded by sensors, to synchronize clocks between sensors.

## Design Goals
Develop a time sync protocol using timestamped sensor data from two embedded devices. The data will be received by a raspberry pi device, and the synchronization protocol will run on the raspberry pi device

## Deliverables
* Characterize network delay between raspberry pi and edge devices
* Estimate clock drift between participitaing devices

## System Blocks
![paros](https://github.com/hakasapl/uma-535-635-project/assets/40907639/dac62a85-7d47-4d88-9e5b-f3c9557ac5bc)

## Requirements (HW/SW)
* Raspberry PI connected to two ParosScientific barometers

## Timeline
* Initially, we plan to write basic scripts as a proof-of-concept to verify that we can use barometers to synchronize time without an external source.

## References
* Automated Synchronization of Driving Data Using Vibration and Steering Events
* FLIGHT: clock calibration using fluorescent lighting
* Exploiting Smartphone Peripherals for Precise Time Synchronization
