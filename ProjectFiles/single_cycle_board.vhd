library ieee; 
use ieee.std_logic_1164.all;
use work.multiplex_pack.all;

entity single_cycle_board is 
port(
	  
	  KEY0 : in std_logic;
	  KEY1 : in std_logic;
	  HEX5 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX4 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX3 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX2 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX1 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX0 : out std_logic_vector(7 DOWNTO 0) := "10100000");
end entity single_cycle_board;

architecture behave of single_cycle_board is
signal PCOut : std_logic_vector (31 downto 0);
signal dataI : std_logic_vector (31 downto 0);
signal wren : std_logic := '0';
signal PCIn : std_logic_vector (31 downto 0);
signal constAddr : std_logic_vector (31 downto 0) :="00000000000000000000000000000001";
signal instruc : std_logic_vector (31 downto 0 );
signal reg1 : std_logic_vector (4 downto 0);
signal reg2 : std_logic_vector (4 downto 0);
signal wrtIn : std_logic_vector (4 downto 0);
signal SEIn : std_logic_vector (15 downto 0);
signal SEOut: std_logic_vector (31 downto 0);
signal RdData1 : std_logic_vector (31 downto 0);
signal RdData2 : std_logic_vector (31 downto 0);
signal wrtData : std_logic_vector (31 downto 0);
signal MXOut : std_logic_vector (31 downto 0);
signal adder2In : std_logic_vector (31 downto 0);
signal adder2Out : std_logic_vector (31 downto 0);
signal SLOut : std_logic_vector (31 downto 0);
signal mux4Sel : std_logic;
signal regDst : std_logic;
signal branch : std_logic;
signal regWrite : std_logic;
signal ALUSource : std_logic;
signal memToReg : std_logic;
signal memRW : std_logic;
signal ALUOp : std_logic_vector(1 downto 0);
signal ALUCntrl : std_logic_vector(3 downto 0);
signal DMOut : std_logic_vector(31 downto 0);
signal ALUOut : std_logic_vector(31 downto 0);
signal zeroCheck : std_logic;
signal notClock : std_logic;
signal delayCLK : std_logic;
signal clock : std_logic;
signal resetn  : std_logic := '0';


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

component RW_Unit is
port (ReadIn1 : in std_logic_vector (4 downto 0);
		ReadIn2 : in std_logic_vector (4 downto 0);
		WriteIn : in std_logic_vector (4 downto 0);
		WriteData : in std_logic_vector (31 downto 0);
		RegWrite : in std_logic;
		clk : in std_logic;
		readOut1 : out std_logic_vector (31 downto 0);
		readOut2 : out std_logic_vector (31 downto 0));
end component;

component signExtend is
port (in1 : in std_logic_vector (15 downto 0);
		out1 : out std_logic_vector (31 downto 0));
end component;


component ALUMux is
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		ALUSrc : in std_logic;
		out1 : out std_logic_vector (31 downto 0));
end component;

component ALU is
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		ALUCode : in std_logic_vector (3 downto 0);
		zeroFlag : out std_logic;
		ALUResult : out std_logic_vector (31 downto 0));
end component;

component Mux_5bit_2x1 is
port (in1 : in std_logic_vector (4 downto 0);
		in2 : in std_logic_vector (4 downto 0);
		ALUSrc : in std_logic;
		out1 : out std_logic_vector (4 downto 0));
end component;

component shiftLeft is
port(signExtend : in std_logic_vector(31 downto 0);
		shiftOut : out std_logic_vector(31 downto 0));
end component;

component Mux_32bit_2x1 is
port (in1 : in std_logic_vector (31 downto 0);
		in2 : in std_logic_vector (31 downto 0);
		ALUSrc : in std_logic;
		out1 : out std_logic_vector (31 downto 0));
end component;

component controlUnit is
port( opcode : in std_logic_vector(5 downto 0);
		regDst : out std_logic;
		branch : out std_logic;
		regWrite : out std_logic;
		ALUSource : out std_logic;
		memToReg : out std_logic;
		memRW : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0));
end component;

component andBlock is
port( wEn, decOut : in std_logic;
		C : out std_logic);
end component;

component ALUControl is
	port(ALUOp : in std_logic_vector(1 downto 0);
			functCode : in std_logic_vector(5 downto 0);
			ALUCont : out std_logic_vector(3 downto 0));
end component;

component dataMem IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component delayUnit is
port( CLK : in std_logic;
		DCLK : out std_logic);
end component;


component phase3SevSeg is
	port(in1 : in std_logic_vector(3 downto 0);
			hex1 : out std_logic_vector(7 downto 0));
end component;

begin
clock <= KEY0;
resetn <= KEY1;
notClock <= not clock;
DUT1: instructionMem port map (PCOut(7 downto 0),clock,dataI,wren,instruc);
DUT2: progCount port map (PCIn,resetn,clock,PCOut);
DUT3: add_block port map (PCOut,constAddr,adder2In);

reg1 <= instruc(25 downto 21);
reg2 <= instruc(20 downto 16);
SEIn <= instruc(15 downto 0);

DUT4: Mux_5bit_2x1 port map (instruc(20 downto 16),instruc(15 downto 11), regDst, wrtIn);
DUT5: RW_Unit port map (reg1, reg2, wrtIn, wrtData, regWrite, notClock, RdData1, RdData2);
DUT6: signExtend port map (SEIn, SEOut);
DUT7: ALUMux port map (RdData2,SEOut,ALUSource,MXOut);
DUT8: ALU port map (RdData1,MXOut,ALUCntrl,zeroCheck, ALUOut);


DUT9: dataMem port map (ALUOut(7 downto 0),delayCLK,RdData2,MemRW,DMOut);

DUT10: add_block port map (adder2In, SLOut, adder2Out);
DUT11: shiftLeft port map (SEOut, SLOut);
DUT12: Mux_32bit_2x1 port map (adder2In, adder2Out, mux4Sel, PCIn);

DUT13: controlUnit port map (instruc(31 downto 26), regDst, branch, regWrite, ALUSource, memToReg, memRW, ALUOp);
DUT14: andBlock port map (branch, zeroCheck, mux4Sel);
DUT15: Mux_32bit_2x1 port map (ALUOut, DMOut, memToReg, wrtData);
DUT16: ALUControl port map (ALUOp, instruc(5 downto 0), ALUCntrl);

DUT17: delayUnit port map (clock, delayCLK);

DUT18: phase3SevSeg port map (wrtData(3 downto 0), HEX0);
DUT19: phase3SevSeg port map (wrtData(7 downto 4), HEX1);
DUT20: phase3SevSeg port map (wrtData(11 downto 8), HEX2);
DUT21: phase3SevSeg port map (wrtData(15 downto 12), HEX3);
DUT22: phase3SevSeg port map (wrtData(19 downto 16), HEX4);
DUT23: phase3SevSeg port map (wrtData(23 downto 20), HEX5);

end behave;