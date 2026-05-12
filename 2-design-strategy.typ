#import "@preview/oasis-align:0.3.3": * 

== Guiding Design Philosophies
At the core of our organization is a cycle of research, learning, doing, and teaching. This philosophy informs our system's design. Our mechanical and electrical systems are built with modularity, simplicity, and rugged functionality in mind. As a first-year team, time, budget, and experience constraints require us to focus on making a few key systems work well, meaning we combine careful theoretical research with consistent, hands-on testing. High fidelity CAD models made using Onshape @onshape were used to plan the 3D layout and inform assembly procedures. We use 3D printing for rapid iteration, favor off-the-shelf components when possible to avoid unnecessary development costs, and design with practicality and durability in mind.

== Hull

=== Chassis
Manatee’s chassis is a ¼-inch aluminum base plate machined with a grid pattern of mounting holes. The hole-grid layout enables modularity and an iterative platform allowing us to easily mount, adjust, and swap out components. 

#figure(
  image("graphics/robot-with-labels.svg",width:100%),
  caption: [Structural CAD of Robot (designed in Onshape)]
) <robot-diagram>

As seen in @robot-diagram, the propulsion system follows a standard symmetrical layout @thrusters, with two thrusters in each corner: one angled horizontally beneath the chassis and the other mounted vertically in line with the base plate. The angled horizontal thrusters allow Manatee to propel itself forward, sideways, or control yaw independently from roll and pitch. Meanwhile, the vertical thrusters allow independent control of the pitch and roll of the vehicle. 

The need to improve the structural integrity of Manatee was made apparent during pool testing, where one of the thrusters cracked due to a collision. Adding thruster guards for the angled horizontal thrusters was done to prevent further damage to both the frame and the thrusters. To improve ease of handling for Manatee, we also added handles that made transportation safe and easier for team members.

==== Design Upgrades
One of our most meaningful lessons came from an early fault mounting system for our main waterproof tube. The original design relied on a two-part clamp that required careful alignment and over-tightening of bolts. This led to cracking the 3D-printed clamp, proving unreliable. Eventually, this concern became an issue when the clamp snapped in half one day at our workbench.

To correct this, we embedded a threaded aluminum insert into the 3D-printed mount and allowing the bolt to lock cleanly with a sliding mechanism, we created a far more secure and user-friendly solution. Now, the print significantly easier to handle with no loose parts alongside additional rigidity as one component complementing a physical preventative to overtightening the bolt. It was a small change that represented a larger shift toward engineering that is thoughtful, resilient, and practical.


=== Waterproof Enclosures
Our robot includes two primary waterproof enclosures: a main cylindrical tube that houses most of the electronics, and a smaller waterproof box mounted beneath the chassis to contain the downward-facing camera.

The main tube is mounted using the hinge-and-clasp system previously described and is sealed using a combination of penetrators and O-rings on the end cap. The secondary enclosure, located underneath the chassis, was designed to house the downward-facing camera. This enclosure is an off-the-shelf waterproof box modified with a 3D-printed internal support structure to match the geometry of the box, holding both the downwards facing camera and IMU. 

However, through testing and research, we encountered a critical limitation: the IMU required a USB-C connection, and routing that cable through a waterproof penetrator would either require splicing or re-crimping the connector — both of which posed a risk to signal quality and long-term performance. Given the importance of the IMU to our control system and position estimation, we made the decision to relocate it into the main tube, where it could connect directly to the processor without modification or potential signal degradation.

In order to validate successful water-proofing, strict testing procedures were undertaken to check and preserve the airtight seals. Main tube penetrators and O-rings are regularly inspected. The team also follows the guideline of vacuum pressure testing the enclosure before every water test, detailed in @pooltestprocedure.

=== Kill Switch 
The current kill switch aims to resolve many risks and challenges posed by the old system. The old kill switch needed to be physically turned clockwise, in addition to being located near a bundle of wires at the back of the robot. This made it both difficult and dangerous to locate and activate, as the diver would have to stick their hand near the thrusters. This problem was accentuated during our test runs whenever the robot would spin out of control. During one of these test runs, one of our members had gotten cut by the thrusters when trying to use the kill switch.
Our objectives for our new kill switch was to make it a reliable, easy-access, and durable kill switch system which can last for multiple runs. Making sure our kill switch system was safe was another objective we had in mind as well since we had past issues of safety with the old kill switch.
When finding different kinds of switches we wanted to use for our kill switch system, we wanted to think about ideas of which would be easier than turning an object on the robot. Things we had in mind were a pulling action where we would pull an object off or away from the robot or push a button which was on the robot. When realizing how hard it would be to push a button on our sub underwater, we decided to make a system where you would have to pull an object away from the sub. With this thinking we were able to narrow our choices to 3 different types of kill switches. 

The first was something boats used when the driver of the boat would accidentally fall off the boat when driving the boat. This involved a system where a switch would open when a lanyard connected to the sailors wrist would pull off a piece of the switch to activate and stop the boat from moving. The reason why we believed this would be a good choice for our sub was because it was a pulling action which was used for a kill switch system for a boat. This was something we could also implement easily onto our sub since it was acting as a mechanical switch. It was also very compact which could replace the spot on the back of our sub where our old switch was. The second idea was a hall effect sensor being used to read a magnet which would be externally near the hull of the sub which would be moved and pulled away when we needed to kill the robot. The reason why we believed this switch was a good choice as well was because it used a magnetic field to give us a digital high or low signal depending on how far the magnet was. We believed this gave us more control on how we could implement this on our system since we could determine when we would get our signal in code since the sensor would give us values in terms of the magnetic field. The last idea that we had for the kill switch system was a normally open magnetic reed switch which has the same idea of the hall effect sensor where a magnet nearby the hull of the ship would be pulled off and away from the sub to kill the robot which mean a magnet would be normally on the sub when the system was on. We ended up deciding the normally open magnetic reed switch was our best option of the 3 switches.

The reason why our first choice was not chosen was because we would have to create a breach in the hull since integrating that piece of the system would need a hole to be integrated into our system. Since we were having problems with water getting into the sub at some times during this year, making more holes into the sub were things we were trying to avoid. The reason why we did not go with the hall effect sensor was because there were problems with the hall effect sensor having misfires and getting incorrect data in temperatures of high heat. Although we are solving problems with heat dissipation in the sub, making sure we have a reliable kill switch in even the most harsh conditions we might face is important to us. The reason why we chose the normally open magnetic reed switch was because it was something easily integrated into our existing system. All we needed was a digital high and low reading on a pin on the pico which was something we would do easily with a pull down resistor circuit. Another reason why we chose the reed switch was because it worked even in hot temperatures which was better than our hall effect sensor since heat could be a problem we face. Also the magnetic reed switch being actuated with a magnetic field allows us to not have to make any holes into our sub when integrating this system since the magnetic field can go through the acrylic tube of our robot.  Some problems we thought could happen when using a magnetic reed switch were potential misfires due to vibrations or movements we have in the water. We were able to counteract this potential problem with an RC circuit onto our PCB which helps with debouncing the reed switch when we face those problems.

For the circuit we created for the magnetic reed switch we first created a system where there was a 3.3V pin on the pico which was in series with a 100 ohm resistor with our switch in series with that connected to a digital read pin on the pico. Then connected to the digital read pin was a 10,000 ohm resistor connected to ground to act as a pull down resistor. We created this circuit on a protoboard which we used for testing our circuit with the robot to act as our kill switch in testing. When confirming this system will work on our sub, we worked towards permanently keeping the system into our sub by creating a RC circuit with a pull down resistor on a PCB which connected to our thruster systems. Creating this on a PCB allows us to make our system more compact and save space inside our sub. Once our circuit was completed we worked on the mechanical side of the system which involves our arm and handle.
Our improved kill switch system consists of the railing parts, arm parts, and the internal hull part that hang around the main acrylic tube of the robot. 

To attach the outside system to the robot, we designed a railing parts onto the Mounting Plate. Two railing mounts bolted to the Mounting Plate act as the legs, while a rectangular plate we called the railing connect the two mounts and act as the plate for the arm. This railing system purpose is mainly to help account for changes in buoyancy, at which point we would change the positioning of the arm horizontally. Since we don’t expect the changes to be too radical, the positioning allows for a 1.6 inch degree of freedom horizontally. 

As aforementioned, on top of the railing system is the main arm which acts as the main support of the kill switch system. The whole arm system is divided into two different parts: the upper arm, which would turn off the robot, and the lower arm, which attaches the arm system to the railing. In between the two, there is a pivot point where the upper arm is able to rotate 180° around. In one state, the upper arm will be lying against the acrylic tube of the robot, which allows the whole robot to remain activate. The other state will be the arm rotated away from the robot, shutting off the robot. The upper arm also consists of a handle on its back, while its front follows the curvature of the acrylic glass, helping to line up this upper arm to the kill switch on the inside of the robot. The front of the upper arm also contains the epoxy coated (to account for rusting) neodymium magnets that keep the kill switch active are located in the middle of this upper arm. 

The final part for the kill switch system is the internal hull part, which attaches to the T plate inside the acrylic tube. This part curves around the tube internally, on the relatively same positioning as the upper arm. On the surface of the curve, is stainless steel metal parts with the magnetic reed switch underneath it. The stainless steel allows the neodymium magnet on the outside to be more attracted to the magnetic reed switch on the inside. A property of the stainless steel also reveals that if the magnet is rotated away from the tube, the stainless steel looses it’s magnetic field until the magnet comes closer again.

=== Binocular Camera Enclosures

=== Thruster Guards 
The fast-spinning propellers on Manny’s eight thrusters pose a danger towards people handling Manny, as well as the thrusters themselves. These issues became particularly apparent when Manny was deployed in one of Davis’ outdoor ponds. During this deployment, Manny’s thrusters were repeatedly caught in netting, roots, and all sorts of debris, damaging its propellers and risking mission failure. In addition, engineers who were handling the robot expressed concern towards having their fingers so close to fast-spinning propellers. These problems clearly called for a solution: a “thruster guard” that would block fingers and debris, while having minimal impact on the thrusters’ thrust characteristics.

[Placeholder: Image of old fully 3DP guard design]

Initially, the team tried to address this issue with fully 3D-printed thruster guards. Concentric rings were spaced such that fingers and large debris could not reach the propeller, and the entire assembly would cleanly clip onto the thruster without any secondary components. Unfortunately, this design was only good for addressing one problem: the safety of people handling the robot. It’s efficacy was subpar for outdoor deployments, where fine detritus was still able to get past the large gaps between rings and wreak havoc on the propellers.

Addressing this secondary design criteria required a pivot in thinking. While plastic 3D printing has its benefits in automating manufacturing and allowing for repeatable & complex geometries, it’s relatively coarse resolution made it infeasible to block fine detritus while minimizing thrust loss. An alternative material and manufacturing method was required.

[Placeholder: Image of new mesh guard design]

A fine 1mm aluminum mesh proved to be the perfect answer to this call. While the guard’s rim is still 3D-printed, the rest of the guard (the functional part of it) is made of the metal mesh. This mesh is attached to the rim with hot glue, which has a secondary benefit of preventing the mesh fraying. This design meets all of our pre-defined design criteria; the guard effectively blocks large and small debris, and testing has shown it has minimal effect on the thrusters’ thrust curves.

=== LED Indicator Lights

=== Thermal Considerations
After the relay we were using for our kill switch system had melted during last year’s competition, we started to consider implementing a thermal system to allow heat to be removed from the tube. Such a system would ensure none of our more important and valuable components would be at risk of being destroyed if we were to run the robot for extended periods of time. However, with the new redesign of our kill switch system, we decided to gather more information and monitor the applicable core or surface temperatures of the Raspberry Pi, speed controllers, buck converter, and Jetson nano—components we believed would pose a problem, before we made a decision to dissipate the heat. The core temperatures were recorded by the components themselves, relayed to the computer, while we used a Raspberry Pi Pico and temperature probes to collect and store surface temperature data.

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
  caption: [Electrical Diagram]
)

== Control System <control>
The design strategy for the control system is motivated by the selected tasks. These tasks require Manatee to perform dead-reckoning navigation between pre-programmed waypoints, "hover" at one location, and make fine adjustments with aid of the downward facing camera. The control system for Manatee is broken into two sections: executive control and low-level control. The role of the executive controller is to identify the current objective of the vehicle and select the necessary low-level controller mode to accomplish that objective, while the low-level controller performs the thruster and actuator control appropriate for the current task. 

#v(-1em)
#figure(
  image("graphics/controls-flowchart.svg"),
  caption: [Hardware-Process Flowchart]
)

=== Software Integration

A few central design goal follows this year's software architecture, build from what we learned over our first competition. First not modular enough, separation of concerns, disorganized, not documented, etc,etc,etc. As such, we designed dour software form the ground up to fully embrace ROS, pick from a range of UIs, more safety with heartbeat, software kill switch, ...

ROS2 @ros2 serves as the integration backbone for Manatee's software, running inside a onboard Raspberry Pi 5. Its provides interfaces like topics, services, and actions, which are used to unify sensor drivers, MATLAB-generated controllers, actuation nodes, and operator interfaces into a coherent system — each subsystem only needs to agree on an interface name and message type, with no knowledge of how its counterparts work internally. ROS2's DDS transport layer also extends this topology across machines transparently, so the onboard Pi 5, and a dedicated vision Raspberry Pi can communicate together share the same ROS2 network over Ethernet without any additional networking configuration. 

Manatee's software is organized into the following ROS2 nodes, each running as a separate process. A system architecture diagram will accompany this section.

- *Sensing:* `dvl` interfaces with the Waterlink DVL over serial; `inertial_sense_ros2` publishes IMU data.
- *Logging:* `data_logger` subscribes to DVL topics and writes timestamped CSV files for post-run analysis.
- *Control arbitration:* `soft_mux` selects the active control source; `mux_controller` provides a terminal interface for operators to switch modes.
- *Actuation:* `thrust_interface` converts ROS PWM messages into serial commands for the Raspberry Pi Pico, which drives the eight ESCs; `manipulator` sends dropper commands to a dedicated Arduino Uno over UART.
- *Operator interfaces:* `pwm_cli` provides interactive terminal-based manual control; `simple_joystick_controller` (MATLAB-generated) handles gamepad input via `rosbridge_server` over WebSocket; // the Tidalwave Interface is a Qt/QML desktop application for real-time telemetry monitoring
- *Mission execution:* `mission_executive` manages autonomous competition runs using a behavior tree (in active development on the mission-manager branch).

The two sensor nodesbeach layer upon lower level drivers. The IMU is served by the manufacturer-provided InertialSense ROS2 node @imu, which publishes orientation, angular rate, and acceleration to the network. The new Waterlink DVL replaces the previous Nortek sensor, and is interfaced through a custom C++ driver node written by the team. This node communicates over a serial connection using the Waterlink ASCII protocol, and publishes two topics consumed by the control system: `velocity_report` for instantaneous 3-axis velocity and `dead_reck_report` for accumulated dead-reckoning position and orientation. The `data_logger` node subscribes to both of these DVL topics and writes their data to timestamped CSV files on disk, enabling quantitative post-run analysis of navigation performance without any additional instrumentation.

Thruster commands flow through a two-stage safety pipeline. The `soft_mux` node arbitrates between a CTRL channel, carrying MATLAB-generated commands, and a CLI channel, carrying commands from the operator CLI. Both channels are protected by independent heartbeat watchdogs checked every 500 milliseconds: if the currently active source goes silent for more than one second, the mux immediately publishes an all-neutral stop command (1500 µs across all eight channels) and suppresses further output until the heartbeat resumes. A companion `mux_controller` node monitors the mux state and allows operators to switch channels without restarting any processes. 

Downstream, `thrust_interface` subscribes to the mux output and monitors the mux heartbeat independently — if that signal is lost, it commands all thrusters to neutral at the actuation boundary, providing a second fail-safe layer. Valid commands are clamped to a safe operating range and forwarded over USB serial to the Raspberry Pi Pico, which runs MicroPython firmware that parses each message and drives eight PWM output pins. The Pico also responds to hardware and software kill switch signals on dedicated GPIO pins, zeroing all outputs immediately on activation.

A central design goal this year is providing operators with a range of control interfaces that all route through the same `soft_mux` safety pipeline — a significant improvement over the previous approach, where the legacy CLI tool published directly to a non-standard topic with no heartbeat protection or arbitration. In the new architecture, every control source competes for the same two mux channels under identical safety guarantees. The `pwm_cli` node is a Python interactive console that accepts typed motion commands — forwards, backwards, strafe, rise, sink, yaw, pitch, roll — with configurable power percentage, optional time limits, and individual thruster overrides. It publishes heartbeats continuously and routes all commands through the CLI channel of the mux. The `simple_joystick_controller`, a MATLAB-generated node, reads gamepad axis data forwarded via a `rosbridge_server` WebSocket from a browser-based HTML page and maps inputs to PWM commands on the CTRL channel. Rounding out the operator toolset, the Tidalwave Interface is a standalone Qt/QML desktop application with a C++ ROS2 backend that subscribes to IMU and system-state topics, providing real-time attitude, velocity, and control-mode readouts to operators without touching the control pipeline. Live video is streamed from the robot's cameras using mediaMTX as an RTSP media server with ffmpeg capturing the v4l2 camera feed at 1080p/30 fps.

Manipulator control is handled by a dedicated `manipulator` node, which subscribes to the `manipulator_cmd` topic. Publishing a 1 or 2 triggers the corresponding dropper, sending a command over UART to an Arduino Uno that directly controls the deployment servos. After each deployment there is a two-second reset window, during which the servo returns to its rest position before the next command can be acted upon. Keeping the manipulator on a separate microcontroller from the thrusters ensures that a fault in the dropper path cannot interfere with propulsion.


Autonomous mission execution is handled by the `mission_executive` node, built on the BehaviorTree.CPP \@btcpp library. The previous mission system used a custom JSON-based parser and a hand-rolled interrupt-flag state machine, which made it difficult to express concurrent behaviors, add retry or timeout logic, or inspect running execution state. The new system defines mission logic as composable behavior trees in the library's standard XML format. Primitive actions — `NavigateToWaypoint`, `DetectObject`, `SendManipulatorCommand`, `WaitDuration` — are registered as leaf nodes and combined using built-in control flow constructs: `ReactiveSequence` for preemptable tasks, `RetryNode` for fault tolerance, and `Timeout` for bounded task durations. Shared state between ROS2 subscriptions and BT leaf nodes flows through the library's blackboard, and the system integrates with the Groot2 visualizer for live tree inspection during pool testing. New mission strategies can be authored in XML without modifying any C++ code, and parallel task execution — for example, monitoring battery state while navigating — is expressed as a tree structure rather than a threading problem.

The full onboard system is launched from a single shell script that opens a tmux session with each node in its own named pane across four windows: core control components, video streaming, sensors and logging, and the operator CLI. The workspace is built with `colcon` and includes a unit test suite covering individual node behavior in isolation.

=== Matlab Implementation
Wherever possible, control systems were designed and tested in MATLAB and Simulink. Mathematical models for the vehicle and control system were selected from @de2012spacecraft. Once tests, we created generated code files for embedded hardware using MATLAB's C-code generation capabilities. This allowed us to take advantage of MATLAB's many built-in mathematical models necessary for predicting vehicle dynamics and control.

Auto-PID tuning @TunePIDcontrollers for the controller was conducted on a digital twin of the robot which simulated the robots 6-degree-of-freedom dynamics, hydrostatic and hydrodynamic interactions, thrusters, and sensor-noise models. The fidelity of the digital twin was improved empirically using data gathered during pool-testing to perform least squares parameter estimation @ParameterEstimation of drag and inertial coefficients. 

The separation of the controller into two subsystems along with use of MATLAB’s advanced toolboxes allowed for rapid prototyping of the control system components in parallel with the development of the executive and embedded C-code, allowing different engineers on the team to play to their own strengths while maintaining the capability to combine the disparate pieces into an effective whole. 

#figure(
  image("graphics/controller-plant.svg"),
  caption: [Controller Flow Chart]
)

=== Vision System
Manatee's two cameras both feed into an Yolo V8 @YOLOv8 vision model running on a dedicated Raspberry Pi. The vehicle only uses its vision systems for two main tasks, recognizing which side of the gate it passes through and centering itself over the dropper. This cut the need for any sort of complex depth perception, but left the option to expand the complexity and use of our cameras and vision model in the future. In the coming year, we plan on implementing position estimation using the video streams in order to confirm and correct our location over the course of a competition run.

In future competition years we hope to improve our vision model to aid in navigation with optical flow and state estimation, as well as more complicated manipulation tasks. 

== Conclusions
The design strategy of the Cyclone RoboSub team is a research and testing driven approach to create a system that is simple, reliable, and adaptable. Lessons learned from attending previous competitions are distilled into Manatee’s requirements that optimize for competition score under the constraints of team resources and time.

Intrinsic to this goal is the construction of a strong foundation to build upon in subsequent competition years – a foundation not only of hardware and software but also of community. We build friendships, skills, and a love for science and engineering that we hope our team members will carry with them throughout their journey. Our competition vehicle is designed to evolve alongside the team. 
