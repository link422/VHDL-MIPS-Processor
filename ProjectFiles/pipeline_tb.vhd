library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pipeline_tb is
end pipeline_tb;

architecture behavior of pipeline_tb is
signal addrIn_tb : std_logic_vector (31 downto 0);
signal D_tb : std_logic_vector (31 downto 0 );
signal address_tb : std_logic_vector (31 downto 0);
signal ALURes_tb : std_logic_vector (31 downto 0);
signal zeroCheck_tb : std_logic;
signal clk_tb : std_logic := '1';
signal resetn_tb : std_logic := '0';



component pipeline_top is
port(
	  clock : in std_logic;
	  addrIn: out std_logic_vector (31 downto 0 );
	  D       : out std_logic_vector (31 downto 0 );
	  address : out std_logic_vector (31 downto 0 );
	  resetn  : in std_logic;
	  ALURes : out std_logic_vector (31 downto 0 );
	  zeroCheckOut : out std_logic);
end component;

begin
dut: pipeline_top port map (clk_tb, addrIn_tb, D_tb, address_tb, resetn_tb, ALURes_tb, zeroCheck_tb);
process
begin
wait for 50 ns;
resetn_tb <= '1';
clk_tb <= not clk_tb;
wait for 50 ns;
clk_tb <= not clk_tb;
end process;

end behavior;