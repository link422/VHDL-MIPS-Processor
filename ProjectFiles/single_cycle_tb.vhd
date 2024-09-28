library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity single_cycle_tb is
end single_cycle_tb;

architecture behavior of single_cycle_tb is
signal address_tb : std_logic_vector (31 downto 0);
signal currInstruc_tb : std_logic_vector (31 downto 0);
signal ALURes_tb : std_logic_vector (31 downto 0);
signal regOut1_tb : std_logic_vector (31 downto 0);
signal regOut2_tb : std_logic_vector (31 downto 0);
signal zeroCheck_tb : std_logic;
signal clk_tb : std_logic := '1';
signal resetn_tb : std_logic := '0';



component single_cycle_top is
port(
	  clock : in std_logic;
	  address : out std_logic_vector (31 downto 0 );
	  currInstruc : out std_logic_vector (31 downto 0);
	  resetn  : in std_logic;
	  regOut1 : out std_logic_vector (31 downto 0);
	  regOut2 : out std_logic_vector (31 downto 0);
	  ALURes : out std_logic_vector (31 downto 0 );
	  zeroCheckOut : out std_logic);
end component;

begin
dut: single_cycle_top port map (clk_tb, address_tb, currInstruc_tb, resetn_tb, regOut1_tb, regOut2_tb, ALURes_tb, zeroCheck_tb);
process
begin
wait for 50 ns;
resetn_tb <= '1';
clk_tb <= not clk_tb;
wait for 50 ns;
clk_tb <= not clk_tb;
end process;

end behavior;