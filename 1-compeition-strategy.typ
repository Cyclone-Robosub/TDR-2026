== Lessons from our Rookie Year (RoboSub 2025)
Cyclone RoboSub competed for the first time in RoboSub 2025, where we encountered a variety of challenges and successes that have shaped our testing strategy and methodologies for 2026. 

The pervasive theme across the previous year's technical challenges was untested systems. Our team only received a DVL (graciously loaned by Nortek) one month before the competition, delaying the development of the major control systems were never seriously tested until we arrived in Irvine.

At the competition, we faced challenges during competition runs due to corroded electronics. This combination of unknowns made troubleshooting extremely challenging, especially under the pressure of competition. One thing was abundantly clear: we needed to make real-condition testing the driver of our development process. As a new team, the fastest way we could close the experience gap would be testing and failing as fast as possible during the year to ensure reliability come next July. 

This year, we've implemented better testing procedures both in software and in our development cycle. We now conduct weekly pool tests, which create a recurring artificial deadline that drives progress and ensures that our systems experience real conditions year-round, as opposed to the month leading up to competition. Our software now includes a hardware in the loop setup through MATLAB and multiple failsafes within our software architecture. This renewed emphasis on real condition testing and rapidly increased our development speed and exposed system characteristics that otherwise go unnoticed.


//Our first conversations regarding competition strategy began with the team’s founding in 2023. As a new team, we understood the importance of setting achievable goals, so we set out to cultivate a solid understanding of the competition challenges to inform our team’s expected abilities.

//Our first team meeting involved breaking down the 2023 Team Handbook @handbook and assessing strategy. We cataloged the maximum available points associated with each task, along with the number of teams able to successfully attempt each task as seen in @taskbreakdown. We measured success rate as a team's ability to achieve the maximum points possible within a given task. Furthermore, we gave extra weight to tasks that succinctly demonstrated intended vehicle functionality. Doing so allowed us to identify trends and pinpoint tasks that yielded the most points while falling within most teams’ predicted abilities. 

//During our analysis, we noted that the majority of teams’ points were earned by completing navigation-based tasks such as surfacing in the _Octagon_ and passing through the _Gate_. When compared with precise manipulation tasks, we found that successful attempts were less common. Based on this research, we prioritized navigation-based tasks while de-prioritizing manipulation-based.

//Originally, Cyclone RoboSub planned on competing in the 2024 RoboSub Competition. However, after lengthy deliberation, we chose to postpone competing until 2025 with the intent to use the extra time to build a solid foundation for our vehicle and team. Despite this, we sent representatives to the 2024 RoboSub competition to ask questions and witness different strategies firsthand. During their time at the venue, our representatives spoke with other teams and took detailed notes on the pitfalls and effective strategies teams encountered. Most teams advised against relying on vision systems as a primary means of navigation and instead recommended the use of a Doppler Velocity Log (DVL). Testing early and often was a common theme along with the use of fail-safes spread across all systems.

//This new intel, combined with our previous year’s assessment, culminated in our current competition strategy for the 2025 RoboSub Competition.

== 2025 Competition Strategy


For the 2025 RoboSub Competition, we chose to prioritize navigation-based that could be completed regardless of whether or not our vision system was implemented before the summer. This was based on an analysis we conducted that quantitatively evaluated the types of tasks teams had been successful with at past competitions {appendix reference}. From our analysis, it was clear that very few teams were successful at complex manipulation tasks, leading us to avoid them as a relatively new team building out our capabilities.
- *Begin Assessment (Gate):* Manny begins each run with a coinflip, turning to face the gate using feedback from our DVL's magnetometer. The vehicle proceeds to submerge and pass under the gate completing two 360$degree$ roll rotations.
- *(Slalom):* Manny next attempts the Slalom navigating between pre-defined waypoints. 
// Maybe say something about choosing which type of celanup or rescue route we are going on and how that defines our path
- *(Bin):* Next, Manny navigates to the _Bin_ task using a preset waypoint. Once the vehicle is positioned above the bins with the images in sight, a downwards facing camera provides localization information allowing Manny to precisely line up above the bins. When we are within our target position range, both droppers will be released. 
- *(Octagon):* Manny will navigate to the _Octagon_ using predefined waypoint, surface, and descend again to begin the journey home.
- *(Return Home):* Lastly, Manny will navigate back to the gate using waypoints and pass through, surfacing, and completing the run.
//So, moving forward, we would design an AUV that is nimble and consistent, focusing on navigational tasks. Our research regarding competition strategy formed the core of our design strategy -- it continually informed the decisions we made and philosophies we stood by. Based on the goals we determined achievable, we designed our robot to emphasize successfully completing those tasks. 

// To complement extensive competition research, the most significant competition preparation is the fast-paced hardware testing schedule our team applied bi-weekly. Despite our consistent testing, the principal challenge that we expect to face at the competition is adapting our controller’s navigation strategy to the competition layout. The need for in situational modification and serviceability drove the majority of our design decisions detailed in the following section.