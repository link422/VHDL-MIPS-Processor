library ieee;
use ieee.std_logic_1164.all;


entity delayUnit_tb is
end delayUnit_tb;

architecture behave of delayUnit_tb is
signal clock : std_logic := '0';
signal delayCLK : std_logic;

component delayUnit is
port( CLK : in std_logic;
		DCLK : out std_logic);
end component;

begin
DUT1: delayUnit port map (clock, delayCLK);
process
begin
wait for 50 ns;
clock <= not clock;
end process;
end behave;