library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.multiplex_pack.all;

entity Mux_32x1 is
port( Sel : in std_logic_vector (4 downto 0);
		Regs : regArray;
		dataOut : out std_logic_vector (31 downto 0));
end Mux_32x1;

architecture behav of Mux_32x1 is
begin
process(Sel, Regs)
begin
	case Sel is 
		when "00000" => dataOut <= Regs(0);
		when "00001" => dataOut <= Regs(1);
		when "00010" => dataOut <= Regs(2);
		when "00011" => dataOut <= Regs(3);
		when "00100" => dataOut <= Regs(4);
		when "00101" => dataOut <= Regs(5);
		when "00110" => dataOut <= Regs(6);
		when "00111" => dataOut <= Regs(7);
		when "01000" => dataOut <= Regs(8);
		when "01001" => dataOut <= Regs(9);
		when "01010" => dataOut <= Regs(10);
		when "01011" => dataOut <= Regs(11);
		when "01100" => dataOut <= Regs(12);
		when "01101" => dataOut <= Regs(13);
		when "01110" => dataOut <= Regs(14);
		when "01111" => dataOut <= Regs(15);
		when "10000" => dataOut <= Regs(16);
		when "10001" => dataOut <= Regs(17);
		when "10010" => dataOut <= Regs(18);
		when "10011" => dataOut <= Regs(19);
		when "10100" => dataOut <= Regs(20);
		when "10101" => dataOut <= Regs(21);
		when "10110" => dataOut <= Regs(22);
		when "10111" => dataOut <= Regs(23);
		when "11000" => dataOut <= Regs(24);
		when "11001" => dataOut <= Regs(25);
		when "11010" => dataOut <= Regs(26);
		when "11011" => dataOut <= Regs(27);
		when "11100" => dataOut <= Regs(28);
		when "11101" => dataOut <= Regs(29);
		when "11110" => dataOut <= Regs(30);
		when "11111" => dataOut <= Regs(31);
		when others  => dataOut <= Regs(0);
	end case;
end process;
end behav;
		
