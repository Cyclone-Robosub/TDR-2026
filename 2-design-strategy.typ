#import "@preview/oasis-align:0.3.3": * 

== Introduction
Explain what we are pitching Manatee as

Here is the state that we are in, and here is what we tried to achieve


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

testing. 
// This philosophy informs our system's design

== Guiding Design Philosophies
This season, we are using the same AUV, Manatee, as we did in the 2025 season. This decision gave our controls subteam a stable platform to rigorously test their control systems developments year-round. To enable this testing plan, the team adopted a design philosophy of evolution over revolution during the 2025-2026 season. Rather than completely overhauling Manatee's function, the team identified specific points of improvement in the AUV's design and worked to address them. These changes were incremental, keeping Manatee pool-test-ready year round, but still amounted to significant improvements in a few important design categories:

1. Making Manatee safer,
2. Giving the controls subteam more control over Manatee
3. Making Manatee more reliable,
4. Making Manatee ready for real research deployments.

Manatee's core features--its aluminum base plate, thruster configuration, and acrylic tube enclosure--were left unchanged. All changes are built on top of this base.

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

=== Binocular Camera Enclosures
A feature the controls and vision subteams wanted for this year was stereoscopic vision, as well as a bottom-facing camera to better perform tasks like Bin. Stereoscopic vision necessitates external camera enclosures, because the acrylic tube enclosure is not wide enough to give adequate camera spacing for depth perception.

The team explored buying a ready-made enclosure, but every option was either too bulky, too expensive, or simply not fit for the task. Eventually, we discovered research @waterproof-paper indicating that SLA 3D-printed enclosures can achieve depth ratings exceeding 1000 meters and are relatively cheap to manufacture.

#figure(
  image("images/camera-enclosure.png", width: 40%),caption: [CAD assembly of the camera enclosure (designed in Onshape)]
) <camera-assembly>

We designed our own SLA-printed enclosures, as seen in @camera-assembly. There are three identical copies of this enclosure on Manatee: two facing forward for stereoscopic vision and one facing downwards. Inside each enclosure is a USB-powered camera, connected to a cable that goes through a BlueRobotics Wetlink penetrator for waterproofing. The camera can sees outside the enclosure with a 3/8" clear acrylic plate, sealed on with a large circular O-ring. The enclosures are held on the robot with stainless steel bolts and a toothed crown for angular indexing.

#figure(
  image("images/junction-box-assembly.png", width: 
  60%),caption: [CAD assembly of the junction box (designed in Onshape)]
) <junction-assembly>

To minimize the number of penetrators these cameras take up on the main enclosure, a 3-to-1 junction box was also designed and manufactured with SLA 3D printing, shown in @junction-assembly. In this box, the three camera cables merge into a single, 12-wire cord that only takes up one penetrator slot on the main enclosure. This implementation does cause electromagnetic interference between  the camera wires, but the team is currently working on solutions such as coaxial sheathing for each individual camera cable set.

=== Kill Switch 
According to our design philosophy of making the Manatee safer, reliable, and ready, our team approached the design failures of our previous kill switch. It was inaccessible, ineffective, and posed a danger to the diver, who had to navigate the high-powered thrusters. Additionally, it was located in the back, in the midst of the main penetrators, and needed to be rotated ninety degrees clockwise.

Following our guiding principles, the technical objective for our new kill switch was to make a reliable, easy access, and durable kill switch system. Our success criteria are simple implementation, maintaining hull integrity, user-friendliness, and positioning in an accessible area.

To trigger the switch, our team decided on a pulling action, as we were concerned about accidental presses. So, we found three different components matching this idea: a boat safety lanyard that triggers when pulled, a Hall effect sensor that electrically reads a magnetic field, and a normally open magnetic reed switch that closes a switch with a magnetic field. From the principles of keeping the system simple and reliable across wide temperature ranges, we decided on the magnetic reed switch. 

From here, we worked on the mechanical implementation. To tackle accessibility, we placed the kill switch in the middle over the acrylic tube. This allows for access from all angles, protection from the metal frame, and distance away from the thrusters.
 
This decision allowed us to create a system where a U-shaped handle containing a neodymium magnet is pulled away from the magnetic reed switch and its steel plate, as shown in @kill-switch-assembly. The rounded U-shape stops the robot from being snagged, improving the reliability of the design to handle many deployments in the water. Furthermore, the magnetic reed switch is accompanied by a stainless steel plate, strengthening its magnetic field when a magnet is present, which ensures the kill switch is not accidentally detached. Finally, our railing system helps with the alignment of the magnet and the switch.


#figure(
    image("graphics/ks-assembly-v3.png", width: 80%),
    caption: [Kill Switch System Assembly]
  )<kill-switch-assembly>

In the long term, some adjustments can be made such that the whole system is a lot more compact. Additionally, this new kill switch system sets us up for future modifications, such as a go-switch, which will go alongside the kill switch. Overall, this reliable system is a new safer way to turn off the robot in the face of danger. 


 
=== Thruster Guards 
The fast-spinning propellers on Manatee’s eight thrusters pose a danger towards people handling it, as well as the thrusters themselves. These issues became particularly apparent when Manatee was deployed in one of Davis’ outdoor ponds. During this deployment, Manatee's thrusters were repeatedly caught in netting, roots, and all sorts of debris, damaging its propellers and risking mission failure. In addition, engineers who were handling the robot expressed concern towards having their fingers so close to fast-spinning propellers. These problems clearly called for a solution: a “thruster guard” that would block fingers and debris, while having minimal impact on the thrusters’ thrust characteristics.

[Placeholder: Image of new mesh guard design]

A fine 1mm aluminum mesh proved to be the perfect answer to this call. While the guard’s rim is still 3D-printed, the rest of the guard (the functional part of it) is made of the metal mesh. This mesh is attached to the rim with hot glue, which has a secondary benefit of preventing the mesh fraying. This design meets all of our pre-defined design criteria; the guard effectively blocks large and small debris, and testing has shown it has minimal effect on the thrusters’ thrust curves. A full design revision can be found in.

=== LED Indicator Lights

=== Thermal Considerations
Throughout development, there have been concerns about excess heat being generated in the tube. 
// Since it is a closed system, 

After the relay we were using for our kill switch system had melted during last year’s competition, we started to consider implementing a thermal system to allow heat to be removed from the tube. Such a system would ensure none of our components would be at risk of being destroyed if we were to run the robot for extended periods of time. However, with the new redesign of our kill switch system, we decided to gather more information and monitor the applicable core or surface temperatures of the Raspberry Pi, speed controllers, buck converter, and Jetson nano—components we believed would pose a problem, before we made a decision to dissipate the heat. The core temperatures were recorded by the components themselves, relayed to the computer, while we used a Raspberry Pi Pico and temperature probes to collect and store surface temperature data.

For the Raspberry Pi, we’ve seen that the core temperatures typically stays between 60°C and 65°C, well below the 80°C throttling temperature of the hardware. For our speed controllers, they are already attached to a copper heat sink, and has not exceeded a temperature of 34°C, showing no cause for concern. The buck converter also manages itself quite well thermally, with a documented maximum operating temperature of 75°C, while we measured an average surface temperature well below that at 30°C. Finally, the Jetson Nano had its average core temperature measured at \_\_\_, (above/below/at) its documented throttling temperature of 99°C.

From the data we have gathered, we do not see a need to further implement an advanced heating system. While one would completely ensure that there are no thermal problems in the future, with the state of our components, it does not outweigh the risk of breaching our hull to allow heat transfer from the inside of our robot to the surrounding water.

== Manipulation

=== Dropper
The dropper is a servo-actuated mechanism used to individually release two small markers for the Bin task during competition runs. Both droppers are held in a 3D-printed box, mounted with a downward facing camera. Once Manatee determines the location of the Bin, it centers itself and releases a marker. The marker is released using a servo-controlled cam that interfaces with the markers’ fins. Each component of the dropper can be quickly swapped out, allowing for rapid, modular experimentation.

Manatee’s dropper servo is directly connected to an ESP32. The servo is separately powered by the buck converter. The ESP received commands from the central brain of the Raspberry Pi. The control system for the Bin task can be found in Appendix adhdajsjas.

Limitations with the dropper we designed is the use of the ESP32 with the servo. The ESP32 is helpful temporarily as it can run basic functions via Raspberry Pi for the servo, but it uses space in Manatee’s hull inefficiently. We can improve our design by directly coding the servo commands onto the Raspberry Pi’s PWM capabilities. 

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

== Electrical System

=== Internal Electronics Mounting
The main design goal for the electronics mounting structure is maximizing the efficiency of space usage in the waterproof enclosures. When our original design strayed from this idea, we set out on a redesign based on what we learned. 
Last year, our initial design featured a T-shaped layout designed for visibility, accessibility, and modularity that features large surface area and clean wire organization. 
This year, after keeping the electrical system largely constant, we observed that the current configuration meant that components often came unplugged or damaged during testing as a result of shifting in the tube. Thus, our modularity had caused system unreliability over time. 

 Because the vehicle’s core electronics—including the transition to a larger Jetson Nano—had reached a stage of permanent integration, the requirement for modular flexibility was superseded by the need for structural stability and wire protections. The primary success criteria for the redesigned bracket included the establishment of permanent component footprints, integrated wire routing channels to eliminate manual "wire wrangling," and a low-profile geometry that adhered to the strict physical constraints of the cylindrical hull. Furthermore, the design had to facilitate rapid maintenance while providing a dedicated, non-reflective channel for LED status indicators to ensure they did not interfere with the the front-facing cameras.

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
  placement: top)

== Control System <control>
=== Overview
To understand the structure of Manny's control system we begin by describing at a high level how we intend to complete the Robosub competition. Once the major systems are described, a more detailed description will be provided for key components of the control system. 

The competition run begins with the construction of a _mission file_. This file describes a decision tree of _commands_ that the robot attempts to execute in series. Each command includes a _command id_, as well as multiple _command parameters_ that define the behavior of the robot during operation. Commands are intended to be human-readable to allow rapid tuning of mission file, for example "drive to `<waypoint>` and stay there for `<hold time>`, "hold a `<position>` and `<bearing>` with respect `<object>` in the pool", and "perform a barrel roll while driving forward for `<duration>`". This mission file is loaded into the robot via a wired connection, then started using the go-switch. 

Within each controller time step, the following operations are performed:
1. The Mission Manager consults the mission file and the status of any ongoing commands and delivers a single command to the Low Level Controller which contains the Command Executer, Guidance Law, and Cascaded Controller.
2. The Command Executer parses the parameters of the command into a waypoint (position and attitude) in the world reference frame and sends it to the Guidance Law, then returns a _command status_ to the Mission Manager evaluated based on sensor data, state estimation, the the command parameters.
3. The Guidance Law generates an intermediate waypoint based on the waypoint from the Command Executer to break up the maneuver into distinct turning, driving, and settling components depending on the distance to the waypoint and the relative attitude of the body with respect to the waypoint direction. 
4. The Cascaded Controller accepts the intermediate waypoint from the Guidance Law and generates the appropriate thruster commands to translate and rotate the robot to the waypoint. 

Steps 1-4 are iterated through until the decision tree reaches an end point or the robot is deactivated using the on switch or the kill switch. 

The design of the control system is subdivided between the Software and Control teams. The Software team handles the sensor reading, command thrusters, communication betweens subsystems, and the mission file. See the Software Integration section for more information on these topics.

=== Controller Design in MATLAB and Simulink
The Low Level Controller was developed using MATLAB and Simulink. Simulink was chosen both for the wide variety of useful design toolboxes and for the low barrier of entry for engineering students with prior Matlab experience. The Low Level Controller and the State Estimator were designed as a ROS2 nodes that inputs sensor data and commands from the mission file, and outputs individual thruster commands. These nodes are then generated into C++ using the Simulink Coder Toolbox for operation on the robot. 

This system was designed with three unique operating modes in mind: fully simulated, hardware-in-loop, and competition. The fully-simulated mode is critical for debugging and software development. This mode is intended to be run entirely on one computer without needing connection to the real robot. The hardware-in-loop mode is the next step in the testing process. This mode is enabled by the Simulink ROS2 Toolbox where the controller is run within MATLAB on single computer and tethered to the robot with its inputs and outputs being ROS2 nodes. 

[Within this mode the controller is run in MATLAB and tethered to the robot to command thrusters and read sensors to identify issues that cannot be found in simulation.] 

Finally, the competition mode the Low Level Controller and State Estimator ROS nodes in C++, generated from the Matlab code. This three part approach allows the validation of system level logic entirely in simulation so pool-testing time is spent debugging complicated integration issues, tuning the controller, and mission files. 

In addition to the two code-generated components, we developed considerable Simulink infrastructure to test system-level operation entirely in Simulation. A diagram for the system is shown below in FIGURE TBA.

The full Simulink codebase contains the following features:
1. A minimal copy of Mission Manager to test ability of the Low Level Controller to execute commands and transition between commands.
2. The Low Level Controller containing the Command Executer, Guidance Law, and Cascaded Controller. 
3. The plant model of the robot simulating 6-dof dynamics, thrusters, buoyancy, gravity, and hydrodynamic forces.
4. An environment and camera model using Unreal Engine co-simulation for development of computer vision algorithms using the Simulink 3D Animation and Computer Vision toolboxes.
5. A sensor model for the Waterlinked DVL and the InertialSense IMU.
6. A state estimator to fuse camera, IMU, and DVL data into a state estimate.

The Simulink project contains various other useful tools including for parameter estimation tools for the drag and inertia matrices based on pool-testing data, custom animation and plotting code to speed up debugging, and controller tuning utilities to tune the 12 PID controllers in the Cascaded Controller. 

For a more detailed description of TBD, see appendex TBD.


=== State Estimator

=== Computer Vision




=== Software Integration <software>

Last year was our first year writing software for the robot, and our central design goals for this year follow from what we learned from that experience. Our software stack last year had limited modularity, lacked a unifying core design, was organized haphazardly at best, and was poorly documented. We identified a few reasons for these shortcomings, including insufficient planning and project organization, the use of git submodules, and lack of main branch protection. To improve project organization, we improved our use of GitHub features like issues and linked pull requests. To address core software quality issues we rewrote our codebase from scratch, with modularity and stability as core design goals. To maintain stability, we protected our main branch and implemented a rigorous software testing regime. For modularity, we designed with a ROS-oriented @ros2 approach from the ground up from the beginning of the design process. The interface between our components is defined by their ROS topics, services, and actions, which allows for the nodes to be easily replaced or simulated for testing (which is particularly useful for MATLAB controller development). 

ROS2 @ros2 serves as the integration backbone for Manatee's software, running onboard the Raspberry Pi 5. Its provides an interface defined by topics, services, and actions, which are used to unify sensor drivers, MATLAB-generated controllers, actuation nodes, and operator interfaces into a coherent system: each subsystem only needs to agree on an interface name and message type, with no knowledge of how its counterparts work internally. ROS2's DDS transport layer also extends this topology across machines transparently: as long as machines are on the same network, they can communicate over ROS. This is invaluable for testing, where we can run a MATLAB model on a groundstation computer that communicates with the onboard Pi 5.

Manatee's software is organized into the following ROS2 nodes, each running as a separate process. The diagram below presents current the software architecture of Manatee.

sys-archSoftware Architecture,
  scope: "parent",
  placement: top
- *Sensing:* `dvl` interfaces with the Waterlinked DVL over serial; `inertial_sense_ros2` publishes IMU data.
- *Logging:* `data_logger` subscribes to DVL & IMU topics and writes timestamped CSV files for post-run analysis, especially for research deployments.to the ESP32 microcontroller., useful for diagnosticsmanager
- *Controller:*  . ed a serialedan  A heartbeat ping is also sent to the Pico over the same connection stream: if the Pico doesn't receive a heartbeat or PWM signal after one second, it zeroes its output until the next command is received.the kill a  athe Tidalwave Interface andTheover ROS to the ESP32=== Overview
To understand the structure of Manny's control system we begin by describing at a high level how we intend to complete the Robosub competition. Once the major systems are described, a more detailed description will be provided for key components of the control system. 

The competition run begins with the construction of a _mission file_. This file describes a decision tree of _commands_ that the robot attempts to execute in series. Each command includes a _command id_, as well as multiple _command parameters_ that define the behavior of the robot during operation. Commands are intended to be human-readable to allow rapid tuning of mission file, for example "drive to `<waypoint>` and stay there for `<hold time>`, "hold a `<position>` and `<bearing>` with respect `<object>` in the pool", and "perform a barrel roll while driving forward for `<duration>`". This mission file is loaded into the robot via a wired connection, then started using the go-switch. 

Within each controller time step, the following operations are performed:
1. The Mission Manager consults the mission file and the status of any ongoing commands and delivers a single command to the Low Level Controller which contains the Command Executer, Guidance Law, and Cascaded Controller.
2. The Command Executer parses the parameters of the command into a waypoint (position and attitude) in the world reference frame and sends it to the Guidance Law, then returns a _command status_ to the Mission Manager evaluated based on sensor data, state estimation, the the command parameters.
3. The Guidance Law generates an intermediate waypoint based on the waypoint from the Command Executer to break up the maneuver into distinct turning, driving, and settling components depending on the distance to the waypoint and the relative attitude of the body with respect to the waypoint direction. 
4. The Cascaded Controller accepts the intermediate waypoint from the Guidance Law and generates the appropriate thruster commands to translate and rotate the robot to the waypoint. 

Steps 1-4 are iterated through until the decision tree reaches an end point or the robot is deactivated using the on switch or the kill switch. 

The design of the control system is subdivided between the Software and Control teams. The Software team handles the sensor reading, command thrusters, communication betweens subsystems, and the mission file. See the Software Integration section for more information on these topics.

=== Controller Design in MATLAB and Simulink
The Low Level Controller was developed using MATLAB and Simulink. Simulink was chosen both for the wide variety of useful design toolboxes and for the low barrier of entry for engineering students with prior Matlab experience. The Low Level Controller and the State Estimator were designed as a ROS2 nodes that inputs sensor data and commands from the mission file, and outputs individual thruster commands. These nodes are then generated into C++ using the Simulink Coder Toolbox for operation on the robot. 

This system was designed with three unique operating modes in mind: fully simulated, hardware-in-loop, and competition. The fully-simulated mode is critical for debugging and software development. This mode is intended to be run entirely on one computer without needing connection to the real robot. The hardware-in-loop mode is the next step in the testing process. This mode is enabled by the Simulink ROS2 Toolbox where the controller is run within MATLAB on single computer and tethered to the robot with its inputs and outputs being ROS2 nodes. 

[Within this mode the controller is run in MATLAB and tethered to the robot to command thrusters and read sensors to identify issues that cannot be found in simulation.] 

Finally, the competition mode the Low Level Controller and State Estimator ROS nodes in C++, generated from the Matlab code. This three part approach allows the validation of system level logic entirely in simulation so pool-testing time is spent debugging complicated integration issues, tuning the controller, and mission files. 

In addition to the two code-generated components, we developed considerable Simulink infrastructure to test system-level operation entirely in Simulation. A diagram for the system is shown below in FIGURE TBA.

The full Simulink codebase contains the following features:
1. A minimal copy of Mission Manager to test ability of the Low Level Controller to execute commands and transition between commands.
2. The Low Level Controller containing the Command Executer, Guidance Law, and Cascaded Controller. 
3. The plant model of the robot simulating 6-dof dynamics, thrusters, buoyancy, gravity, and hydrodynamic forces.
4. An environment and camera model using Unreal Engine co-simulation for development of computer vision algorithms using the Simulink 3D Animation and Computer Vision toolboxes.
5. A sensor model for the Waterlinked DVL and the InertialSense IMU.
6. A state estimator to fuse camera, IMU, and DVL data into a state estimate.

The Simulink project contains various other useful tools including for parameter estimation tools for the drag and inertia matrices based on pool-testing data, custom animation and plotting code to speed up debugging, and controller tuning utilities to tune the 12 PID controllers in the Cascaded Controller. 

For a more detailed description of TBD, see appendex TBD.


=== State Estimator

=== Computer Vision






=== Software Integration <software>

Last year was our first year writing software for the robot, and our central design goals for this year follow from what we learned from that experience. Our software stack last year had limited modularity, lacked a unifying core design, was organized haphazardly at best, and was poorly documented. We identified a few reasons for these shortcomings, including insufficient planning and project organization, the use of git submodules, and lack of main branch protection. To improve project organization, we improved our use of GitHub features like issues and linked pull requests. To address core software quality issues we rewrote our codebase from scratch, with modularity and stability as core design goals. To maintain stability, we protected our main branch and implemented a rigorous software testing regime. For modularity, we designed with a ROS-oriented @ros2 approach from the ground up from the beginning of the design process. The interface between our components is defined by their ROS topics, services, and actions, which allows for the nodes to be easily replaced or simulated for testing (which is particularly useful for MATLAB controller development). 

ROS2 @ros2 serves as the integration backbone for Manatee's software, running onboard the Raspberry Pi 5. Its provides an interface defined by topics, services, and actions, which are used to unify sensor drivers, MATLAB-generated controllers, actuation nodes, and operator interfaces into a coherent system: each subsystem only needs to agree on an interface name and message type, with no knowledge of how its counterparts work internally. ROS2's DDS transport layer also extends this topology across machines transparently: as long as machines are on the same network, they can communicate over ROS. This is invaluable for testing, where we can run a MATLAB model on a groundstation computer that communicates with the onboard Pi 5.

Manatee's software is organized into the following ROS2 nodes, each running as a separate process. The diagram below presents current the software architecture of Manatee.

sys-archSoftware Architecture,
  scope: "parent",
  placement: top
- *Sensing:* `dvl` interfaces with the Waterlinked DVL over serial; `inertial_sense_ros2` publishes IMU data.
- *Logging:* `data_logger` subscribes to DVL & IMU topics and writes timestamped CSV files for post-run analysis, especially for research deployments.to the ESP32 microcontroller., useful for diagnosticsmanager
- *Controller:*  . ed a serialedan  A heartbeat ping is also sent to the Pico over the same connection stream: if the Pico doesn't receive a heartbeat or PWM signal after one second, it zeroes its output until the next command is received.the kill a  athe Tidalwave Interface andTheover ROS to the ESP32figure(
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

Manipulator control is handled by a dedicated `manipulator` node, which subscribes to the `manipulator_cmd` topic. Publishing a 1 or 2 triggers the corresponding dropper, sending a command over ROS to the ESP32 that directly controls the deployment servos. After each deployment there is a two-second reset window, during which the servo returns to its rest position before the next command can be acted upon. Keeping the manipulator on a separate microcontroller from the thrusters ensures that a fault in the dropper path cannot interfere with propulsion.Autonomous mission execution is handled by the `mission_executive` node, built on the BehaviorTree.CPP \@btcpp library. The previous mission system used a custom JSON-based parser and a hand-rolled interrupt-flag state machine, which made it difficult to express concurrent behaviors, add retry or timeout logic, or inspect running execution state. The new system defines mission logic as composable behavior trees in the library's standard XML format. Primitive actions — `NavigateToWaypoint`, `DetectObject`, `SendManipulatorCommand`, `WaitDuration` — are registered as leaf nodes and combined using built-in control flow constructs: `ReactiveSequence` for preemptable tasks, `RetryNode` for fault tolerance, and `Timeout` for bounded task durations. Shared state between ROS2 subscriptions and BT leaf nodes flows through the library's blackboard, and the system integrates with the Groot2 visualizer for live tree inspection during pool testing. New mission strategies can be authored in XML without modifying any C++ code, and parallel task execution — for example, monitoring battery state while navigating — is expressed as a tree structure rather than a threading problem.

The full onboard system is launched from a single shell script that opens a tmux session with each node in its own named pane across four windows: core control components, video streaming, sensors and logging, and the operator CLI. The workspace is built with `colcon` and includes a unit test suite covering individual node behavior in isolation.

=== Control SystemLAST YEARS REPLACE WITH UPDATED IMAGE SHOWCASING ROS ENABLED HARDWARE-IN-THE-LOOP TESTING ,
  scope: "parent",
  placement: topControl SystemLAST YEARS REPLACE WITH UPDATED IMAGE SHOWCASING ROS ENABLED HARDWARE-IN-THE-LOOP TESTING ,
  scope: "parent",
  placement: topControl System


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
