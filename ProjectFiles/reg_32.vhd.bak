LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY progCount IS
	GENERIC ( N : INTEGER := 32 ) ;
	PORT ( D : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	Resetn, Clock : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END progCount;
ARCHITECTURE Behavior OF progCount IS
BEGIN
	PROCESS ( Resetn, Clock )
	BEGIN
		IF Resetn = '0' THEN
			Q <= (OTHERS => '0') ;
		ELSIF Clock'EVENT AND Clock = '1' THEN
			Q <= D ;
		END IF ;
	END PROCESS ;
END Behavior ;
