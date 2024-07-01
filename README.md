
DIGITAL CLOCK ON BASYS3

1. **Introduction**

This report details the design and implementation of a digital clock using Verilog hardware description language (HDL). The primary objective of this project is to create a functional digital clock capable of displaying hours and minutes on a seven-segment display. The clock includes features such as timekeeping, time setting, and a user-friendly interface for editing the time.

2. **Working Principle**

The digital clock designed in this project operates based on several key principles and functionalities:

1. **Clock Division**: The primary clock signal is divided to create a slower clock signal (sclk), ensuring the timer increments at a human-readable rate (one second).
1. **Finite State Machine (FSM)**: The digital clock uses an FSM to manage its different operational modes, including normal operation and editing mode.
1. **Time Counting**: The clock maintains registers for seconds, minutes, and hours, which are updated based on the slower clock signal.
1. **User Interface**: Control inputs allow the user to interact with the clock, including resetting the time, entering editing mode, shifting the focus between hours and minutes, and incrementing or decrementing the time.
1. **Display**: The current time is displayed on a seven-segment display, which converts the binary time values into a human-readable format.
3. **States of operation**

The FSM manages the digital clock through the following states:

**Normal Operation State**


The clock operates normally, counting seconds, minutes, and hours.

Operations:

- The clock increments the seconds register every second (based on the slower clock signal).
- If the seconds register reaches 60, it resets to 0 and increments the minutes register.
- If the minutes register reaches 60, it resets to 0 and increments the hours register.
- If the hours register reaches 24, it resets to 0.
- The edit signal is monitored to transition to the editing state if activated.

Outputs: The current time is displayed on the seven-segment display.

**Editing State**

The clock enters editing mode, allowing the user to adjust the time settings.

Operations:

- The edit\_shift signal toggles the focus between hours and minutes.
- The inc signal increments the selected time setting (hours or minutes).
- The dec signal decrements the selected time setting (hours or minutes).
- The edit signal is monitored to transition back to the normal operation state if deactivated.

Outputs: The current time is displayed on the seven-segment display, reflecting any changes made during editing.

**Clock Division**

The primary clock signal is divided to create a slower clock signal (sclk) for time counting.

Operations:

- The primary clock signal is divided by 50 million to generate a 1 Hz signal.
- The slower clock signal (sclk) is used to increment the seconds register in the normal operation state.

Outputs: The slower clock signal (sclk) used for time counting.

**Seven-Segment Display**

The seven-segment display module converts binary time values into a human-readable format.

Operations:

- The current time values (seconds, minutes, and hours) are converted into their respective digit representations (ones, tens, hundreds, thousands).
- The digit representations are displayed on the seven-segment display.
- The display is multiplexed to show each digit in turn, refreshing rapidly to create the illusion of a constant display.

Outputs: The current time is displayed on the seven-segment display.

4. **Summary**

The digital clock operates through a well-defined FSM with two primary states: normal operation and editing mode. Each state has specific input triggers and operations, ensuring smooth transitions and accurate timekeeping. The integration of a clock divider and user interface controls allows for a functional and user-friendly digital clock design. The seven-segment display provides a clear and readable output of the current time, making the digital clock easy to use and understand.

5. **Output**

<https://drive.google.com/file/d/1h6-hPhocXWuX8lR8reOwbr9lDnSvyogZ/view?usp=sharing>


