== Lessons from our Rookie Year (RoboSub 2025)
Cyclone RoboSub competed for the first time in RoboSub 2025, where we encountered a variety of challenges and successes that have shaped our testing strategy and methodologies for 2026. 

The pervasive theme across the previous year's technical challenges was untested systems. Our team only received a DVL (graciously loaned by Nortek) one month before the competition, delaying the development of the major control systems were never seriously tested until we arrived in Irvine.

At the competition, we faced challenges during competition runs due to corroded electronics. This combination of unknowns made troubleshooting extremely challenging, especially under the pressure of competition. One thing was abundantly clear: we needed to make real-condition testing the driver of our development process. As a new team, the fastest way we could close the experience gap would be testing and failing as fast as possible during the year to ensure reliability come next July. 

This year, we've implemented better testing procedures both in software and in our development cycle. We now conduct weekly pool tests, which create a recurring artificial deadline that drives progress and ensures that our systems experience real conditions year-round, as opposed to the month leading up to competition. Our software now includes a hardware in the loop setup through MATLAB and multiple fail-safes within our software architecture. This renewed emphasis on real condition testing and rapidly increased our development speed and exposed system characteristics that otherwise go unnoticed.


== Component Level Testing
Each component of our electrical system was tested before being implemented. After each new addition, we performed a full test of all systems to determine if any new issues had been introduced. This included methodically and redundantly checking all electrical connections and data feeds under stressful conditions. 

Software undergoes a multi-stage testing pipeline to ensure stability. Code that in the `main` branch has been pool-tested and verified, and code in the `staging` branch has been dry-tested and passes all unit tests. Development for a feature starts in a work branch, generally branched from the `staging` branch. Unit tests are developed alongside the feature, to specifications outlined in the relevant GitHub issue. Once the feature is complete and passes all of its unit tests, a pull request is created into the `staging` branch. GitHub actions will automatically run the entire project's unit tests: if any fail, the pull request will be denied. Before the pull request into `staging` will be merged, the feature undergoes a code review from a leadership member and a dry test on the robot hardware. If these are successful, the pull request is merged and the feature is tested in the water at the next weekly pool test. If this also succeeds with no issues, then the `staging` branch is merged into `main`. This pipeline ensures that any code that is on the `main` branch has been rigorously tested and will be stable and accurate.

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