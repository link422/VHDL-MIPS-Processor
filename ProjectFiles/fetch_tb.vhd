library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fetch_tb is
end fetch_tb;

architecture behavior of fetch_tb is
signal pcIn_tb : std_logic_vector (31 downto 0);
signal pcOut_tb : std_logic_vector (31 downto 0 );
signal addrIn_tb : std_logic_vector (31 downto 0);
signal instOut_tb : std_logic_vector (31 downto 0);
signal clk_tb : std_logic := '1';
signal resetn_tb : std_logic := '0';


component fetch_top is
port(
	  clock : in std_logic;
	  addrIn: out std_logic_vector (31 downto 0 );
	  D       : out std_logic_vector (31 downto 0 );
	  address : out std_logic_vector (31 downto 0 );
	  resetn  : in std_logic;
	  q: out std_logic_vector (31 downto 0));
end component;

begin
dut: fetch_top port map (clk_tb, addrIn_tb, pcIn_tb, pcOut_tb, resetn_tb, instOut_tb);
process
begin
wait for 50 ns;
clk_tb <= not clk_tb;
wait for 50 ns;
clk_tb <= not clk_tb;
wait for 25ns;
resetn_tb <= '1';
wait for 25ns;
clk_tb <= not clk_tb;
end process;

end behavior;