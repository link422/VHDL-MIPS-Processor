library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity andBlock is
port( wEn, decOut : in std_logic;
		C : out std_logic);
end andBlock;

architecture behave of andBlock is
begin

C <= wEn and decOut;

end behave;