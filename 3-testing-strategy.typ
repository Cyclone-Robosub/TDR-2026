== Component Level Testing
Each component of our electrical system was tested before being implemented. After each new addition, we performed a full test of all systems to determine if any new issues had been introduced. This included methodically and redundantly checking all electrical connections and data feeds under stressful conditions. 

== System Level Testing
Our team employs a test-early and often strategy by performing bi-weekly pool-tests with minimal delays. Consistent weekly goals guided the team to prioritize the next viable product of the work, checking regularly that individual members’ and subteams’ work was compatible with the larger design. Routine pool testing often identified issues at the interface between subsystems that were difficult to identify in subsystem level testing.  In addition to testing the robot, preparation for the system tests also revealed the need to design well-documented standard operating procedures (SOPs). These SOPs cover a range of critical topics including software configuration, battery and electrical safety and continuity, hull leak testing, and data logging.
== Standard Operating Procedure
Our SOPs started small with a few important steps to take before in-pool testing, as we gained experience, we expanded this list into a decision-based case tree, allowing us to quickly respond when something goes wrong as seen in @pooltestprocedure. 

One example of where this problem-solving structure was used was troubleshooting inconsistent thruster behavior ultimately tracing it back to a hidden solder bridge and misconfigured software. This structured, methodical approach saved time and minimized guesswork.

Beyond the procedure documents themselves, the real strength of our testing lies in the way our team executes it: with clear communication, calm problem-solving, and shared knowledge. These habits – built through repetition and reflection – are what allow Manatee to operate safely and effectively in uncertain conditions. 

#figure(
  image("images/blue-pool-robot.JPG"),
  caption: [AUV "Manatee" Before a Pool Test]
)