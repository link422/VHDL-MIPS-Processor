library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity controlUnit_tb is
end controlUnit_tb;

architecture behave of controlUnit_tb is
signal opcode_tb : std_logic_vector(5 downto 0);
signal regDst_tb : std_logic;
signal branch_tb : std_logic;
signal regWrite_tb : std_logic;
signal ALUSource_tb : std_logic;
signal memToReg_tb : std_logic;
signal memRW_tb : std_logic;
signal ALUOp_tb : std_logic_vector(1 downto 0);

component controlUnit is
port( opcode : in std_logic_vector(5 downto 0);
		regDst : out std_logic;
		branch : out std_logic;
		regWrite : out std_logic;
		ALUSource : out std_logic;
		memToReg : out std_logic;
		memRW : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0));
end component;

begin
dut: controlUnit port map (opcode_tb,regDst_tb,branch_tb, regWrite_tb, ALUSource_tb, memToReg_tb, memRW_tb, ALUOp_tb);
process
begin
	opcode_tb <= "000000";
	wait for 10 ns;
	opcode_tb <= "000100";
	wait for 10 ns;
	opcode_tb <= "001000";
	wait for 10 ns;
	opcode_tb <= "100011";
	wait for 10 ns;
	opcode_tb <= "101011";
	wait for 10 ns;
	opcode_tb <= "000000";
	wait for 10 ns;
	opcode_tb <= "000100";
	wait for 10 ns;
	opcode_tb <= "100011";
	wait for 10 ns;
	opcode_tb <= "101011";
	wait for 10 ns;
wait;
end process;
end behave;