library ieee;
use ieee.std_logic_1164.all;


entity delayUnit is
port( CLK : in std_logic;
		DCLK : out std_logic);
end delayUnit;

architecture behave of delayUnit is
signal alwsOne : std_logic := '1';
signal fallRst : std_logic;
signal TFFO : std_logic_vector(32 downto 0);


component TFFForD is
port( T, CLK : in std_logic;
		Rst : in std_logic;
		Q : out std_logic);
end component;

begin


--make each flip flop clock for other and have last flipflop output be DCLK
TFFs1: for i in 0 to 31 generate
	T1: TFFForD port map(alwsOne, TFFO(i), fallRst, TFFO(i+1));
end generate TFFs1;
TFFO(0) <= CLK;
DCLK <= TFFO(32);
fallRst <= (TFFO(32) AND (not CLK));


end behave;