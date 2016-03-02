---
layout: project
title:  "Low Voltage Cutoff Circuit"
categories: website
author: Daniel Mitchell
---

## Low Voltage Cutoff

The LVCC (low voltage cutoff circuit) is a project that began to fill the need of an added safety measure to the electric bicycles. Batteries can become unstable and dangerous at low voltages, so a way to measure and respond to that is highly recommended. The motor controller that came with the e-bike kits has a built in low voltage cutoff, but that is a measure across three different four-celled batteries connected in series. If one cell goes bad in one battery, it may not be visible when looking at all 12 cells at once. 

Similar to the BMS (battery management system) that other team members are working on, the LVCC will look at the individual cells of each battery. However, rather than cut off excess voltage of other cells like the BMS does, the LVCC will simply cut all power from the batteries to the motor controller – thus shutting the bicycle off. 

**Project Criteria:**

>1. Measure the voltage across each cell of each battery
>2. When the voltage of any cell drops into the danger zone (3.3 Volts), cut all power
>3. Implement a delay so that the LVCC cuts power only in the steady state condition

A steady state cutoff is important due to the nature of the battery’s voltage over the course of normal operation. Over time, the voltage will rise and fall based on many factors such as the amount of throttle the rider is using and the incline that the bicycle is on. If the battery cell voltage is somewhat close to the cutoff but not quite there yet and the user is pulling the maximum current from the batteries, the voltage may drop below the threshold and open the circuit path which will effectively shut the bicycle off. At that point, no current will be drawn and the battery cell voltage in question will rise above the threshold which would close the circuit and resume operation only to cut again since the rider is asking for the maximum current. 

To counteract this, an RC circuit is implemented which only becomes active when a battery cell drops below the threshold. The capacitor in the circuit is charged and the voltage across the capacitor is measured. After a set amount of time, which is based on the values of the resistor and capacitor, the voltage across the capacitor will rise high enough to trigger another threshold which will then open the circuit to end operation. 

A user will be able to adjust a potentiometer to change amount of time necessary for the battery voltage to remain below the threshold before cutoff will happen and prevent an instantaneous restart after the cutoff. This feature will allow the user to account for events like very large hills. There are also three LEDs in the circuit – each representing a different battery. An LED will only be illuminated when a cell falls into the danger zone so that the user can identify battery health. 

The overall goal for this project is to design and fabricate printed circuit boards for the electric bicycle teams to implement on their bicycles as soon as possible and protect both user and battery health.
