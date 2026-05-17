== Previous Competition Analysis
Our first conversations regarding competition strategy began with the team’s founding in 2023. As a new team, we understood the importance of setting achievable goals, so we set out to cultivate a solid understanding of the competition challenges to inform our team’s expected abilities.

We began by breaking down the 2023 Team Handbook @handbook to assess strategy. We cataloged the maximum available points associated with each task, along with the number of teams able to successfully attempt each task as seen in @taskbreakdown. Furthermore, we gave extra weight to tasks that succinctly demonstrated intended vehicle functionality. This allowed us to identify trends and pinpoint tasks that yielded the most points while falling within most teams’ predicted abilities. 


asd seen fdsfdfs @requirement:testable

During our analysis, we noted that the majority of teams’ points were earned by completing navigation-based tasks such as surfacing in the _Octagon_ and passing through the _Gate_. When compared with precise manipulation tasks, we found that successful attempts were less common. Based on this research, we prioritized navigation-based tasks while de-prioritizing tasks highly reliant on manipulation and vision systems.

Originally, Cyclone RoboSub planned on competing in the 2024 RoboSub Competition. However, after lengthy deliberation, we chose to postpone competing until 2025 with the intent to use the extra time to build a solid foundation for our vehicle and team. Despite this, we sent representatives to the 2024 RoboSub competition to ask questions and witness different strategies firsthand. During their time at the venue, our representatives spoke with other teams and took detailed notes on the pitfalls and effective strategies teams encountered. 

// Most teams advised against relying on vision systems as a primary means of navigation and instead recommended the use of a Doppler Velocity Log (DVL). Testing early and often was a common theme along with the use of fail-safes spread across all systems.

//This new intel, combined with our previous year’s assessment, culminated in our current competition strategy for the 2025 RoboSub Competition.

== 2026 Competition Strategy


Similar to 2025, this year we are prioritizing navigation-based tasks not dependent on vision based systems. This was based on an analysis we conducted that quantitatively evaluated the types of tasks teams had been successful with at past competitions {appendix reference}. From our analysis, it was clear that very few teams were successful at complex manipulation tasks, leading us to avoid them as a relatively new team building out our capabilities.

- *Begin Assessment (_Gate_):* Manatee begins each run with a coin-flip, turning to face the gate using feedback from our DVL's magnetometer. The vehicle proceeds to submerge and pass under the right side of the gate completing two 360#sym.degree roll rotations.
- *Avoid Debris (_Slalom_):* Manatee next attempts the Slalom navigating between pre-defined waypoints.
- *Recon (_Bins_):* Next, Manatee navigates to the _Bin_ task using a preset waypoint. Once the vehicle is positioned above the bins with the images in sight, a downwards facing camera provides localization information allowing Manatee to precisely line up above the bin of interest. When we are within our target position range, both droppers will be released. 
- *Resupply (_Octagon_):* Manatee will navigate to the _Octagon_ using predefined waypoint, surface, and descend again to begin the journey home.
- *Return Home:* Lastly, Manatee will navigate back to the _Gate_ using waypoints and pass through, surfacing, and completing the run.
//So, moving forward, we would design an AUV that is nimble and consistent, focusing on navigational tasks. Our research regarding competition strategy formed the core of our design strategy -- it continually informed the decisions we made and philosophies we stood by. Based on the goals we determined achievable, we designed our robot to emphasize successfully completing those tasks. 

// To complement extensive competition research, the most significant competition preparation is the fast-paced hardware testing schedule our team applied bi-weekly. Despite our consistent testing, the principal challenge that we expect to face at the competition is adapting our controller’s navigation strategy to the competition layout. The need for in situational modification and serviceability drove the majority of our design decisions detailed in the following section.