library ieee;
use ieee.std_logic_1164.all;

entity phase3SevSeg is
	port(in1 : in std_logic_vector(3 downto 0);
			hex1 : out std_logic_vector(7 downto 0));
end phase3SevSeg;

architecture seg of phase3SevSeg is
begin
process(in1)
begin
	case in1 is
		when "0000" => --0
			hex1 <= "11000000";
		when "0001" => --1
			hex1 <= "11111001";
		when "0010" => --2
			hex1 <= "10100100";
		when "0011" => --3
			hex1 <= "10110000";
		when "0100" => --4
			hex1 <= "10011001";
		when "0101" => --5
			hex1 <= "10010010";
		when "0110" => --6
			hex1 <= "10000010";
		when "0111" => --7
			hex1 <= "11111000";
		when "1000" => --8
			hex1 <= "10000000";
		when "1001" => --9
			hex1 <= "10010000";
		when "1010" => --a
			hex1 <= "10100000";
		when "1011" => --b
			hex1 <= "10000011";
		when "1100" => --c
			hex1 <= "10100111";
		when "1101" => --d
			hex1 <= "10100001";
		when "1110" => --e
			hex1 <= "10000110";
		when "1111" => --f
			hex1 <= "10001110";
		when others => 
			hex1 <= "--------";
	end case;
end process;
end seg;