library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALUControl_tb is
end ALUControl_tb;

architecture behave of ALUControl_tb is
signal op : std_logic_vector(1 downto 0);
signal funct : std_logic_vector(5 downto 0);
signal cont : std_logic_vector(3 downto 0);

component ALUControl is
	port(ALUOp : in std_logic_vector(1 downto 0);
			functCode : in std_logic_vector(5 downto 0);
			ALUCont : out std_logic_vector(3 downto 0));
end component;

begin
dut: ALUControl port map (op,funct,cont);
process
begin
	op <= "00";
	funct <= "000000";
	wait for 10 ns;
	op <= "01";
	funct <= "000000";
	wait for 10 ns;
	op <= "10";
	funct <= "100000";
	wait for 10 ns;
	op <= "10";
	funct <= "100010";
	wait for 10 ns;
	op <= "10";
	funct <= "100100";
	wait for 10 ns;
	op <= "10";
	funct <= "100101";
	wait for 10 ns;
	op <= "10";
	funct <= "101010";
	wait for 10 ns;
	op <= "10";
	funct <= "100111";
	wait for 10 ns;
wait;
end process;
end behave;