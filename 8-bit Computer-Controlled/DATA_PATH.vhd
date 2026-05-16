library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DATA_PATH is
    Port (Clk           : in std_logic;
          Reset         : in std_logic;
          IR_Load       : in std_logic;
          MAR_Load      : in std_logic;
          PC_Load       : in std_logic;
          PC_Inc        : in std_logic;
          A_Load        : in std_logic;
          B_Load        : in std_logic;
          CCR_Load      : in std_logic;
          ALU_Sel       : in std_logic_vector(2 downto 0);
          Bus1_Sel      : in std_logic_vector(1 downto 0);
          Bus2_Sel      : in std_logic_vector(1 downto 0);
          from_memory   : in std_logic_vector(7 downto 0);
          
          IR            : out std_logic_vector(7 downto 0);
          to_memory     : out std_logic_vector(7 downto 0);
          address       : out std_logic_vector(7 downto 0);
          CCR_Result    : out std_logic_vector(3 downto 0)
          );
end DATA_PATH;

architecture Behavioral of DATA_PATH is

component ALU is
    port(A             : in std_logic_vector(7 downto 0); 
         B             : in std_logic_vector(7 downto 0); 
         ALU_Sel       : in std_logic_vector(2 downto 0); 
         NZVC          : out std_logic_vector(3 downto 0);
         ALU_Result    : out std_logic_vector(7 downto 0)
         );
end component;

--signal IR_reg   : std_logic_vector(7 downto 0);
signal MAR      : std_logic_vector(7 downto 0);
signal PC_uns   : std_logic_vector(7 downto 0);
signal PC       : std_logic_vector(7 downto 0);
signal A        : std_logic_vector(7 downto 0);
signal B_reg    : std_logic_vector(7 downto 0);
signal Bus1     : std_logic_vector(7 downto 0);
signal Bus2     : std_logic_vector(7 downto 0);
signal NZVC_in  : std_logic_vector(3 downto 0);
signal ALU_Result: std_logic_vector(7 downto 0);
begin
--Bus1<= PC, A ve B kayýtçýlarýnýn çýkýþ         
--Bus2<= IR, MAR, PC, A ve B kayýtçýlarýnýn giriþ
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------INSTRUCTION REGISTER----------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Instruction_Register : process(Clk, Reset)      --BUS2 ? IR register’ýnýn giriþidir.                                                                 
    begin                                       --IR_reg ? register’ýn içinde saklanan içsel deðerdir.                                               
        if(Reset = '1') then                    --IR ? bu içsel deðerin dýþarýya verilen çýkýþýdýr.                                                  
            IR <= x"00";                         --IR_Load ? BUS2’deki deðerin IR register’a yüklenip yüklenmeyeceðini belirleyen enable sinyalidir.  
        elsif(rising_edge(Clk)) then                                                                                                                 
            if(IR_Load = '1') then                                                                                                                   
                IR <= Bus2;                                                                                                                          
            end if;                                                                                                                                  
        end if;                                                                                                                                      
end process;


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------MEMORY ADDRESS REGISTER-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Memory_Address_Register : process(Reset, Clk)
    begin
        if(Reset = '1') then
            MAR <= x"00";
        elsif(rising_edge(Clk)) then
            if(MAR_Load = '1') then
                MAR <= Bus2;
            end if;
        end if;   
end process;

address <= MAR;


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------PROGRAM COUNTER---------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Program_Counter : process(Reset, Clk)                                                                                                    
    begin                                                                                                                                        
        if(Reset = '1') then                                                                                                                     
            PC <= x"00";                                                                                                                         
        elsif(rising_edge(Clk)) then                                                                                                             
            if(PC_Load = '1') then                                                                                                              
                PC <= Bus2;
            elsif(PC_Inc = '1') then
                PC <= PC + x"01";
            end if;                                                                                                                              
        end if;                                                                                                                                  
end process;                                                                                                                                     

                                                                                                                                                 
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------A REGISTER--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
A_Register : process(Reset, Clk)                                                                                                            
    begin                                                                                                                                        
        if(Reset = '1') then                                                                                                                     
            A <= x"00";                                                                                                                          
        elsif(rising_edge(Clk)) then                                                                                                             
            if(A_Load = '1') then                                                                                                               
                A <= Bus2;                                                                                                                
            end if;                                                                                                                              
        end if;                                                                                                                                  
end process;                                                                                                                                     


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------B REGISTER--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
B_Register : process(Reset, Clk)                                                                                                                 
    begin                                                                                                                                        
        if(Reset = '1') then                                                                                                                     
            B_reg <= x"00";                                                                                                                           
        elsif(rising_edge(Clk)) then                                                                                                             
            if(B_Load = '1') then                                                                                                                
                B_reg <= Bus2;                                                                                                                       
            end if;                                                                                                                              
        end if;                                                                                                                                  
end process;                                                                                                                                     


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------CONDITION CODE REGISTER-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Condition_Code_Register : process(Reset, Clk)
    begin
        if(Reset = '1') then
            CCR_Result <= (others => '0');
        elsif(rising_edge(Clk)) then                                                                                                             
            if(CCR_Load = '1') then                                                                                                               
                CCR_Result <= NZVC_in;
            end if;                                                                                                                              
        end if;                                                                                                                                  
end process;                                                                                                                                     

ALU_inst: ALU port map 
    (A             => B_reg,
     B             => Bus1,
     ALU_Sel       => ALU_Sel,
     NZVC          => NZVC_in,
     ALU_Result    => ALU_Result
    );


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------BUS 1 MUX---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Bus1_Mux : process(Bus1_Sel, PC, A, B_reg)
    begin
        case(Bus1_Sel) is
            when "00" => Bus1 <= PC;
            when "01" => Bus1 <= A;
            when "10" => Bus1 <= B_reg;
            when others => Bus1 <= x"00";
        end case;
end process;


-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------BUS 2 MUX---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Bus2_Mux : process(Bus2_Sel, ALU_Result, Bus1, from_memory  )
    begin
        case(Bus2_Sel) is
            when "00" => Bus2 <= ALU_Result;
            when "01" => Bus2 <= Bus1;
            when "10" => Bus2 <= from_memory;
            when others => Bus2 <= x"00";
        end case;
end process;

to_memory <= Bus1;
end Behavioral;






