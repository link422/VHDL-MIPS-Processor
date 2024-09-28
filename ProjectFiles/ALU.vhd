library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		ALUCode : in std_logic_vector (3 downto 0);
		zeroFlag : out std_logic;
		ALUResult : out std_logic_vector (31 downto 0));
end ALU;

architecture behav of ALU is
signal temp : std_logic_vector (31 downto 0);
begin
process(in1, in2, ALUCode)
begin
	case ALUCode is 
		when "0000" =>
			temp <= in1 AND in2;
		when "0001" =>
		   temp <= in1 OR in2;
		when "0010" =>
			temp <= in1 + in2;
		when "0110" =>
			temp <= in1 - in2;
		when "0111" =>
			temp <= in1 XOR in2;
		when "1100" =>
			temp <= in1 NOR in2;
		when others =>
			temp <= in1 + in2;
	end case;
	
end process;

process(temp)
begin
	IF temp = "00000000000000000000000000000000" THEN
		zeroFlag <= '1';
	ELSE
		zeroFlag <= '0';
	END IF;
end process;

ALUResult <= temp;
end behav;