library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shiftLeft is
port(signExtend : in std_logic_vector(31 downto 0);
		shiftOut : out std_logic_vector(31 downto 0));
end shiftLeft;

architecture shift of shiftLeft is
begin

shiftOut <= signExtend(29 downto 0) & "00";

end shift;