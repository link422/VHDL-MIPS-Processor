library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.multiplex_pack.all;

entity RW_Unit is
port (ReadIn1 : in std_logic_vector (4 downto 0);
		ReadIn2 : in std_logic_vector (4 downto 0);
		WriteIn : in std_logic_vector (4 downto 0);
		WriteData : in std_logic_vector (31 downto 0);
		RegWrite : in std_logic;
		clk : in std_logic;
		readOut1 : out std_logic_vector (31 downto 0);
		readOut2 : out std_logic_vector (31 downto 0));
end RW_Unit;

architecture struc of RW_Unit is
signal outRegs : regArray;
signal outAnds : std_logic_vector (31 downto 0);
signal outDecode : std_logic_vector (31 downto 0);

component andBlock
port( wEn, decOut : in std_logic;
		C : out std_logic);
end component;

component decoder is
port( x : in std_logic_vector (4 downto 0);
		regNum : out std_logic_vector (31 downto 0));
end component;

component reg_32 IS
	GENERIC ( N : INTEGER := 32 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component Mux_32x1 is
port( Sel : in std_logic_vector (4 downto 0);
		Regs : regArray;
		dataOut : out std_logic_vector (31 downto 0));
end component;



begin

MUX1: Mux_32x1 port map (ReadIn1,outRegs,readOut1);
MUX2: Mux_32x1 port map (ReadIn2,outRegs,readOut2);
DEC1: decoder port map (WriteIn,outDecode);

ands1: for i in 0 to 31 generate
	a1: andBlock port map(RegWrite, outDecode(i),outAnds(i));
end generate ands1;

regs1: for j in 0 to 31 generate
	r1: reg_32 port map(WriteData, outAnds(j),clk,outRegs(j));
end generate regs1;



end struc;