LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY reg_32 IS
	GENERIC ( N : INTEGER := 32 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	CIn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END reg_32;
ARCHITECTURE Behavior OF reg_32 IS
signal hasRst : std_logic := '0';
BEGIN
	PROCESS ( hasRst,Clock )
	BEGIN
		IF hasRst = '0' THEN
			Q <= "00000000000000000000000000000000";
			hasRst <= '1';
		ELSIF CIn = '1' THEN
		   IF Clock'EVENT AND Clock = '1' THEN
				Q <= D ;
			END IF;
		END IF ;
	END PROCESS ;
END Behavior ;
