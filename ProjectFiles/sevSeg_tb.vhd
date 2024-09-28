library ieee;
use ieee.std_logic_1164.all;

entity sevSeg_tb is
end sevSeg_tb;

architecture behave of sevSeg_tb is
signal in1,out1,out2 : std_logic_vector(7 downto 0);

component sevSeg is
	port(x : in std_logic_vector(7 downto 0);
			o1,o2 : out std_logic_vector(7 downto 0));
end component;

begin

dut: sevSeg port map(in1,out1,out2);

process
begin
in1 <= "00000000";
wait for 5 ns; 
in1 <= "00000001";
wait for 5 ns;
in1 <= "00000010";
wait for 5 ns;
in1 <= "00000011";
wait for 5 ns;
in1 <= "00000100";
wait for 5 ns;
in1 <= "00000101";
wait for 5 ns;
in1 <= "00000110";
wait for 5 ns;
in1 <= "00000111";
wait for 5 ns;
in1 <= "00001000";
wait for 5 ns;
in1 <= "00001001";
wait for 5 ns;
in1 <= "00001010";
wait for 5 ns;
in1 <= "00001011";
wait for 5 ns;
in1 <= "00001100";
wait for 5 ns;
in1 <= "00001101";
wait for 5 ns;
in1 <= "00001110";
wait for 5 ns;
in1 <= "00001111";
wait for 5 ns;
in1 <= "00011111";
wait for 5 ns;
in1 <= "00101111";
wait for 5 ns;
in1 <= "00111111";
wait for 5 ns;
in1 <= "01001111";
wait for 5 ns;
in1 <= "01011111";
wait for 5 ns;
in1 <= "01101111";
wait for 5 ns;
in1 <= "01111111";
wait for 5 ns;
in1 <= "10001111";
wait for 5 ns;
in1 <= "10011111";
wait for 5 ns;
in1 <= "10101111";
wait for 5 ns;
in1 <= "10111111";
wait for 5 ns;
in1 <= "11001111";
wait for 5 ns;
in1 <= "11011111";
wait for 5 ns;
in1 <= "11101111";
wait for 5 ns;
in1 <= "11111111";
wait;
end process;
end behave;