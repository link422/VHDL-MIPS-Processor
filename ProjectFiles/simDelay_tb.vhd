library ieee;
use ieee.std_logic_1164.all;


entity simDelay_tb is
end simDelay_tb;

architecture behave of simDelay_tb is
signal clock : std_logic := '0';
signal delayCLK : std_logic;

component simDelay is
port( CLK : in std_logic;
		DCLK : out std_logic);
end component;

begin
DUT1: simDelay port map (clock, delayCLK);
process
begin
wait for 50 ns;
clock <= not clock;
end process;
end behave;