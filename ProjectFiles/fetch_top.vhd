library ieee; 
use ieee.std_logic_1164.all;

entity fetch_top is
port(
	  clock : in std_logic;
	  addrIn: out std_logic_vector (31 downto 0 );
	  D       : out std_logic_vector (31 downto 0 );
	  address : out std_logic_vector (31 downto 0 );
	  resetn  : in std_logic;
	  q: out std_logic_vector (31 downto 0));
end entity fetch_top;

architecture behave of fetch_top is
signal PCOut : std_logic_vector (31 downto 0);
signal dataI : std_logic_vector (31 downto 0);
signal wren : std_logic := '0';
signal PCIn : std_logic_vector (31 downto 0);
signal constAddr : std_logic_vector (31 downto 0) :="00000000000000000000000000000001";

component instructionMem
port(address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

component progCount
generic ( N : INTEGER := 32 ) ;
port(D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		Resetn, Clock : IN STD_LOGIC ;
		Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
end component;

component add_block
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		out1 : out std_logic_vector (31 downto 0));
end component;

begin
DUT1: instructionMem port map (PCOut(7 downto 0),clock,dataI,wren,q);
DUT2: progCount port map (PCIn,resetn,clock,PCOut);
DUT3: add_block port map (PCOut,constAddr,PCIn);
D <= PCIn;
address <= PCOut;
addrIn <= constAddr;


end behave;