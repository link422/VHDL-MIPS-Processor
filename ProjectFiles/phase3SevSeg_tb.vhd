library ieee;
use ieee.std_logic_1164.all;

entity phase3SevSeg_tb is
end phase3SevSeg_tb;

architecture behave of phase3SevSeg_tb is
signal x : std_logic_vector(3 downto 0);
signal o : std_logic_vector(7 downto 0);

component phase3SevSeg is 
	port(in1 : in std_logic_vector(3 downto 0);
			hex1 : out std_logic_vector(7 downto 0));
end component;

begin

dut: phase3SevSeg port map (x,o);

process
begin
x <= "0000";
wait for 5 ns; 
x <= "0001";
wait for 5 ns;
x <= "0010";
wait for 5 ns;
x <= "0011";
wait for 5 ns;
x <= "0100";
wait for 5 ns;
x <= "0101";
wait for 5 ns;
x <= "0110";
wait for 5 ns;
x <= "0111";
wait for 5 ns;
x <= "1000";
wait for 5 ns;
x <= "1001";
wait for 5 ns;
x <= "1010";
wait for 5 ns;
x <= "1011";
wait for 5 ns;
x <= "1100";
wait for 5 ns;
x <= "1101";
wait for 5 ns;
x <= "1110";
wait for 5 ns;
x <= "1111";
wait for 5 ns;
wait;
end process;
end behave;