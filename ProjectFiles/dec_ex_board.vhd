library ieee; 
use ieee.std_logic_1164.all;
use work.multiplex_pack.all;

entity dec_ex_board is
port(
	  SW0 : in std_logic;
	  SW1 : in std_logic;
	  SW2 : in std_logic;
	  SW3 : in std_logic;
	  KEY0 : in std_logic;
	  KEY1 : in std_logic;
	  HEX5 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX4 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX3 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX2 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX1 : out std_logic_vector(7 DOWNTO 0) := "10100000";
	  HEX0 : out std_logic_vector(7 DOWNTO 0) := "10100000");
end entity dec_ex_board;

architecture behave of dec_ex_board is
signal regWrt: std_logic := '0';
signal ALUSource : std_logic := '0';
signal ALUOp : std_logic_vector (3 downto 0) := "0010";
signal ALURes : std_logic_vector (31 downto 0 );
signal zeroCheck : std_logic;
signal instruc : std_logic_vector (31 downto 0 ) := "00000000000000000000000000000000";
signal reg1 : std_logic_vector (4 downto 0);
signal reg2 : std_logic_vector (4 downto 0);
signal wrtIn : std_logic_vector (4 downto 0);
signal SEIn : std_logic_vector (15 downto 0);
signal SEOut: std_logic_vector (31 downto 0);
signal RdData1 : std_logic_vector (31 downto 0);
signal RdData2 : std_logic_vector (31 downto 0);
signal wrtData : std_logic_vector (31 downto 0);
signal MXOut : std_logic_vector (31 downto 0);
signal instState : std_logic_vector (4 downto 0) := "00000";
signal SWArray : std_logic_vector (2 downto 0);


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

component sevSeg is
	port(x : in std_logic_vector(7 downto 0);
			o1,o2 : out std_logic_vector(7 downto 0));
end component;

begin

process(instruc)
begin
if(instruc(31 downto 26) = "000000") then

	reg1 <= instruc(25 downto 21);
	reg2 <= instruc(20 downto 16);
	wrtIn<= instruc(15 downto 11);
	SEIn <= instruc(15 downto 0);
else
	reg1 <= instruc(25 downto 21);
	wrtIn <= instruc(20 downto 16);
	SEIn <= instruc(15 downto 0);
end if;
end process;



process(KEY1)
begin
if instState /= "10001" and rising_edge(KEY1) then
	case instState is
		when "00000" => 
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000010110000000000000100";
			instState <= "00001";
		when "00001" => 
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000011000000000000000100";
			instState <= "00010";
		when "00010" => 
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000100010000000000000100";
			instState <= "00011";
		when "00011" => 
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000100100000000000000100";
			instState <= "00100";
		when "00100" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000010000000000000000001";
			instState <= "00101";
		when "00101" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000010010000000000000010";
			instState <= "00110";
		when "00110" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000011010000000000000011";
			instState <= "00111";
		when "00111" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000100000000000000000101";
			instState <= "01000";
		when "01000" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000100110000000000000110";
			instState <= "01001";
		when "01001" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100000000101000000000000000111";
			instState <= "10001";
		when others => regWrt <= '1';
	end case;
elsif instState = "10001" and rising_edge(KEY1) then
	case SWArray is
		when "001" =>
			regWrt <= '1';
			ALUSource <= '0';
			ALUOp <= "0010"; 
			instruc <= "00000001000010010101100000100000";
		when "010" =>
			regWrt <= '1';
			ALUSource <= '0';
			ALUOp <= "0110"; 
			instruc <= "00000010000100010110000000100010";
		when "011" =>
			regWrt <= '1';
			ALUSource <= '0';
			ALUOp <= "0000"; 
			instruc <= "00000001011011000110100000100100";
		when "100" =>
			regWrt <= '1';
			ALUSource <= '0';
			ALUOp <= "0111"; 
			instruc <= "00000010011101000100000000100110";
		when "101" =>
			regWrt <= '1';
			ALUSource <= '0';
			ALUOp <= "1100"; 
			instruc <= "00000001001010010100100000100111";
		when "110" =>
			regWrt <= '1';
			ALUSource <= '1';
			ALUOp <= "0010"; 
			instruc <= "00100010011100110000000000000100";
		when others => regWrt <= '1';
	end case;
end if;
end process;

DUT1: RW_Unit port map (reg1, reg2, wrtIn, wrtData, regWrt, SW0, RdData1, RdData2);
DUT2: signExtend port map (SEIn, SEOut);
DUT3: ALUMux port map (RdData2,SEOut,ALUSource,MXOut);
DUT4: ALU port map (RdData1,MXOut,ALUOp,zeroCheck,wrtData);
DUT5: sevSeg port map (RdData1(7 downto 0),HEX4,HEX5);
DUT6: sevSeg port map (RdData2(7 downto 0),HEX2,HEX3);
DUT7: sevSeg port map (wrtData(7 downto 0),HEX0,HEX1);
ALURes <= wrtData;
SWArray(2) <= SW3;
SWArray(1) <= SW2;
SWArray(0) <= SW1;


end behave;