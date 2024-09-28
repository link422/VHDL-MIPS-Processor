library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity add_tb is
end add_tb;

architecture behavior of add_tb is
signal a : std_logic_vector (31 downto 0);
signal o : std_logic_vector (31 downto 0);

component add_block is
port(in1 : in std_logic_vector (31 downto 0);
		out1 : out std_logic_vector (31 downto 0));
end component;

begin
dut: add_block port map (a,o);
process
begin
a <= "10001000100010001000100010001000";	
wait for 10 ns;
a <= "10001000100010001000100010000100";
wait for 10 ns;
end process;

end behavior;