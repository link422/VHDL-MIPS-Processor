library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is
signal a : std_logic_vector (31 downto 0);
signal b : std_logic_vector (31 downto 0);
signal code : std_logic_vector (3 downto 0);
signal zFlag : std_logic;
signal o : std_logic_vector (31 downto 0);


component ALU is
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		ALUCode : in std_logic_vector (3 downto 0);
		zeroFlag : out std_logic;
		ALUResult : out std_logic_vector (31 downto 0));
end component;

begin
dut: ALU port map (a,b,code,zFlag,o);
process
begin
a <= "10001000100010000000000000000000";
b <= "01100000000000000000000000000000";	
code <= "0000";
wait for 10 ns;
code <= "0001";
wait for 10 ns;
code <= "0010";
wait for 10 ns;
code <= "0110";
wait for 10 ns;
code <= "0111";
wait for 10 ns;
code <= "1100";
wait for 10 ns;
a <= "00000000000000000000000000000000";
b <= "00000000000000000000000000000000";	
code <= "0000";
end process;

end behavior;