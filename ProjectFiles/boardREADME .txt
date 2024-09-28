****************** 
Demo Instructions: 
****************** 
  
1.	Deploy the pipeline_board.vhd (already set as top level) from the project to the DE10-Lite board 
   using the instructions in the projectREADME.txt file found in the project archive. 
2.	After flashing, with all switches in the DOWN (OFF) position,    press KEY1 to reset the program counter. 
3.	Repeatedly press KEY0 clock as many times as desired. Observe the reg_wr_data    values shown in hex on the 7-segment displays. Expected values are shown below.  
Note: See projectREADME.txt  for further explanation of board controls and features. 
  
**************** 
Expected Values  
**************** 
  
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

