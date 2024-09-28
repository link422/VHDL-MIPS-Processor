library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
port( opcode : in std_logic_vector(5 downto 0);
		regDst : out std_logic;
		branch : out std_logic;
		regWrite : out std_logic;
		ALUSource : out std_logic;
		memToReg : out std_logic;
		memRW : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0));
end controlUnit;

architecture behave of controlUnit is
begin

process(opCode)
begin
	case opCode is
		when "000000" =>
			regDst <= '1';
			branch <= '0';
			regWrite <= '1';
			ALUSource <= '0';
			memToReg <= '0';
			memRW <= '0';
			ALUOp <= "10";
		when "000100" =>
			regDst <= '-';
			branch <= '1';
			regWrite <= '0'; 
			ALUSource <= '0';
			memToReg <= '-';
			memRW <= '0';
			ALUOp <= "01";
		when "001000" =>
			regDst <= '0';
			branch <= '0';
			regWrite <= '1'; 
			ALUSource <= '1';
			memToReg <= '0';
			memRW <= '0';
			ALUOp <= "00";
		when "100011" =>
			regDst <= '0';
			branch <= '0';
			regWrite <= '1'; 
			ALUSource <= '1';
			memToReg <= '1';
			memRW <= '0';
			ALUOp <= "00";
		when "101011" =>
			regDst <= '-';
			branch <= '0';
			regWrite <= '0'; 
			ALUSource <= '1';
			memToReg <= '-';
			memRW <= '1';
			ALUOp <= "00";
		when others =>
			regDst <= '-';
	end case;
end process;

end behave;