library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Mux_5bit_2x1 is
port (in1 : in std_logic_vector (4 downto 0);
		in2 : in std_logic_vector (4 downto 0);
		ALUSrc : in std_logic;
		out1 : out std_logic_vector (4 downto 0));
end Mux_5bit_2x1;

architecture arch of Mux_5bit_2x1 is
signal temp : std_logic_vector (4 downto 0);
begin
process(ALUSrc, in1, in2)
begin
	IF ALUSrc = '1' THEN
		temp <= in2;
	ELSE
		temp <= in1;
	END IF;
		
end process;
out1 <= temp;
end arch;