Despite using the same vehicle from the 2025 competition, we have included a slew of improvements across the board intended to refine its design. The following is a list of changes we made that were not mentioned in the main body of the report. 

=== Robot Handling
The need to improve the structural integrity of Manatee was made apparent during pool testing, where one of the thrusters cracked due to a collision. Adding thruster guards for the angled horizontal thrusters was done to prevent further damage to both the frame and the thrusters. To improve ease of handling for Manatee, we also added handles that made transportation safe and easier for team members.

=== IMU Fixturing
However, through testing and research, we encountered a critical limitation: the IMU required a USB-C connection, and routing that cable through a waterproof penetrator would either require splicing or re-crimping the connector — both of which posed a risk to signal quality and long-term performance. Given the importance of the IMU to our control system and position estimation, we made the decision to relocate it into the main tube, where it could connect directly to the processor without modification or potential signal degradation.

=== Tube Mounting
One of our most meaningful lessons came from an early fault mounting system for our main waterproof tube. The original design relied on a two-part clamp that required careful alignment and over-tightening of bolts. This led to cracking the 3D-printed clamp, proving unreliable. Eventually, this concern became an issue when the clamp snapped in half one day at our workbench.

To correct this, we embedded a threaded aluminum insert into the 3D-printed mount and allowing the bolt to lock cleanly with a sliding mechanism, we created a far more secure and user-friendly solution. Now, the print significantly easier to handle with no loose parts alongside additional rigidity as one component complementing a physical preventative to overtightening the bolt. It was a small change that represented a larger shift toward engineering that is thoughtful, resilient, and practical.

=== Thruster Guards <thruster-guard-updates>
[Placeholder: Image of old fully 3DP guard design]

Initially, the team tried to address this issue with fully 3D-printed thruster guards. Concentric rings were spaced such that fingers and large debris could not reach the propeller, and the entire assembly would cleanly clip onto the thruster without any secondary components. Unfortunately, this design was only good for addressing one problem: the safety of people handling the robot. It’s efficacy was subpar for outdoor deployments, where fine detritus was still able to get past the large gaps between rings and wreak havoc on the propellers.

Addressing this secondary design criteria required a pivot in thinking. While plastic 3D printing has its benefits in automating manufacturing and allowing for repeatable & complex geometries, it’s relatively coarse resolution made it infeasible to block fine detritus while minimizing thrust loss. An alternative material and manufacturing method was required.