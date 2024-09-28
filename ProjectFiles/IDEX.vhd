LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY IDEX IS
	GENERIC ( N : INTEGER := 146 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END IDEX;
ARCHITECTURE Behavior OF IDEX IS
signal hasRst : std_logic := '0';
BEGIN
	PROCESS ( hasRst,Clock )
	BEGIN
		IF hasRst = '0' THEN
			Q <= (others =>'0');
			hasRst <= '1';
		ELSIF CIn = '1' THEN
		   IF Clock'EVENT AND Clock = '1' THEN
				Q <= D ;
			END IF;
		END IF ;
	END PROCESS ;
END Behavior ;
