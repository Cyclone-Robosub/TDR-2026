#import "oasis-align.typ": * 

#set par(
  first-line-indent: (amount: 0in, all: false),
  spacing: 1.2em
)
#show heading.where(level:3): it => block(text(1em, it.body))
#show heading.where(level: 2): it => context{
  if counter(heading).get() != (5,1) {pagebreak()}
  it
}

#set image(fit: "cover", width: 100%)
#set grid(column-gutter: .125in)
// #set heading(numbering: "1.2.3")

// #show ref.where(
//   form: "normal"
// ): set ref(supplement: it => {
//   if it.func() == heading {
//     "Chapter"
//   } else {
//     "Thing"
//   }
// })

//== Bill of Materials
//insert table version of BOM time permitting

== Task Breakdown <taskbreakdown>
#table(
  columns: 3, 
  ..csv("data/task-rankings.csv").flatten()
)


== Pool Test Procedure <pooltestprocedure>
The team has developed a procedure to check the submarine for preparedness, before submerging the robot in the water.
=== Check First
Make sure pressure holds:
- 15mmHg for 10 minutes 
If not:
    
    - Visually inspect o-rings for proper seal.
    - Ensure tube is completely closed
    - Inspect pressurizer to make sure it has a good seal
    - Tug cables running into Wetlink penetrators

=== WiggleTest
Give all components a gentle wiggle to see if they move or come loose (be EXTRA careful with the wires)

Does something move?
- Alert Hull lead if it’s serious (use best judgement)
- Bolt? Tighten it back into place.
- Wetlink? Take it apart and put it back together by reseating the wires.
- Wire? Plug it back in or tighten the connector.

Make sure the battery is at operational voltage (16.8V)
- Use the battery charger (or multimeter) and check that the voltage is at 16.8V

Not at correct voltage?
- Plug in the battery until it reaches the desired voltage

=== Electrical
- Battery plugged in
- Components light up/make sounds
    - ESCs
    - Raspberry Pi
    - Sensors
    - Cameras
- Thruster wires are out of the way of the thrusters
- Ethernet cable is organized and will not get caught with movement.
- Kill switch is off

=== Mechanical
- Tube clasps are secured down // tube is secured.
- Pressure plug is all the way in
- Ensure bumpers (and all other 3D printed guards) are secured



=== Clean up.
Done with testing? Time to clean up!

- Battery is plugged in and on “Discharge” to get battery to storage voltage (14.8V)
- All wires are plugged in and out of the way of the tube closing
- Tube is closed
- Plug is in
- Ensure all tools are put away in the toolbox
    -  Make sure all sets of tools are complete
    
== MATLAB Simulink Implementation
To determine the robot's current objective, the executive controller is pre-programmed with information about the location of tasks and obstacles within the pool alongside the desired order to accomplish these tasks. Once autonomous operation begins, the executive controller leverages sensor data to determine if the success criteria for the task has been met by the low-level controller and updates the control strategy accordingly. The executive is also responsible for monitoring telemetry data including time and battery capacity to adjust task priority and ensure safe operation. 

The low-level controller inputs measurements from the camera system, DVL, and IMU, as well as context from the executive controller to generate thruster commands. The DVL plus the IMU allows for much more stable navigation than an IMU alone due to accumulated integral error. State estimation is performed using the sensors to estimate the vehicle's attitude and position in the world frame with position measured relative to the starting point. Sensor fusion of the DVL and IMU (which includes a magnetometer) is used for roll and pitch stability as well as heading control. The low-level controller can be configured by the executive to hold a constant position, navigate to a pre-programmed waypoint, perform a barrel-roll for style points, or center an object in the downward facing camera's field of view. In the future, an improved vision system could aid navigation by allowing for vision based pose estimation and optical flow to account for sensor drift.

#figure(
  image("images/matlab plant.png",width:95%),
  caption: [MATLAB Simulink Model]
)

#figure(
  image("6DoF_PID.png"),
  caption: [The 6-Axis degree of freedom PID Controller. We implemented a Yaw Overshoot correcter to stop the yaw error increasing spontaneously in situations where Manatee needed to turn around 180 degrees.]
)

== Simulink Parameter Estimation
To have a higher fidelity simulation of Manatee, we utilized MATLAB's parameter estimation capabilities to refine our drag and inertial coefficients. Thruster commands are used as the model input while sensor data gathered during the pool tests were used as the model outputs. The mapping between the true thruster inputs and measured sensor data is a function of the various drag parameters, which are estimated from the data. Implementing these empirically informed coefficients into our MATLAB simulation then allowed us to iterate our PID coefficients with the auto-PID tuner.

=== Model Setup

- Create a Simulink model of the system whose parameters you must estimate.
    - Configure it as an open loop system with the input and output blocks in the locations of the model containing unknown parameters corresponding with the measurement data.
    - In this example, the input is torques and the output is the Euler angles.

#figure(
  image("images/simulink model setup 1.png",width:60%),
  caption: [ ]
)
- load the data files output with the input and output into the workspace
=== Parameter Estimation
- Open the parameter estimation app
- New experiment
#figure(
  image("images/simulink model setup 2.png",width:40%),
  caption: []
)
- Make sure the input and output are selected that correspond to the data to be used to estimate the parameter
#figure(
  image("images/simulink model setup 3.png",width:40%),
  caption: []
)
- Enter the input and output data using the variable name in the workspace. 
#figure(
  image("images/simulink model setup 4.png",width:40%),
  caption: []
)
- Hit plot, then close the experiment window. You should see a plot of the input and output data.
#figure(
  image("images/simulink model setup 5.png",width:40%),
  caption: []
)
- Return to the parameter estimation tab and click “select parameters”.
- Click select parameters again, then click the continuous or discrete check box next to the parameter you wish to estimate. In this that is the inertia matrix I.
#figure(
  image("images/simulink model setup 6.png",width:60%),
  caption: []
)
- Click "OK". Back on the parameter estimation page, set an initial guess (in my case the identity matrix) and make sure estimate is checked.
#figure(
  image("images/simulink model setup 7.png",width:50%),
  caption: []
)
- Hit date model, close, then estimate
- The app will vary the parameter I until the input and output in simulation match the data. For high frequency data sets this could take a very long time
#figure(
  image("images/simulink model setup 8.png",width:70%),
  caption: []
)

== Vision Data Collection
To train our vision model for competition, we conducted numerous data collection sessions in order to gather data inputs for training and testing our YOLO vision model. We made an effort to emulate real game elements and game conditions as close as possible. Robust datasets were taken in order to generalize the vision model which could adapt to varied competition environments. Detailed below are the measures we took to replicate real competition conditions.

- Accurate game elements - All game elements are constructed to match their real competition counterparts. This includes using accurate colors, materials, and geometries based on previous year's courses and available information on current tasks.
- Multiple angles - We recorded video footage from a wide range of angles, especially on critical game elements including the _Gate_ and _Paths_. We ensured that we collected ample footage in close range of the image targets on the gates to model the vehicle passing beneath them.
- Multiple light levels - We use two Blue Robotics Low Light cameras which help to filter out blue light underwater. We were unsure of the exact weather conditions at competition. To account for this we recorded footage on both sunny and overcast conditions.
#oasis-align(
  [#figure(
    image("images/vision data collection.jpg"),
    caption: [AUV Testing]
  )],
  [#figure(
    image("images/vision-model.jpg"), 
    caption: [Vision Model Testing Dataset Sample]
  )]
)


#oasis-align(
  [#figure(
    image("images/water-warp.png"),
    caption: [View of AUV Front Camera During Testing]
  )],
  [#figure(
    image("images/bin.jpg"), 
    caption: [Sample Dropper Bin for Vision Training]
  )]
)



== Software Unit Testing
To ensure reliability, code is assumed to be nonfunctional until testing is complete. We follow the protocol that all code on the main branch must be tested and fully functional. Members create working branches for in-progress and untested code, which is then pulled to main once testing is complete. All unit tests must pass before code can be pulled to main.

We use the GTest framework for our C++ unit tests, and pytest for our Python unit tests. Every function should be rigorously tested to ensure that it behaves correctly under all input, including edge cases. Testing can be run with a flag for real hardware, or for simulated hardware. Simulated hardware tests confirm that the correct commands are sent to the Raspberry Pi Pico that runs the thrusters, while tests on real hardware confirm that the Pico received the correct messages and didn't return any error messages, through echoing received commands back over the serial connection that it received the messages. Any code changes that impact the transfer of messages to the Pico should be verified on real hardware before being pulled to main.

The final step in validating correct behavior is regular pool testing, where we ensure that the code actually moves the robot in the ways that we expect it to. We create extensive logs for later examination, troubleshooting, and verification. These pool tests are performed about once every one to two weeks, on an as-needed basis.

== Electrical System <electricalsystem>
Our power distribution system is split into two distinct pathways: high power (16V) and low power (5V). This separation helps isolate sensitive components from high-current loads, improving system safety, organization, and troubleshooting. For a full overview, refer to the electrical schematic included above.

Power begins at the 16V battery, which connects to both the High Power Distribution Board (HPDB) and a relay-based kill switch (discussed in a later section). The HPDB supplies current directly to the Electronic Speed Controllers (ESCs) and thrusters, while also feeding into a buck converter that steps the voltage down to 5V. From there, power is passed to our Low Power Distribution Board (LPDB) — a custom-designed PCB that distributes power to our processors.

Our control system — what we call the “Brains”—includes the Main Raspberry Pi, a Camera Pi, Raspberry Pi Pico, and an Arduino. Each of these components handles a critical piece of the AUV’s functionality:

- The Main Pi manages system-level integration and sensor fusion (e.g., IMU data),
- The Camera Pi handles real-time image processing from both onboard cameras,
- The Pico generates PWM signals to drive the thrusters,

And the Arduino governs servo control for the Manipulation subsystem and handles environmental sensor inputs like temperature, pH, and depth.

One of the key features of our system is the kill switch, which safely cuts power to the high-power lines (thrusters) while maintaining power to the Brains. This enables safer debugging and rebooting procedures without a full power-down of the system.

From the Camera Pi, there are two cameras onboard the AUV: forward-facing and downwards-facing. 



== Vehicle Transportation
=== Background
We fabricated a custom bicycle trailer that allows us to transport our robot, tools, Ethernet tether, and other equipment between our main workshop and the pools where we test. 

=== Reasoning
- Walking and pulling a wagon
  - One way trip duration: 20 minutes
  - Pros:
    - Inexpensive (a decent wagon is about \$80)
  - Cons:
    - Slowest
- Driving
  - One-way trip duration: 8 minutes
  - Pros:
    - Can bring the most equipment
  - Cons:
    - The nearest parking lot is 0.4 miles from our workshop
    - Parking is \$17
- Bicycling with a trailer
  - One-way trip duration: 5 minutes
  - Pros:
    - Fastest
    - Davis is one of the most bike-friendly cities in the United States
    - Almost everyone on the team has a bike
  - Cons:
    - More expensive than a wagon (~400 for the entire build)

=== Design Requirements
Must: 
- Be able to securely hold the robot (22”x25”x14”)
- Be able to transport/store all of the required equipment 
    - Extension cord
    - Powerstrip
    - Ethernet tether
    - Robot batteries and chargers
    - Two spare parts boxes (14”x7”x4.5”)
    - Toolbox
    - Soldering iron
    - Bike pump
    - Basic first aid kit
- Serve as a mobile workstation
- Be freestanding when not attached to a bike
- Be able to fit through an ADA compliant door
- Be able to fit in the trunk of a car
 
Nice to have:
- Lighting
- Umbrella holder

=== Design Implementation
#oasis-align(
  [#figure(
  box(
    stroke: 1pt + gray,
    radius: 2%,
    image("images/Cart Assembly (4).png")
  ),
  caption: [Render of Cart]
)],
  [#figure(
  image("images/BareCart.jpg"),
  caption: [Bare frame]
)]
)

The core of the trailer is a bicycle trailer that we purchased from Amazon. We removed the plastic flooring and side walls of the trailer, including the upwards protrusions that are used to attach the side walls to the frame. 

The majority of the structure that we added to the trailer is laser cut ½” birch plywood. We chose birch plywood because it is relatively affordable, lightweight, easy to laser cut (150W CO2), and sufficiently durable for this application. The plywood panels are aligned with box joints and glued and screwed together. After the plywood parts were assembled, we bolted the structure to the frame of the cart. 

#oasis-align(
  [
    #figure(
      image("images/AssembledPanels.jpg"),
      caption: [Panel Assembly]
    )
  ],
  [
    #figure(
      image("images/Laser.jpg"),
      caption: [Laser Cutting Panels]
    )    
  ]
)



We then bolted the toolbox to the trailer and attached the power strip. Because we did not want the cord of the power strip to flop around while the trailer is in motion, we cut off the standard three prong plug and wired the power strip into a surface mount male receptacle. 

#oasis-align(
  [#figure(
  image("images/PowerHookup.jpg"),
  caption: [Power Supply]
)],
  [#figure(
  image("images/Kickstand.jpg"),
  caption: [Cart Storage]
)]
)

To keep the cart stable, we added a folding front kickstand and a bolt-on rear kickstand that also acts as the tailgate of the trailer. To secure the robot to the trailer for transport, we use 6” ¼-20 bolts that go up from the underside of the tabletop and through the chassis of the robot.

=== Completed Cart

// #show image: box.with(stroke: 2pt)
#oasis-align(
  // forced-frac: 0.5,
  // debug:true,
  [#figure(
  image("images/David.jpg"),
  caption: [Completed Cart]
)],
  [#figure(
  image("images/PicnicDay.jpg"),
  caption: [Cart on Display]
)]
)



== Tether Management
Our team decided to design our own spooling system to manage our tether. We chose this solution to save costs and add flexibility in how we managed our 50 meters of heavy duty Ethernet cable.
#oasis-align(
  [#figure(
    image("spool-images/spool-iso-front.png"),
    caption: [Front Trimetric View of Tether Spool]
  )],
  [#figure(
    image("spool-images/spool-iso-back.png"), 
    caption: [Back Trimetric View of Tether Spool]
  )]
)
#oasis-align(
  [#figure(
    image("spool-images/spool-right.png"),
    caption: [Side View of Tether Spool]
  )],
  [#figure(
    image("spool-images/spool-top.png"), 
    caption: [Section View of Tether Spool]
  )]
)

== Leadership Structure

The Cyclone RoboSub is organized into two groups: Sub-Teams and Divisions. There are six subteams (Navigation, Propulsion, Hull, Manipulation, Research, Public Relations), each led by student leaders who are primarily responsible for project execution. Conversely, there are three divisions (Mechanical, Electrical, Software), each with multiple leaders who are subject matter experts and primarily responsible knowledge-sharing among the team. This structure has enabled the team to support a wide verity of student and projects. 

=== Leadership Selection Process
- Applications open to all team members whether they are freshmen who just joined or seniors looking for hands on experience before they graduate.
- Applications are reviewed by current leadership members.
- Applicants are given 15 minute informal interviews where they are provided an overview of what they can expect as a leadership member and responsibilities are openly discussed.
- The current leadership team conducts a final round of reviews
- New leadership is announced and on boarded



== New Member Training
Introducing new members to the team and ensuring they have a meaningful experience is one of the fundamental missions of our team. We leverage accessibility in a number of ways including the decision to omit membership dues and open leadership applications to anyone with an interest regardless of experience.

*Battle Boats:*

2024 saw the introduction of a new team member training activity titled battle boats! This group based, competition-style technical training served as a fun way to provide new members with an onramp into marine robotics. Details of the program are listed below. This past year we saw over 50 students participate in our training program and it set the fast paced, community oriented tone that we would maintain throughout the rest of the year!

- Premise - Team members would randomly be assigned to groups of 5 and tasked with the design and build of a small remote controlled boat for use in a capture the flag style competition. Trainings would be held to teach members the basic skills needed to build the vehicle and members could decide who would focus on which area: software, electrical, or mechanical.
- Competition - Each group would be paired with another team and face off against two opposing teams. Each side would be given a structure which held a loop of yarn which would serve as the team’s flag and could be snagged by an opposing battle boat. Teams could win the game by “capturing” the opposing team’s flag or by popping small balloons attached to the backs of each vehicle.
- Results - 8 different teams competed with over 50 students participating in the challenge. The competition style trainings encouraged personal investment and forced teams to think critically about how they designed their vehicles. Each battle boat was completely unique and teams were introduced to concepts of motor control, propulsion, and buoyancy.
#oasis-align(
  [#figure(
    image("images/Battle boats discussion.jpg"),
    caption: [Team Members working on their battle boat]
  )],
  [#figure(
    image("images/Battle boats electrical presentation.jpg"), 
    caption: [Workshop for Electrical.]
  )]
)

#oasis-align(
  [#figure(
    image("images/Battle boats example.JPG"),
    caption: [Battle Boat Example]
  )],
  [#figure(
    image("images/Battle boats face off.JPG"), 
    caption: [Two Battle Boats in a Face-Off]
  )]
)


== Outreach
Over the past year, Cyclone RoboSub has engaged in a series of community outreach events on the UC Davis campus. Outreach gives us the opportunity to connect with new students and share the work our team is doing with the wider community. Events like Picnic Day, a UC Davis tradition, give our members the chance to educate the public about marine robotics and the engineering behind Manatee.

#oasis-align(
  [#figure(
    image("images/clubfair.JPG"),
    caption: [Fall Engineering Club Fair]
  )],
  [#figure(
    image("images/picnic day.png"), 
    caption: [UC Davis Picnic Day]
  )]
)
#oasis-align(
  [#figure(
    image("images/design showcase.jpg"),
    caption: [Student Design Showcase]
  )],
  [#figure(
    image("images/sponsor showcase.jpg"), 
    caption: [Sponsor Showcase]
  )]
)

== Team Branding
As with everything on our team, we chose to be extremely deliberate with our branding which was developed during the team’s formation in 2024. The strategies behind our branding elements are listed below:

- Team Name - Cyclone RoboSub was selected as the team name because we felt that the word “Cyclone” would be associated with rotation while staying unique from other RoboSub teams. Within our university the “RoboSub” part of “Cyclone RoboSub” quickly and clearly communicates what the team does: submarine robotics. Instead of being Cyclone AUV who’s acronym is not widely recognized.
- Team Colors - We chose teal and white as it felt clean and tied in well with our Cyclone theming while also distinguishing ourselves from the traditional blue and gold color scheme employed by the University of California System. Three shades of teal were selected and are prevalent across all of our media and branding
- Team Logo - The Cyclone RoboSub logo was designed in Inkscape with simplicity at heart. We wanted a logo that was easily recognizable and conveyed the rotational nature of a cyclone. Alongside our colored logo, we also have a version in black and white along with inverted black and white for official documents.
- Wave Patterning – Across our media you can find a distinct wave pattern using three shades of teal. The regular use of this patterning creates a cohesive brand and is not overly distracting to the viewer.
- Fonts - We have an official set of font guidelines which are used for all official competition materials. Fonts used are Righteous for titles and Prompt for body text.

All branding resources are maintained on our GitHub for easy access!

https://github.com/Cyclone-Robosub/Cyclone-Logos/

#oasis-align(
  [#figure(
    image("images/Cyclone Propeller Logo CTL.png"),
    caption: [Cyclone Propeller Logo]
  )],
  [#figure(
    image("images/Cyclone Title Card CTL (1).png"), 
    caption: [Cyclone RoboSub Title Card]
  )]
)
#oasis-align(
  [#figure(
    image("images/colors.png"),
    caption: [Cyclone RoboSub Color Pallet]
  )],
  [#figure(
    image("images/Cyclone Title Card BWL.png"), 
    caption: [Cyclone RoboSub Title Card (B&W)]
  )]
)

== Environmental Research
Beyond the competition, Cyclone RoboSub is contributing to environmental research efforts through field deployments and interdepartmental collaborations. Equipped with sensors to measure temperature, depth, pH, and dissolved oxygen, the vehicle can collect environmental data and is scheduled to take two transects along the UC Davis Arboretum. The team is also exploring opportunities to contribute to marine science research at the Bodega Marine Lab.

Beyond the competition, Cyclone RoboSub is contributing to environmental research efforts through field deployments and interdepartmental collaborations. Our team is unique in that we have had a subteam dedicated to research since day one. The goal of the research team is to coordinate and implement opportunities to get our team involved in marine and environmental research. AUVs are a versatile technology and our hope is to provide students within the environmental and marine sciences the chance to get involved and engaged with high end technology. This past year, our Research Subteam has worked to implement a new suite of sensors and discuss data collection opportunities with local researchers at UC Davis.

=== Sensors for Data Collection:
- Temperature sensor - collects live temperature readings useful for understanding water properties.
- Depth Sensor - Used in combination with other data sets during vertical transects
- Doppler Velocity Logger & IMU – used for geospatial records as a reference for other data sets
- pH Sensor - Records live water pH data
- Dissolved Oxygen Logger - Records dissolved oxygen content every minute
- Cameras - Can record imagery of aquatic life and algal populations

=== Planned Research Deployments
- UC Davis Arboretum Transect – The UC Davis Arboretum is a stretch of natural land within the campus which follows Putah Creek. Sections of the Arboretum were remodeled over the past year to improve wildlife habitats and wetlands. Our vehicle, Manatee, will be deployed to measure the current pH, temperature, and dissolved oxygen content of the Arboretum at two locations through vertical transects. The vehicle will be deployed at the site, manually navigate to the estimated deepest location and slowly descend while taking readings. These readings will be compared with those taken before the renovation to assess impact.
- UC Davis Tahoe Environmental Research Center - Multiple members of our team have spent time conducting research for the UC Davis Tahoe Environmental Research Center and our plan is to use it as our first serious field testing site. The clarity and low current conditions of Lake Tahoe make it an ideal location to test Manatee’s abilities. Our hope is to collect imagery of algal populations and record pH and temperature data in collaboration with their researchers in the Summer of 2025
- UC Davis Bodega Marine Laboratory - This year we have actively discussed collaboration efforts between Cyclone RoboSub and the Stachowicz Marine Research Lab. We presented to their researcher on the capabilities of Manatee and they proposed cases in which they would benefit from the use of an underwater vehicle. Use cases included taking temperature samples of soil at low tides, recording imagery of fish species, and collecting light level data at various depths to evaluate seagrass photosynthesis. After further testing of Manatee, we plan to revisit these proposals and select which seem to be feasible. 

#oasis-align(
  [#figure(
    image("images/research.jpg"), 
    caption: [pH Sensor Calibration]
  )],
  [#figure(
    image("images/arb.jpg"),
    caption: [UC Davis Arboretum]
  )]
)