library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shift_tb is
end shift_tb;

architecture behavior of shift_tb is
signal a : std_logic_vector (31 downto 0);
signal o : std_logic_vector (31 downto 0);

component shiftLeft is
port(signExtend : in std_logic_vector (31 downto 0);
		shiftOut : out std_logic_vector (31 downto 0));
end component;

begin
dut: shiftLeft port map (a,o);
process
begin
a <= "00000000111111110000111100001111";	
wait for 100 ns;
a <= "11111111000000001111111100000000";
wait for 100 ns;
end process;

end behavior;