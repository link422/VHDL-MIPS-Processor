library ieee;
use ieee.std_logic_1164.all;


entity TFFForD is
port( T, CLK : in std_logic;
		Rst : in std_logic;
		Q : out std_logic);
end TFFForD;

architecture behave of TFFForD is
signal temp : std_logic := '0'; 
begin
process(CLK, Rst)
begin
	if (Rst = '1') then
		temp <= '0';
	elsif (rising_edge(CLK)) then
		if T = '0' then
			temp <= temp;
		else
			temp <= not temp;
		end if;
	end if;
end process;
Q <= temp;
end behave;