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
=== Matlab Implementation
Wherever possible, control systems were designed and tested in MATLAB and Simulink. Mathematical models for the vehicle and control system were selected from @de2012spacecraft. Once tests, we created generated code files for embedded hardware using MATLAB's C-code generation capabilities. This allowed us to take advantage of MATLAB's many built-in mathematical models necessary for predicting vehicle dynamics and control.

Auto-PID tuning @TunePIDcontrollers for the controller was conducted on a digital twin of the robot which simulated the robots 6-degree-of-freedom dynamics, hydrostatic and hydrodynamic interactions, thrusters, and sensor-noise models. The fidelity of the digital twin was improved empirically using data gathered during pool-testing to perform least squares parameter estimation @ParameterEstimation of drag and inertial coefficients. 

The separation of the controller into two subsystems along with use of MATLAB’s advanced toolboxes allowed for rapid prototyping of the control system components in parallel with the development of the executive and embedded C-code, allowing different engineers on the team to play to their own strengths while maintaining the capability to combine the disparate pieces into an effective whole. 

#figure(
  image("graphics/controller-plant.svg"),
  caption: [Controller Flow Chart]
)

=== Software Integration
High level integration relies on ROS2 @ros2 for inter-process communication and modularity. ROS2 provides an abstraction for multi-threading, simplifies the development process, and enables cross-language development.

Most of Manatee's sensors and peripherals have dedicated ROS nodes which interface with the rest of the system. This decouples the code base from the low level implementation, enabling system modularity and improved debugging workflows. These edge nodes are a mix of manufacturer provided SDKs and custom written software. 

Manatee interfaces with its DVL and IMU using ROS nodes provided by Nortek and InertialSense respectively. Most other devices use custom software. For example, Manatee's thrusters are controlled using the PWM peripheral of a Raspberry Pi Pico. The Pico uses USB to communicate with a node running on a Raspberry Pi 5. The control system can send PWM commands to this node by publishing to a topic, rather than directly interfacing with the Pico over USB.

While most of Manatee is implemented in C++, Python is used in areas where performance is less critical. During testing, Manatee can be controlled with a command-line tool written in Python. This sped up development through the use of a higher-level language.

=== Vision System
Manatee's two cameras both feed into an Yolo V8 @YOLOv8 vision model running on a dedicated Raspberry Pi. The vehicle only uses its vision systems for two main tasks, recognizing which side of the gate it passes through and centering itself over the dropper. This cut the need for any sort of complex depth perception, but left the option to expand the complexity and use of our cameras and vision model in the future. In the coming year, we plan on implementing position estimation using the video streams in order to confirm and correct our location over the course of a competition run.

In future competition years we hope to improve our vision model to aid in navigation with optical flow and state estimation, as well as more complicated manipulation tasks. 

== Conclusions
The design strategy of the Cyclone RoboSub team is a research and testing driven approach to create a system that is simple, reliable, and adaptable. Lessons learned from attending previous competitions are distilled into Manatee’s requirements that optimize for competition score under the constraints of team resources and time.

Intrinsic to this goal is the construction of a strong foundation to build upon in subsequent competition years – a foundation not only of hardware and software but also of community. We build friendships, skills, and a love for science and engineering that we hope our team members will carry with them throughout their journey. Our competition vehicle is designed to evolve alongside the team. 
