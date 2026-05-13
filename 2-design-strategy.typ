#import "@preview/oasis-align:0.3.3": * 


== Design Requirements
- Vehicle shall be controllable
  - Vehicle shall have vertical and horizontal motion decoupled
- Vehicle shall be safe to work with
  - Vehicle shall have multiple ways for disabling (physical, software)
  - All moving parts shall be protected
- Vehicle shall be adjustable over time
  - we may add manipulators, research sensors, camera's, etc.
- Vehicle shall be reliable
  - use commercially available parts where possible
  - all code shall have unit tests
  - all subsystems shall be tested before integration
  - full system shall be tested before deployments
- Vehicle shall be able to complete all navigation-based tasks
- Vehicle shall be deployable in research environments

== Guiding Design Philosophies
At the core of our organization is a cycle of research, learning, testing, and teaching. 
// This philosophy informs our system's design. 

Our mechanical and electrical systems are built with modularity, simplicity, and rugged functionality in mind. As a first-year team, time, budget, and experience constraints require us to focus on making a few key systems work well, meaning we combine careful theoretical research with consistent, hands-on testing. High fidelity CAD models made using Onshape @onshape were used to plan the 3D layout and inform assembly procedures. We use 3D printing for rapid iteration, favor off-the-shelf components when possible to avoid unnecessary development costs, and design with practicality and durability in mind.

== Hull

=== Chassis
Manatee’s chassis is a ¼-inch aluminum base plate machined with a grid pattern of mounting holes. The hole-grid layout enables modularity and an iterative platform allowing us to easily mount, adjust, and swap out components. 

#figure(
  image("graphics/robot-with-labels.svg",width:100%),
  caption: [Structural CAD of Robot (designed in Onshape)]
) <robot-diagram>

As seen in @robot-diagram, the propulsion system follows a standard symmetrical layout @thrusters, with two thrusters in each corner: one angled horizontally beneath the chassis and the other mounted vertically in line with the base plate. The angled horizontal thrusters allow Manatee to propel itself forward, sideways, or control yaw independently from roll and pitch. Meanwhile, the vertical thrusters allow independent control of the pitch and roll of the vehicle. 


=== Waterproof Enclosures
Our robot is comprised of a primary waterproof enclosure made of a cylindrical tube that houses most of the electronics.

The main tube is mounted using the hinge-and-clasp system and is sealed using a combination of penetrators and O-rings on the end cap.

In order to validate successful water-proofing, strict testing procedures were undertaken to check and preserve the airtight seals. Main tube penetrators and O-rings are regularly inspected. The team also follows the guideline of vacuum pressure testing the enclosure before every water test, detailed in @pooltestprocedure.

==== Binocular Camera Enclosures

=== Kill Switch 

The current kill switch aims to resolve many risks and challenges posed by the old system. The old kill switch needed to be physically turned clockwise, in addition to being located near a bundle of wires at the back of the robot.

Our objectives for our new kill switch was to make it usable through simple movements that cannot be activated accidently, locate it in an accessible position on the robot, as well as durable and flexible such that this system can be used longterm.

In terms of simple movements, ideas we had in mind initially were where we would pull an object off the robot or pushing a button. Eventually we narrowed our option to a pulling action as the accidental presses were a main concern. With this thinking, we narrowed down our options of kill switches. 

Some kill switches we looked at were a lanyard that were pulled to stop boat movement,a hall effect sensor that electrically read a magnet, and a magnetic reed switch that physically read a magnet.  We landed on a magnetic reed switch for three main reasons: it can be easily customized with a 3D print due to only requiring a switch & a magnet, it functioned in high temperature environments (unlike the hall effect sensor), and the physical attraction between the magnet & switch could keep it easily attached.
[diagram here]
The decision for a mechanical reed switch allowed us to create a system where a U-shaped handle containing a neodymium magnet is pulled away from it's attraction to the magnetic reed switch, turning the robot off. The choice for handle's rounded U-shape stops external objects from catching onto it, while being large enough that it cannot be damaged significantly. The 
 

// to add later today: discussion on the location of the kill switch + use of the arm. explanation for why we added a railing. diagrams for both. long term implementation and functionality discussion. edits on previous paragraphs. try to tie everything to the objectives.
 
=== Thruster Guards 
The fast-spinning propellers on Manny’s eight thrusters pose a danger towards people handling Manny, as well as the thrusters themselves. These issues became particularly apparent when Manny was deployed in one of Davis’ outdoor ponds. During this deployment, Manny’s thrusters were repeatedly caught in netting, roots, and all sorts of debris, damaging its propellers and risking mission failure. In addition, engineers who were handling the robot expressed concern towards having their fingers so close to fast-spinning propellers. These problems clearly called for a solution: a “thruster guard” that would block fingers and debris, while having minimal impact on the thrusters’ thrust characteristics.

[Placeholder: Image of new mesh guard design]

A fine 1mm aluminum mesh proved to be the perfect answer to this call. While the guard’s rim is still 3D-printed, the rest of the guard (the functional part of it) is made of the metal mesh. This mesh is attached to the rim with hot glue, which has a secondary benefit of preventing the mesh fraying. This design meets all of our pre-defined design criteria; the guard effectively blocks large and small debris, and testing has shown it has minimal effect on the thrusters’ thrust curves. A full design revision can be found in @thruster-guard-updates.

=== LED Indicator Lights

=== Thermal Considerations
Throughout development, there have been concerns about excess heat being generated in the tube. 
// Since it is a closed system, 

After the relay we were using for our kill switch system had melted during last year’s competition, we started to consider implementing a thermal system to allow heat to be removed from the tube. Such a system would ensure none of our components would be at risk of being destroyed if we were to run the robot for extended periods of time. However, with the new redesign of our kill switch system, we decided to gather more information and monitor the applicable core or surface temperatures of the Raspberry Pi, speed controllers, buck converter, and Jetson nano—components we believed would pose a problem, before we made a decision to dissipate the heat. The core temperatures were recorded by the components themselves, relayed to the computer, while we used a Raspberry Pi Pico and temperature probes to collect and store surface temperature data.

For the Raspberry Pi, we’ve seen that the core temperatures typically stays between 60°C and 65°C, well below the 80°C throttling temperature of the hardware. For our speed controllers, they are already attached to a copper heat sink, and has not exceeded a temperature of 34°C, showing no cause for concern. The buck converter also manages itself quite well thermally, with a documented maximum operating temperature of 75°C, while we measured an average surface temperature well below that at 30°C. Finally, the Jetson Nano had its average core temperature measured at \_\_\_, (above/below/at) its documented throttling temperature of 99°C.

From the data we have gathered, we do not see a need to further implement an advanced heating system. While one would completely ensure that there are no thermal problems in the future, with the state of our components, it does not outweigh the risk of breaching our hull to allow heat transfer from the inside of our robot to the surrounding water.

== Manipulation

=== Dropper
We designed a servo-actuated mechanism to individually release two small markers for the Bin task during competition runs. Manatee centers itself over the bin using the downward-facing camera. Once the vehicle is positioned over the correct image, markers are released using a servo-controlled camshaft that interfaces with the markers’ fins. Each component in this system can be quickly swapped out allowing for rapid, modular experimentation with different cam profiles, perfecting the release timing and repeatability. 

#figure(
    image("graphics/dropper_assembly.png", width: 40%),
    caption: [Dropper Assembly]
  )
// #oasis-align(
//   [],
//   [#figure(
//     image("images/bin.jpg"), 
//     caption: []
//   )]
// )

=== Torpedo
While not yet implemented on Manatee, development on a torpedo system is currently underway. The system uses elastic bands to store energy for individually launching two torpedoes. These bands are loaded and cocked by topside members, and are released by a servo linked to the vehicle’s control system.
The main roadblock towards implementation is the high shock load generated by the rapid release of the torpedoes. This caused the FDM 3D-printed parts to quickly fatigue and fail. To address this, the team is currently experimenting with stronger materials such as solid plastics and metals.

== Electrical System

=== Internal Electronics Mounting
The main design goal for the electronics mounting structure is maximizing the efficiency of space usage in the waterproof enclosures. When our original design strayed from this idea, we designed an upgrade based on what we learned. 
Our initial design featured a U-shaped layout which cupped the battery. A practical starting point, less frequently adjusted components could be placed within the U while more active development areas would remain outside for easy access. However, we quickly ran into several limitations: the battery was not adequately secured. Maintenance access also proved challenging, regardless of where components were mounted, and as our onboard systems grew in complexity, management became chaotic -- wires and components haphazardly zip-tied where they fit. The board no longer reflected our principles of clean, robust, and serviceable design.
To address these issues, we launched a collaborative redesign process. Subteams explored a wide range of concepts: X-shaped boards, stacked layers, and even hot-swappable modular prints tailored for specific systems. After rounds of prototyping and discussion, we arrived at a T-shaped layout – an evolution of the U that preserved visibility and accessibility while significantly improving surface area and wire organization. The decision to cluster all high-power components into one section of the board was key, allowing for easier isolation and testing of the power subsystem while freeing up valuable real estate for the rest of our electronics. This redesign significantly improved maintainability, visibility, and adherence to our design philosophies.
Last year, our internal electrical bracket redesign was founded in the idea of increased accessibility and modularity after having issues the year prior. This year, after keeping the electrical system largely constant, we observed that the current configuration meant that components often came unplugged or damaged during testing as a result of shifting in the tube. Thus, our modularity had caused system unreliability over time. 

After our first redesign of the internal electrical bracket last year, The design of the internal electrical mounting system was prompted by a critical spatial deficit and a decline in system reliability caused by excessive modularity. Because the vehicle’s core electronics—including the transition to a larger Jetson Nano—had reached a stage of permanent integration, the requirement for modular flexibility was superseded by the need for structural stability and wire protection. The primary success criteria for the redesigned bracket included the establishment of permanent component footprints, integrated wire routing channels to eliminate manual "wire wrangling," and a low-profile geometry that adhered to the strict physical constraints of the cylindrical hull. Furthermore, the design had to facilitate rapid maintenance while providing a dedicated, non-reflective channel for LED status indicators to ensure they did not interfere with the the front-facing cameras.

After evaluating materials including wood and aluminum, the team selected acrylic for the main mounting plate due to its balance of machineability, weight, and cost. A key technical challenge involved the decision to thread bolts directly into the acrylic plate to eliminate the bulk of interface hardware; while there were initial concerns regarding the durability of these threads, rigorous stress testing confirmed their integrity throughout repeated assembly cycles. The final T-shaped geometry preserves accessibility to the hull's interior while maintaining the existing compact battery housing. This integrated mounting strategy has significant long-term implications for the team’s testing efficiency; by guaranteeing the physical security of every connection, the team can now simplify pre-dive procedures by bypassing routine wire-continuity checks, only performing deep-dives when a specific fault is observed. This transition from a flexible, high-maintenance prototype to a fixed, optimized internal architecture ensures that the electronic system remains robust, organized, and free from the mechanical failures associated with shifting components.
\
\
#oasis-align(
  [#figure(
    image("images/internals.jpg"),
    caption: [Internal Electrical Systems]
  )],
  [#figure(
    image("images/pcb.jpg"), 
    caption: [5V PDB]
  )]
)
\
=== Power Distribution
The details of the power distribution system are described in detail in @electricalsystem. The key challenges faced by the electrical system were thermal management and space constraints.

Thermal performance issues stem from the Electronic Speed Controllers (ESCs) and processors overheating during extended operation. For better cooling we added a “heat bank” coupling the ESCs to a copper plate. This plate absorbs and stores heat until the AUV can be recovered post-run. 

Our power system has grown, space constraints are a pressing issue. Looking ahead, we are exploring improved cooling solutions, including strategies like water cooling and heat pipes. 
The redesign for Manny’s electrical documentation was driven by an identified disparity between system complexity and the legibility of existing documentation. In previous iterations, we encountered significant operational delays and internal confusion due to schematics that lacked standardized representations of the system, failing to effectively communicate the interconnectivity of the robot's signal and power systems during modifications, testing, and debugging. To rectify this, we established a redesign strategy centered on three success criteria: universal legibility for a multi-disciplinary audience across all Subteams, clear hierarchical signal and power flow, and the implementation of industry-standard symbolic logic for components. The transition from informal drawing tools to KiCAD allowed for a "top-down" architectural approach that traced power from the battery and signal from the Jetson Nano (“the brains”), which was validated through iterative design reviews and "blind legibility" testing where the schematic’s efficacy was measured by the ability of non-electrical team members to accurately trace power and data paths without prior guidance.

During these validation and design reviews, critical refinements were made to balance technical density with intuitive visual logic. Feedback pointed toward the necessity of an accurate but symbolic representations of components that utilized clear icons complemented by rigorous technical descriptions. This led to the implementation of accessible color-coding and distinct line patterns for various wire types, ensuring signal differentiation remained clear even in high-density regions. Furthermore, the team increased the specificity of redundant components to eliminate ambiguity; for example, generic labels were replaced with functional descriptors, such as transitioning from "Camera 1" to "Front Facing Camera – Left." This new documentation serves as a sustainable framework for the robot’s long-term evolution, managing the complexity of point-to-point wiring through hierarchical block logic. By establishing this document, the team has not only resolved immediate confusion regarding distribution but has also created a scalable roadmap for future upgrades, such as nested sub-sheets for granular component "zoom-ins" and integration with an electrical bill of materials.

#figure(
  image("graphics/electrical-diagram.svg",width:100%),
  caption: [Electrical Diagram],
  scope: "parent",
  placement: top,
)

== Control System <control>
The design strategy for the control system is motivated by the selected tasks. These tasks require Manatee to perform dead-reckoning navigation between pre-programmed waypoints, "hover" at one location, and make fine adjustments with aid of the downward facing camera. The control system for Manatee is broken into two sections: executive control and low-level control. The role of the executive controller is to identify the current objective of the vehicle and select the necessary low-level controller mode to accomplish that objective, while the low-level controller performs the thruster and actuator control appropriate for the current task. 

#figure(
  image("graphics/sys-arch.svg"),
  caption: [Software Architecture Flowchart],
  scope: "parent",
  placement: top
)

=== Software Integration <software>

Last year was our first year writing software for the robot, and our central design goals for this year follow from what we learned from that experience. Our software stack last year had limited modularity, lacked a unifying core design, was organized haphazardly at best, and was poorly documented. We identified a few reasons for these shortcomings, including insufficient planning and project organization, the use of git submodules, and lack of main branch protection. To improve project organization, we improved our use of GitHub features like issues and linked pull requests. To address core software quality issues we rewrote our codebase from scratch, with modularity and stability as core design goals. To maintain stability, we protected our main branch and implemented a rigorous software testing regime. For modularity, we designed with a ROS-oriented @ros2 approach from the ground up from the beginning of the design process. The interface between our components is defined by their ROS topics, services, and actions, which allows for the nodes to be easily replaced or simulated for testing (which is particularly useful for MATLAB controller development). 

ROS2 @ros2 serves as the integration backbone for Manatee's software, running onboard the Raspberry Pi 5. Its provides an interface defined by topics, services, and actions, which are used to unify sensor drivers, MATLAB-generated controllers, actuation nodes, and operator interfaces into a coherent system: each subsystem only needs to agree on an interface name and message type, with no knowledge of how its counterparts work internally. ROS2's DDS transport layer also extends this topology across machines transparently: as long as machines are on the same network, they can communicate over ROS. This is invaluable for testing, where we can run a MATLAB model on a groundstation computer that communicates with the onboard Pi 5.

Manatee's software is organized into the following ROS2 nodes, each running as a separate process. A system architecture diagram will accompany this section.

- *Sensing:* `dvl` interfaces with the Waterlinked DVL over serial; `inertial_sense_ros2` publishes IMU data.
- *Logging:* `data_logger` subscribes to DVL & IMU topics and writes timestamped CSV files for post-run analysis, especially for research deployments.
- *Control arbitration:* `soft_mux` selects the active control source; `mux_controller` provides a terminal interface for operators to switch modes.
- *Actuation:* `thrust_interface` converts ROS PWM messages into serial commands for the Raspberry Pi Pico, which drives the eight ESCs; `manipulator` sends dropper commands to the ESP32 microcontroller.
- *Operator interfaces:* `pwm_cli` provides interactive terminal-based manual control, useful for diagnostics; `simple_joystick_controller` (MATLAB-generated) handles gamepad input via `rosbridge_server` over WebSocket; // the Tidalwave Interface is a Qt/QML desktop application for real-time telemetry monitoring
- *Mission execution:* `mission_manager` manages autonomous competition runs using a behavior tree (in active development on the mission-manager branch).
- *Controller:* 

The two sensor nodes each layer upon lower level drivers. The IMU is served by the manufacturer-provided InertialSense ROS2 node @imu, which publishes orientation, angular rate, and acceleration to the network. The new Waterlinked DVL replaces the previous Nortek sensor, and is interfaced through a custom C++ driver node written by the team. This node communicates over a serial connection using the Waterlinked ASCII protocol, and publishes two topics consumed by the control system: `velocity_report` for an instantaneous 3-axis velocity and `dead_reck_report` for accumulated dead-reckoning position and orientation. The `data_logger` node subscribes to both of these DVL topics and writes their data to timestamped CSV files on disk, enabling quantitative post-run analysis of navigation performance without any additional instrumentation.

Thruster commands flow through a two-stage safety pipeline. The `soft_mux` node arbitrates between a CTRL channel, carrying MATLAB-generated commands, and a CLI channel, carrying commands from the operator CLI. Both channels are protected by independent heartbeat watchdogs checked every 500 milliseconds: if the currently active source goes silent for more than one second, the mux immediately publishes an all-neutral stop command (1500 µs across all eight channels) and suppresses further output until the heartbeat resumes. A companion `mux_controller` node monitors the mux state and allows operators to switch channels without restarting any processes. 

Downstream, `thrust_interface` subscribes to the mux output and monitors the mux heartbeat independently — if that signal is lost, it commands all thrusters to neutral at the actuation boundary, providing a second fail-safe layer. Valid commands are clamped to a safe operating range and forwarded over USB serial to the Raspberry Pi Pico, which runs MicroPython firmware that parses each message and drives eight PWM output pins. A heartbeat ping is also sent to the Pico over the same connection stream: if the Pico doesn't receive a heartbeat or PWM signal after one second, it zeroes its output until the next command is received. The Pico also responds to the hardware kill switch signal on a dedicated GPIO pin, zeroing all outputs immediately on activation.

A central design goal this year is providing operators with a range of control interfaces that all route through the same `soft_mux` safety pipeline — a significant improvement over the previous approach, where the legacy CLI tool published directly to a non-standard topic with no heartbeat protection or arbitration. In the new architecture, every control source competes for the same two mux channels under identical safety guarantees. The `pwm_cli` node is a Python interactive console that accepts typed motion commands — forwards, backwards, strafe, rise, sink, yaw, pitch, roll — with configurable power percentage, optional time limits, and individual thruster overrides. It publishes a heartbeat continuously and routes all commands through the CLI channel of the mux. The `simple_joystick_controller`, a MATLAB-generated node, reads gamepad axis data forwarded via a the Tidalwave Interface and maps inputs to PWM commands on the CTRL channel. The Tidalwave Interface is a standalone Qt/QML desktop application with a C++ ROS2 backend that subscribes to IMU and system-state topics, providing real-time attitude, velocity, and control-mode readouts to operators without touching the control pipeline. Live video is streamed from the robot's cameras using mediaMTX as an RTSP media server with ffmpeg capturing the v4l2 camera feed at 1080p/30 fps.

Manipulator control is handled by a dedicated `manipulator` node, which subscribes to the `manipulator_cmd` topic. Publishing a 1 or 2 triggers the corresponding dropper, sending a command over ROS to the ESP32 that directly controls the deployment servos. After each deployment there is a two-second reset window, during which the servo returns to its rest position before the next command can be acted upon. Keeping the manipulator on a separate microcontroller from the thrusters ensures that a fault in the dropper path cannot interfere with propulsion.

Autonomous mission execution is handled by the `mission_executive` node, built on the BehaviorTree.CPP \@btcpp library. The previous mission system used a custom JSON-based parser and a hand-rolled interrupt-flag state machine, which made it difficult to express concurrent behaviors, add retry or timeout logic, or inspect running execution state. The new system defines mission logic as composable behavior trees in the library's standard XML format. Primitive actions — `NavigateToWaypoint`, `DetectObject`, `SendManipulatorCommand`, `WaitDuration` — are registered as leaf nodes and combined using built-in control flow constructs: `ReactiveSequence` for preemptable tasks, `RetryNode` for fault tolerance, and `Timeout` for bounded task durations. Shared state between ROS2 subscriptions and BT leaf nodes flows through the library's blackboard, and the system integrates with the Groot2 visualizer for live tree inspection during pool testing. New mission strategies can be authored in XML without modifying any C++ code, and parallel task execution — for example, monitoring battery state while navigating — is expressed as a tree structure rather than a threading problem.

The full onboard system is launched from a single shell script that opens a tmux session with each node in its own named pane across four windows: core control components, video streaming, sensors and logging, and the operator CLI. The workspace is built with `colcon` and includes a unit test suite covering individual node behavior in isolation.

=== Control System


#figure(
  image("graphics/controller-plant.svg"),
  caption: [LAST YEARS REPLACE WITH UPDATED IMAGE SHOWCASING ROS ENABLED HARDWARE-IN-THE-LOOP TESTING ],
  scope: "parent",
  placement: top
)

=== Vision System
Manatee's two cameras both feed into an Yolo V8 @YOLOv8 vision model running on a dedicated Raspberry Pi. The vehicle only uses its vision systems for two main tasks, recognizing which side of the gate it passes through and centering itself over the dropper. This cut the need for any sort of complex depth perception, but left the option to expand the complexity and use of our cameras and vision model in the future. In the coming year, we plan on implementing position estimation using the video streams in order to confirm and correct our location over the course of a competition run.

In future competition years we hope to improve our vision model to aid in navigation with optical flow and state estimation, as well as more complicated manipulation tasks. 

== Conclusions
The design strategy of the Cyclone RoboSub team is a research and testing driven approach to create a system that is simple, reliable, and adaptable. Lessons learned from attending previous competitions are distilled into Manatee’s requirements that optimize for competition score under the constraints of team resources and time.

Intrinsic to this goal is the construction of a strong foundation to build upon in subsequent competition years – a foundation not only of hardware and software but also of community. We build friendships, skills, and a love for science and engineering that we hope our team members will carry with them throughout their journey. Our competition vehicle is designed to evolve alongside the team. 
