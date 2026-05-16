library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL_UNIT is
    Port (Clk           : in std_logic;
          Reset         : in std_logic;
          IR            : in std_logic_vector(7 downto 0);
          CCR_Result    : in std_logic_vector(3 downto 0);
          
          IR_Load       : out std_logic;
          MAR_Load      : out std_logic;
          PC_Load       : out std_logic;
          PC_Inc        : out std_logic;
          A_Load        : out std_logic;
          B_Load        : out std_logic;
          ALU_Sel       : out std_logic_vector(2 downto 0);
          CCR_Load      : out std_logic;
          Bus1_Sel      : out std_logic_vector(1 downto 0);
          Bus2_Sel      : out std_logic_vector(1 downto 0);
          write         : out std_logic
    );
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

type state_type is
    (fetch_0, fetch_1, fetch_2,
     decode_3,
     S_A_yukle_sbt_4, S_A_yukle_sbt_5, S_A_yukle_sbt_6,
     S_A_yukle_4, S_A_yukle_5, S_A_yukle_6, S_A_yukle_7, S_A_yukle_8,
     S_B_yukle_sbt_4, S_B_yukle_sbt_5, S_B_yukle_sbt_6,
     S_B_yukle_4, S_B_yukle_5, S_B_yukle_6, S_B_yukle_7, S_B_yukle_8,
     S_A_yaz_4, S_A_yaz_5, S_A_yaz_6, S_A_yaz_7,
     S_AtopB_4,
     S_ATLA_4, S_ATLA_5, S_ATLA_6,
     S_ATLA_SIFIR_4, S_ATLA_SIFIR_5, S_ATLA_SIFIR_6, S_ATLA_SIFIR_7
     );

signal current_state, next_state : state_type;

--Tüm komutlar yerine sadece temel komutlarý tanýmlayalým
constant    c_A_yukle_sbt        : std_logic_vector(7 downto 0) := x"86";        --A kaydýna operand olarak verilen deðeri yazar.                   
constant    c_A_yukle            : std_logic_vector(7 downto 0) := x"87";        --Operand olarak verilen bellek adresindeki veriyi A kaydýna yazar.
constant    c_B_yukle_sbt        : std_logic_vector(7 downto 0) := x"88";        --B kaydýna operand olarak verilen deðeri yazar.                   
constant    c_B_yukle            : std_logic_vector(7 downto 0) := x"89";        --Operand olarak verilen bellek adresindeki veriyi B kaydýna yazar.
constant    c_A_yaz              : std_logic_vector(7 downto 0) := x"96";        --A kaydýndaki veriyi operand olarak verilen bellek adresine yazar.
constant    c_AtopB              : std_logic_vector(7 downto 0) := x"42";        --A ve B kayýtlarýný toplar, sonucu A kaydýna yazar.
constant    c_ATLA               : std_logic_vector(7 downto 0) := x"20";        --Koþulsuz olarak operand olarak verilen adrese dallanýr.
constant    c_ATLA_SIFIR         : std_logic_vector(7 downto 0) := x"23";        --Z bayraðý 1 ise operand olarak verilen adrese dallanýr.

begin
--------------------------------------------------------------------------------------|
-----------------------------------------Current_state_logic--------------------------|
--------------------------------------------------------------------------------------|
    Current_state_logic: process(Clk, Reset)
        begin
            if(Reset = '1') then
                current_state <= fetch_0;
            elsif(rising_edge(Clk)) then
                current_state <= next_state;
            end if;
    end process;

--------------------------------------------------------------------------------------|
-----------------------------------------Next_state_logic-----------------------------|
--------------------------------------------------------------------------------------|

    Next_state_logic : process(IR, current_state, CCR_Result)
        begin
            case (current_state) is
                when fetch_0 => next_state <= fetch_1;
                when fetch_1 => next_state <= fetch_2;
                when fetch_2 => next_state <= decode_3;
                when decode_3 =>
                    if(IR = c_A_yukle_sbt) then
                        next_state <= S_A_yukle_sbt_4;
                    elsif(IR = c_A_yukle) then
                        next_state <= S_A_yukle_4;
                    elsif(IR = c_B_yukle_sbt) then
                        next_state <= S_B_yukle_sbt_4;
                    elsif(IR = c_B_yukle) then
                        next_state <= S_B_yukle_4;
                    elsif(IR = c_A_yaz) then
                        next_state <= S_A_yaz_4;
                    elsif(IR = c_AtopB) then
                        next_state <= S_AtopB_4;
                    elsif(IR = c_ATLA) then
                        next_state <= S_ATLA_4;
                    elsif(IR = c_ATLA_SIFIR) then
                        if(CCR_Result(2) = '1') then
                            next_state <= S_ATLA_SIFIR_4;
                        else
                            next_state <= S_ATLA_SIFIR_7;
                        end if;
                    else
                        next_state <= fetch_0;
                    end if;                     
                        
--S_A_yukle_sbt diðer durumlarý     S_A_yukle_sbt_4, S_A_yukle_sbt_5, S_A_yukle_sbt_6
                when S_A_yukle_sbt_4 => next_state <= S_A_yukle_sbt_5;
                when S_A_yukle_sbt_5 => next_state <= S_A_yukle_sbt_6;
                when S_A_yukle_sbt_6 => next_state <= fetch_0;
                
--S_A_yukle diðer durumlarý     S_A_yukle_4, S_A_yukle_5, S_A_yukle_6, S_A_yukle_7, S_A_yukle_8
                when S_A_yukle_4 => next_state <= S_A_yukle_5;
                when S_A_yukle_5 => next_state <= S_A_yukle_6;
                when S_A_yukle_6 => next_state <= S_A_yukle_7;
                when S_A_yukle_7 => next_state <= S_A_yukle_8;
                when S_A_yukle_8 => next_state <= fetch_0;
                
--S_B_yukle_sbt diðer durumlarý     S_B_yukle_sbt_4, S_B_yukle_sbt_5, S_B_yukle_sbt_6
                when S_B_yukle_sbt_4 => next_state <= S_B_yukle_sbt_5;
                when S_B_yukle_sbt_5 => next_state <= S_B_yukle_sbt_6;
                when S_B_yukle_sbt_6 => next_state <= fetch_0;
                
--S_B_yukle diðer durumlarý     S_B_yukle_4, S_B_yukle_5, S_B_yukle_6, S_B_yukle_7, S_B_yukle_8
                when S_B_yukle_4 => next_state <= S_B_yukle_5;
                when S_B_yukle_5 => next_state <= S_B_yukle_6;
                when S_B_yukle_6 => next_state <= S_B_yukle_7;
                when S_B_yukle_7 => next_state <= S_B_yukle_8;
                when S_B_yukle_8 => next_state <= fetch_0;
                                                
--S_A_yaz diðer durumlarý     S_A_yaz_4, S_A_yaz_5, S_A_yaz_6, S_A_yaz_7
                when S_A_yaz_4 => next_state <= S_A_yaz_5;
                when S_A_yaz_5 => next_state <= S_A_yaz_6;
                when S_A_yaz_6 => next_state <= S_A_yaz_7;
                when S_A_yaz_7 => next_state <= fetch_0;

--S_AtopB durumu
                when S_AtopB_4 => next_state <= fetch_0;

--S_ATLA diðer durumlarý     S_ATLA_4, S_ATLA_5, S_ATLA_6
                when S_ATLA_4 => next_state <= S_ATLA_5;
                when S_ATLA_5 => next_state <= S_ATLA_6;
                when S_ATLA_6 => next_state <= fetch_0;

--S_ATLA_SIFIR diðer durumlarý     S_ATLA_SIFIR_4, S_ATLA_SIFIR_5, S_ATLA_SIFIR_6, S_ATLA_SIFIR_7
                when S_ATLA_SIFIR_4 => next_state <= S_ATLA_SIFIR_5;
                when S_ATLA_SIFIR_5 => next_state <= S_ATLA_SIFIR_6;
                when S_ATLA_SIFIR_6 => next_state <= fetch_0;
                when S_ATLA_SIFIR_7 => next_state <= fetch_0;
             --------------------------------------------
                when others => next_state <= fetch_0;
             --------------------------------------------   
            end case;
    end process;        

--------------------------------------------------------------------------------------|
-------------------------------------------Output_logic-------------------------------|
--------------------------------------------------------------------------------------|

    Output_logic: process(current_state)
        begin
            
            IR_Load     <= '0';
            MAR_Load    <= '0';
            PC_Load     <= '0';
            PC_Inc      <= '0';
            Bus1_Sel    <= (others => '0');
            Bus2_Sel    <= (others => '0');
            write       <= '0';
            A_Load      <= '0';
            B_Load      <= '0';
            ALU_Sel     <= (others => '0');
            CCR_Load   <= '0';
            
            case (current_state) is
                when fetch_0 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when fetch_1 =>
                    PC_Inc <= '1';
                when fetch_2 =>
                    Bus2_Sel <= "10";
                    IR_Load <= '1';
                when decode_3 =>
                ------------------
                when S_A_yukle_sbt_4 =>
                    Bus1_Sel <= "00";                
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_A_yukle_sbt_5 =>
                    PC_Inc <= '1';
                when S_A_yukle_sbt_6 =>
                    Bus2_Sel <= "10";
                    A_Load   <= '1';
                ------------------
                when S_A_yukle_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_A_yukle_5 =>
                    PC_Inc <= '1';
                when S_A_yukle_6 =>
                    Bus2_Sel <= "10";
                    MAR_Load <= '1';
                when S_A_yukle_7 =>
--MAR a yeni adres yuklendikten sonra RAM in o adresteki veriyi cikisa verebilmesi icin 1 clock beklemek gerekir                
                when S_A_yukle_8 =>
                    Bus2_Sel <= "10";
                    A_Load   <= '1';
                ------------------    
                when S_B_yukle_sbt_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_B_yukle_sbt_5 =>
                    PC_Inc <= '1';
                when S_B_yukle_sbt_6 =>
                    Bus2_Sel <= "10";
                    B_Load   <= '1';
                ------------------
                when S_B_yukle_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_B_yukle_5 =>
                    PC_Inc <= '1';
                when S_B_yukle_6 =>
                    Bus2_Sel <= "10";
                    MAR_Load <= '1';
                when S_B_yukle_7 =>
--MAR a yeni adres yuklendikten sonra RAM in o adresteki veriyi cikisa verebilmesi icin 1 clock beklemek gerekir                
                when S_B_yukle_8 =>
                    Bus2_Sel <= "10";
                    B_Load   <= '1';
                ------------------
                when S_A_yaz_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_A_yaz_5 =>
                    PC_Inc <= '1';
                when S_A_yaz_6 =>
                    Bus2_Sel <= "10";
                    MAR_Load <= '1';
                when S_A_yaz_7 =>
                    Bus1_Sel <= "01";
                    write <= '1';
                ------------------
                when S_AtopB_4 =>
                    Bus1_Sel <= "01";
                    ALU_Sel  <= "000";
                    Bus2_Sel <= "00";
                    A_Load   <= '1';
                    CCR_Load <= '1';
                ------------------
                when S_ATLA_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_ATLA_5 =>
                when S_ATLA_6 =>
                    Bus2_Sel <= "10";
                    PC_Load <= '1';
                ------------------
                when S_ATLA_SIFIR_4 =>
                    Bus1_Sel <= "00";
                    Bus2_Sel <= "01";
                    MAR_Load <= '1';
                when S_ATLA_SIFIR_5 =>
                when S_ATLA_SIFIR_6 =>
                    Bus2_Sel <= "10";
                    PC_Load <= '1';
                when S_ATLA_SIFIR_7 =>
                    PC_Inc <= '1';
                     
            end case;
    end process;
end Behavioral;









