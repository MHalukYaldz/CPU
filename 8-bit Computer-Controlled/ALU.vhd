library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port(A			: in std_logic_vector(7 downto 0);
		 B			: in std_logic_vector(7 downto 0);
		 ALU_Sel	: in std_logic_vector(2 downto 0);
		 NZVC		: out std_logic_vector(3 downto 0);
		 ALU_Result	: out std_logic_vector(7 downto 0)
	);
end ALU;

architecture Behavioral of ALU is

signal Result_sig       : std_logic_vector(7 downto 0);
signal ALU_sig          : unsigned(8 downto 0);
signal ABST_OVERFLOW    : std_logic;
signal SUM_OVERFLOW     : std_logic;

begin

L_ALU: process(ALU_Sel, A, B)

variable ALU_Var : unsigned(8 downto 0);

begin

Result_sig	<= (others => '0');
ALU_Var	    := (others => '0');

	case (ALU_Sel) is
--------------------AND---------------------------------
		when "010" 	=> 	Result_sig	<= A AND B;

--------------------OR----------------------------------		
		when "011" 	=> 	Result_sig	<= A OR B;

--------------------INCREASE----------------------------
		when "100" 	=> 	Result_sig	<= std_logic_vector(unsigned(A) + 1);

--------------------DECREASE----------------------------
		when "101" 	=> 	Result_sig	<= std_logic_vector(unsigned(A) - 1);

--------------------SUM---------------------------------
		when "000" 	=> 	ALU_Var := (unsigned('0' & A) + unsigned('0' & B));
						Result_sig	<= std_logic_vector(ALU_Var(7 downto 0));

--------------------ABST--------------------------------
		when "001" 	=> 	ALU_Var := (unsigned('0' & A) - unsigned('0' & B));
						Result_sig	<= std_logic_vector(ALU_Var(7 downto 0));
		when others =>
                        Result_sig <= (others => '0');
	end case;

ALU_sig <= ALU_Var;

end process;	 

ALU_Result <= Result_sig;


--NZVC(NEGATIVE_ZERO_OVERFLOW_CARRY)

--------------------NEGATIVE---------------------------------
NZVC(3) <= Result_sig(7);

--------------------ZERO-------------------------------------
NZVC(2) <= '1' when Result_sig = x"00" else '0';

--------------------OVERFLOW---------------------------------
SUM_OVERFLOW   <=   (( A(7) AND B(7) AND not Result_sig(7)) OR (not A(7) AND not B(7) AND Result_sig(7)));
ABST_OVERFLOW  <=   ((A(7) AND not B(7) AND not Result_sig(7)) OR (not A(7) AND B(7) AND Result_sig(7)));

NZVC(1) <= SUM_OVERFLOW when (ALU_Sel="000") else
           ABST_OVERFLOW when (ALU_Sel="001") 
           else '0';

--------------------CARRY------------------------------------
NZVC(0) <= ALU_sig(8) when (ALU_Sel="000" OR ALU_Sel="001") else '0';
end Behavioral;






