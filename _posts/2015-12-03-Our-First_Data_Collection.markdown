---
layout: post
title:  "Our First Data Collection"
date:   2015-12-03 14:03:00
categories: website
author: Derek Gutheil
---

[![alt text][bike photo]][article link]

<br/>

A few weeks ago on Sunday, November 15, 2015 we achieved a major milestone for our team. We set up in the northernmost parking lots at RIT for a test day and for the first time ever, collected data from REV1 as it ran in race-like conditions. Our rider came out, gave us feedback on the changes, and rode the bike for nearly 45 minutes so we could record battery voltages as the pack discharged. We have been making many changes, improvements, and optimizations to our bike since our first race at New Jersey Motorsports Park in July of this year, one of the biggest being the addition of the BMS (Battery Management System). Our BMS has been in the works for the better part of three years, and this test day was the first opportunity we had to run it on our race bike.

<br/>
[![alt text][data photo]][data photo full]

<br/>
The graph above shows the voltages of 11 of the battery cells in REV1's pack as they were discharged over the course of about 45 minutes. Two things stand out immediately. The first is that our cells are doing a fantastic job of staying in balance naturally. The average difference of the cell voltages at any given point in the run was about 40 mV, something the BMS should be able to correct for during downtime and charging. The second is the large downward spikes and oscillations that show up at four different points in the graphs. The data shown is actually recorded from four separate runs, separated by the four plateaus shown in the graph (For separate data from all four runs, click [here][data link]). For this first test, we were mostly interested in how the batteries behaved over a full discharge cycle, not how they behaved in various load conditions, so we set the BMS sample rate to 1 Hz to keep our data set manageable. Those oscillation areas are actually the periods that REV1 was being tested under load. The lowest parts of the spikes are where maximum throttle was applied, pulling the most current out of the batteries and lowering their voltage. When there is less throttle applied such as during braking or coasting, the voltage of each cell returns to its previous state. Since the sample rate is far too low to smoothly catch throttle application, it appears as random quick spikes.

<br/>

<iframe src="https://drive.google.com/a/g.rit.edu/file/d/0B23T_8DXwAUXTU5ES3VKaE5uTjA/preview" width="560" height="315" allowfullscreen></iframe>

Even in the short four second video above, you can see where our rider is off the throttle during braking, maintaining speed in the corner, and applying throttle to exit the corner. Next time we run REV1 we plan on increasing our data collection frequency to around 100 Hz which will help up see how the throttle and motor current interact with the battery voltages.

<br/>
While the information that can be gleaned from 11 cell voltages is useful, it wasn't our only reason for running REV1. The primary purpose of November's test was to validate all of the foundational work that made collecting 11 cell voltages possible. Our BMS is designed to balance all of the cells on our race vehicles and monitor the battery pack's state of charge and a cell's voltage, pressure, and temperature. This data is then transmitted over a CAN network to our Gateway which records this data locally and sends it to our servers for processing. This is the first complete end to end test that we have performed on both our BMS and the entire low voltage network on REV1, and it performed flawlessly. With this full system level test complete, we are now confident that we can move forward in adding our whole set of features. These few cells are just the first in the flood of data that our system will allow us to collect. By our next race in February 2016 we are planning to add bike acceleration, speed and lean angles, motor RPM, current, and temperature and full pack voltage, current, state of charge, temperature, and pressure. We can't wait.

<br/>
-Derek Gutheil

Lead Firmware Engineer

<br/>
[![alt text][end photo]][end photo full]

[bike photo]: /img/blog-posts/Our_First_Data_Collection/test_day.jpg "Matthew Behlke, the gateway project lead, pulling data off of REV 1 after one of its first runs"
[data photo]: /img/blog-posts/Our_First_Data_Collection/data.png "Plot of all of the cell voltages versus time since the gateway was turned on"
[data photo full]: /img/blog-posts/Our_First_Data_Collection/data_full.png

[data link]: /documents/blog-posts/Our_First_Data_Collection/all_data_2015-11-15.xlsx

[end photo]: /img/blog-posts/Our_First_Data_Collection/recording_wrap_up.jpg "End of the day"
[end photo full]: /img/blog-posts/Our_First_Data_Collection/recording_wrap_up_full.jpg
[article link]: {% post_url 2015-12-03-Our-First_Data_Collection %}