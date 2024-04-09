# vending_machine
A vending machine sells 3 kinds of drinks.

I use MacBook(Apple Silicon) to do this work, with WaveTrace in Visual Studio Code extension. If you want to run the code, simply use:
`iverilog act_vending.v t_act_vending.v`
then generate an `a.out` file.
then use:
`vvp a.out`
use WaveTrace to see the output wave

This Verilog code simulates a vending machine. The machine accepts inputs of 10, 50, and 100, and allows the user to select one of three items. The items cost 12, 13, and 14 respectively. If the user has input enough money for the selected item, the machine dispenses the item and returns the change.

The code first defines some input and output signals, and some internal registers. The input signals include a clock signal `clk`, a reset signal `rst`, and signals representing the input money and item selection. The output signals include signals indicating whether an item can be purchased, and a change signal.

The code defines three states s0, s1, and s2, and uses the state and next_state registers to track the current and next states. The amount register tracks the total input money.


act_vending.v use
