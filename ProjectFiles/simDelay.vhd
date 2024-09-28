library ieee;
use ieee.std_logic_1164.all;


entity simDelay is
port( CLK : in std_logic;
		DCLK : out std_logic);
end simDelay;

architecture behave of simDelay is
signal tempCLK : std_logic;

begin
process(CLK)
begin
tempCLK <= transport CLK after 25 ns;
end process;
DCLK <= tempCLK;



end behave;