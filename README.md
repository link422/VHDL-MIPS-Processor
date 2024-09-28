# Project Organization
single_cycle_top = Single Cycle simulation \
pipeline_top = Simple Pipelined simulation \
single_cycle_board = Single Cycle board \
pipeline_board = Simple Pipelined board \
\
All projects have the same interface on the DE10-Lite board. 
   
# To Run ModelSim simulation:   
1.	Open fetch.qpf in Quartus 
2.	In menu bar click: Processing -> Start Compilation 
3.	After compilation, in menu bar click: Tools -> Run Simulation Tool -> Gate Level Simulation 
4.	ModelSim will open, run the simulation, and display the waveform. 
  
# To deploy to DE10-Lite board:   
1.	Open fetch.qpf in Quartus 
2.	In menu bar: Processing -> Start Compilation 
3.	In menu bar: Tools -> Programmer 
4.	Click "Hardware Setup" 
5.	Select "USB Blaster" 
6.	Click "Close" 
7.	Click "Start" to begin programming 

# Explanation of board controls/features:   
### KEY0: 
    Clock control: Press this button to cause a clock pulse. 
### KEY1: 
    Program counter reset. 
### HEX(5..0):  
    Shows reg_wr_data in hex (lower 24 bits) 

# Explanation of project files: 
pipeline_board.vhd -- pipeline MIPS processor for board \
phase3SevSeg_tb.vhd -- simple testbench for phase3SevSeg \
phase3SevSeg.vhd -- converts 4 bits to 8 bit hex representation for the 7 segments \
TFFForD.vhd -- simple T-Flip flop that is used for board delay \
shiftLeft.vhd -- it shifts the input left by 2 by appending 2 0s at the right side and ignoring top 2 bits \
shift_tb.vhd --simple testbench for shiftLeft \
sevSeg_tb.vhd -- This is a simple testbench to make sure that sevSeg.vhd operates \
sevSeg.vhd -- This converts unsigned binary into to 7 segment displays. used in dec_ex_board.vhd \
decode.vhd -- decoder that is used to select which register is bing written to \
andBlock.vhd -- simple 2 input and used for register write \
ALU.vhd -- this is the code for the ALU used in the top level file \
fetch.sdc -- this is the file where we changed the period \
add_block.vhd -- simple adder for the PC \
add_tb.vhd -- simple testbench for add_block \
progCount -- register for PC \
fiveInstructions.mif -- MIF file used to preload instructions into instruction memory \
fetch_top.vhd -- phase 1's top level file \
fetch_tb -- phase 1's testbench \
instructionMem.qip -- IP used for instruction memory \
signExtend.vhd -- sign extender used in phase 2s top level \
sE_tb.vhd -- testbench to make sure sign extender works \
ALUMux.vhd -- multiplexer used to select what goes to second input of ALU \
ALU_tb.vhd -- testbench to make sure that ALU functions properly \
reg_32.vhd -- 32 bit register used on RW_Unit \
RW_Unit.vhd -- Read and write unit for the registers used in phase 2's top level \
Mux_32x1.vhd -- 32 to 1 mux. 2 of these are used in phase 2's top level \
multiplex_pack.vhd -- package used to add regArray to files that need it \
dec_ex_top.vhd -- phase 2's TOP LEVEL FILE \
dec_ex_tb.vhd -- phase 2's TESTBENCH \
dec_ex_board.vhd -- phase 2's BOARD TEST \
single_cycle_top.vhd -- single cycle simulation implementation \
Mux_5bit_2x1.vhd -- 2-1 multiplexer with 5 bit inputs and output \
controlUnit.vhd -- control unit for the processor that brings in opcode and gives out controls \
Mux_32bit_2x1.vhd -- 2-1 multiplexer with 32 bit inputs and output \
single_cycle_tb.vhd -- testbench for single_cycle_top \
IFID.vhd -- this is the IF/ID register that holds all values related to IF/ID \
IDEX.vhd -- this is the ID/EX register that holds all values related to ID/EX \
EXMEM.vhd -- this is the EX/MEM register that holds all values related to EX/MEM \
MEMWB.vhd -- this is the MEM/WB register that holds all values related to MEM/WB \
pipeline_top.vhd -- pipelined processor simulation \
pipeline_tb.vhd -- testbench for pipelined processor simulation \
delayUnit.vhd -- This uses a chain of T-Flip flops to delay a clock input for data mem in single cycle board \
delayUnit_tb.vhd -- testbench for delayUnit \
simDelay.vhd -- This uses transpose to add delay to a clock inpit for data mem in single cycle simulation \
simDelay_tb.vhd -- testbench for simDelay \
controlUnit_tb.vhd -- testbench for controlUnit \
single_cycle_board.vhd -- single cycle board implementation \
dataMem.qip -- same as instrucMem accept for no MIF file prelaoded

# Demo Instructions   
1.	Deploy the pipeline_board.vhd (already set as top level) from the project to the DE10-Lite board 
   using the instructions in the projectREADME.txt file found in the project archive. 
2.	After flashing, with all switches in the DOWN (OFF) position,    press KEY1 to reset the program counter. 
3.	Repeatedly press KEY0 clock as many times as desired. Observe the reg_wr_data    values shown in hex on the 7-segment displays. Expected values are shown below.  
Note: See projectREADME.txt  for further explanation of board controls and features. 
  
# Expected Values  
  
Clock Cycle    reg_wr_data (hex)    notes 
----------------------------------------------------
0       0x000000             <- board startup 
1	0x000000
2	0x000000 
3	0x000000 
4	0x000000 
5	0x000001 
6	0x000002 
7	0x000003 
8	0x000004
9	0x000005 
10	0x000002
11	0x000005
12	0x000000             <- reg_write = 0, mem_to_reg = X 
13	0x000007
14	0x000040
15..	0x000000

