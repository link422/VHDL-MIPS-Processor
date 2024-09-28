library ieee; 
use ieee.std_logic_1164.all;
use work.multiplex_pack.all;

entity pipeline_board is
port(
	  KEY0 : in std_logic;
	  KEY1 : in std_logic;
	  HEX5 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX4 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX3 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX2 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX1 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX0 : out std_logic_vector(7 DOWNTO 0) := "10100000");
end entity pipeline_board;

architecture behave of pipeline_board is
signal PCOut : std_logic_vector (31 downto 0);
signal dataI : std_logic_vector (31 downto 0);
signal wren : std_logic := '0';
signal PCIn : std_logic_vector (31 downto 0);
signal constAddr : std_logic_vector (31 downto 0) :="00000000000000000000000000000001";
--signal instruc : std_logic_vector (31 downto 0 );
signal reg1 : std_logic_vector (4 downto 0);
signal reg2 : std_logic_vector (4 downto 0);
signal wrtInToEXMEM : std_logic_vector (4 downto 0);
signal wrtInFromEXMEM : std_logic_vector (4 downto 0);
signal wrtInFromMEMWB : std_logic_vector (4 downto 0);
signal SEIn : std_logic_vector (15 downto 0);
signal SEOut: std_logic_vector (31 downto 0);
signal RdData1 : std_logic_vector (31 downto 0);
signal RdData2 : std_logic_vector (31 downto 0);
signal wrtData : std_logic_vector (31 downto 0);
signal MXOut : std_logic_vector (31 downto 0);
signal adder2ToEXMEM : std_logic_vector (31 downto 0);
signal adder2FromEXMEM : std_logic_vector (31 downto 0);
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
signal DMOutToMEMWB : std_logic_vector(31 downto 0);
signal DMOutFromMEMWB : std_logic_vector(31 downto 0);
signal ALUOutToEXMEM : std_logic_vector(31 downto 0);
signal ALUOutFromEXMEM : std_logic_vector(31 downto 0);
signal zeroCheckToEXMEM : std_logic;
signal zeroCheckFromEXMEM : std_logic;
signal alwsOne : std_logic := '1';
signal clock : std_logic;
signal resetn  : std_logic := '0';

signal IFIDIn : std_logic_vector(63 downto 0);
signal IFIDOut : std_logic_vector(63 downto 0);
signal IFID_PC : std_logic_vector(31 downto 0);
signal IFID_inst : std_logic_vector(31 downto 0);

signal IDEXIn : std_logic_vector(145 downto 0);
signal IDEXOut : std_logic_vector(145 downto 0);

signal EXMEMIn : std_logic_vector(105 downto 0);
signal EXMEMOut : std_logic_vector(105 downto 0);

signal MEMWBIn : std_logic_vector(70 downto 0);
signal MEMWBOut : std_logic_vector(70 downto 0);


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

component IFID IS
	GENERIC ( N : INTEGER := 64 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component IDEX IS
	GENERIC ( N : INTEGER := 146 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component EXMEM IS
	GENERIC ( N : INTEGER := 106 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component MEMWB IS
	GENERIC ( N : INTEGER := 71 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component phase3SevSeg is
	port(in1 : in std_logic_vector(3 downto 0);
			hex1 : out std_logic_vector(7 downto 0));
end component;


begin
clock <= KEY0;
resetn <= KEY1;
DUT1: instructionMem port map (PCOut(7 downto 0),clock,dataI,wren,IFIDIn(31 downto 0));
DUT2: progCount port map (PCIn,resetn,clock,PCOut);
DUT3: add_block port map (PCOut,constAddr,IFIDIn(63 downto 32));


reg1 <= IFID_inst(25 downto 21);
reg2 <= IFID_inst(20 downto 16);
SEIn <= IFID_inst(15 downto 0);

DUT4: Mux_5bit_2x1 port map (IDEXOut(9 downto 5),IDEXOut(4 downto 0), IDEXOut(145), wrtInToEXMEM);
DUT5: RW_Unit port map (reg1, reg2, wrtInFromMEMWB, wrtData, MEMWBOut(70), clock, RdData1, RdData2);
DUT6: signExtend port map (SEIn, SEOut);
DUT7: ALUMux port map (IDEXOut(73 downto 42),IDEXOut(41 downto 10),IDEXOut(142),MXOut);
DUT8: ALU port map (IDEXOut(105 downto 74),MXOut,ALUCntrl,zeroCheckToEXMEM, ALUOutToEXMEM);


DUT9: dataMem port map (ALUOutFromEXMEM(7 downto 0),clock,EXMEMOut(36 downto 5),EXMEMOut(102),DMOutToMEMWB);

DUT10: add_block port map (IDEXOut(137 downto 106), SLOut, adder2ToEXMEM);
DUT11: shiftLeft port map (IDEXOut(41 downto 10), SLOut);
DUT12: Mux_32bit_2x1 port map (IFIDIn(63 downto 32), adder2FromEXMEM, mux4Sel, PCIn);

DUT13: controlUnit port map (IFID_inst(31 downto 26), regDst, branch, regWrite, ALUSource, memToReg, memRW, ALUOp);
DUT14: andBlock port map (EXMEMOut(105), zeroCheckFromEXMEM, mux4Sel);
DUT15: Mux_32bit_2x1 port map (MEMWBOut(36 downto 5), DMOutFromMEMWB, MEMWBOut(69), wrtData);
DUT16: ALUControl port map (IDEXOut(139 downto 138), IDEXOut(15 downto 10), ALUCntrl);

DUT17 : IFID port map (IFIDIn, alwsOne, clock, IFIDOut);
IFID_PC <= IFIDOut(63 downto 32);
IFID_inst <= IFIDOut(31 downto 0);

DUT18: IDEX port map (IDEXIn, alwsOne, clock, IDEXOut);
IDEXIn(145) <= regDst;
IDEXIn(144) <= branch;
IDEXIn(143) <= regWrite;
IDEXIn(142) <= ALUSource;
IDEXIn(141) <= memToReg;
IDEXIn(140) <= memRW;
IDEXIn(139 downto 138) <= ALUOp;
IDEXIn(137 downto 106) <= IFID_PC;
IDEXIn(105 downto 74) <= RdData1;
IDEXIn(73 downto 42) <= RdData2;
IDEXIn(41 downto 10) <= SEOut;
IDEXIn(9 downto 5) <= IFID_inst(20 downto 16);
IDEXIn(4 downto 0) <= IFID_inst(15 downto 11);


DUT19: EXMEM port map (EXMEMIn, alwsOne, clock, EXMEMOut);
EXMEMIn(105) <= IDEXOut(144); --branch
EXMEMIn(104) <= IDEXOut(143); --regWrite
EXMEMIn(103) <= IDEXOut(141); --memToReg
EXMEMIn(102) <= IDEXOut(140); --memRW
EXMEMIn(101 downto 70) <= adder2ToEXMEM;
adder2FromEXMEM <= EXMEMOut(101 downto 70);
EXMEMIn(69) <= zeroCheckToEXMEM;
zeroCheckFromEXMEM <= EXMEMOut(69);
EXMEMIn(68 downto 37) <= ALUOutToEXMEM;
ALUOutFromEXMEM <= EXMEMOut(68 downto 37);
EXMEMIn(36 downto 5) <= IDEXOut(73 downto 42);
EXMEMIn(4 downto 0) <= wrtInToEXMEM;
wrtInFromEXMEM <= EXMEMOut(4 downto 0);

DUT20: MEMWB port map (MEMWBIn, alwsOne, clock, MEMWBOut);
MEMWBIn(70) <= EXMEMOut(104); --regWrite
MEMWBIn(69) <= EXMEMOut(103); --memToReg
MEMWBIn(68 downto 37) <= DMOutToMEMWB;
DMOutFromMEMWB <= MEMWBOut(68 downto 37);
MEMWBIn(36 downto 5) <= ALUOutFromEXMEM;
MEMWBIn(4 downto 0) <= wrtInFromEXMEM;
wrtInFromMEMWB <= MEMWBOut(4 downto 0);

DUT21: phase3SevSeg port map (wrtData(3 downto 0), HEX0);
DUT22: phase3SevSeg port map (wrtData(7 downto 4), HEX1);
DUT23: phase3SevSeg port map (wrtData(11 downto 8), HEX2);
DUT24: phase3SevSeg port map (wrtData(15 downto 12), HEX3);
DUT25: phase3SevSeg port map (wrtData(19 downto 16), HEX4);
DUT26: phase3SevSeg port map (wrtData(23 downto 20), HEX5);


end behave;