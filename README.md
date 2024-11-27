
Here is a comprehensive README.md file for your GitHub repository. It covers all tasks, provides an overview, and includes instructions for running the programs.

ICS3203 CAT 2 - Assembly Language Tasks
Repository by Trevor Kamatu (Reg. No: 135447)
Overview
This repository contains the solutions for the ICS3203 CAT 2 assessment, implemented in x86-64 assembly language. The tasks demonstrate proficiency in assembly programming concepts such as control flow, looping, modular programming, and port-based simulations. Below are the detailed descriptions of the tasks and instructions for running the programs.

Tasks
Task 1: Control Flow and Conditional Logic
File: control_flow.asm

Functionality:

Prompts the user for an integer input.
Classifies the input as "POSITIVE," "NEGATIVE," or "ZERO."
Outputs the result using conditional branching.
Instructions to Run:

Assemble the program:
bash
Copy code
nasm -f elf64 control_flow.asm
Link the program:
bash
Copy code
ld -o control_flow control_flow.o
Execute the program:
bash
Copy code
./control_flow
Example Output:

text
Copy code
Enter a number: -5
NEGATIVE
Task 2: Array Manipulation with Looping and Reversal
File: array_reversal.asm

Functionality:

Automatically generates an array of integers.
Reverses the array in place using a loop.
Outputs the reversed array.
Instructions to Run:

Assemble the program:
bash
Copy code
nasm -f elf64 array_reversal.asm
Link the program:
bash
Copy code
ld -o array_reversal array_reversal.o
Execute the program:
bash
Copy code
./array_reversal
Example Output:

text
Copy code
Original Array: 1 2 3 4 5
Reversed Array: 5 4 3 2 1
Task 3: Modular Program with Subroutines for Factorial Calculation
File: factorial.asm

Functionality:

Prompts the user for a number.
Computes the factorial using a subroutine.
Uses the stack to preserve registers and modularize the code.
Outputs the factorial result.
Instructions to Run:

Assemble the program:
bash
Copy code
nasm -f elf64 factorial.asm
Link the program:
bash
Copy code
ld -o factorial factorial.o
Execute the program:
bash
Copy code
./factorial
Example Output:

text
Copy code
Enter a number: 5
Factorial: 120
Task 4: Data Monitoring and Control Using Port-Based Simulation
File: port_simulation.asm

Functionality:

Simulates reading a "sensor value" (e.g., water level) from memory.
Executes actions based on the input:
Turns on a motor if the water level is low.
Stops the motor if the water level is moderate.
Triggers an alarm if the water level is high.
Instructions to Run:

Assemble the program:
bash
Copy code
nasm -f elf64 port_simulation.asm
Link the program:
bash
Copy code
ld -o port_simulation port_simulation.o
Execute the program:
bash
Copy code
./port_simulation
Example Output:

text
Copy code
Sensor Value: 80
Action: ALARM triggered.
Challenges and Insights
Task 2: Handling direct memory manipulation required careful pointer adjustments to avoid segmentation faults. The use of loops ensured in-place array reversal without additional memory.
Task 3: Modularizing the factorial calculation demonstrated the importance of preserving register values using the stack. Proper stack management was critical to prevent corrupting data.
Task 4: Simulating port-based I/O in assembly provided insights into how real-world devices communicate with software. Using conditional branching allowed accurate control decisions based on sensor input.
Requirements
x86-64 architecture.
NASM assembler.
Linux environment (tested on Ubuntu via WSL).
Repository Structure
arduino
Copy code
ICS3203-CAT2-Assembly-Trevor-Kamatu-135447/
│
├── control_flow.asm        # Task 1: Conditional Logic
├── array_reversal.asm      # Task 2: Array Reversal
├── factorial.asm           # Task 3: Factorial Calculation
├── port_simulation.asm     # Task 4: Port-Based Simulation
├── README.md               # Documentation
How to Clone and Run
Clone the repository:
bash
Copy code
git clone https://github.com/MburuKamatu/ICS3203-CAT2-Assembly-Trevor-Kamatu-135447.git
Navigate to the directory:
bash
Copy code
cd ICS3203-CAT2-Assembly-Trevor-Kamatu-135447
Follow the instructions under each task to run the respective program.
Contributors
Trevor Kamatu - MburuKamatu
Let me know if there are any sections you'd like me to refine or add!






