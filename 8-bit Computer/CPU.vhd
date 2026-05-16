library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
    Port ( Clk          : in std_logic;
           Reset        : in std_logic;
           from_memory  : in std_logic_vector(7 downto 0);
           
           write        : out std_logic;
           to_memory    : out std_logic_vector(7 downto 0);
           address      : out std_logic_vector(7 downto 0)
    );
end CPU;

architecture Behavioral of CPU is

    signal IR_Load      : std_logic;
    signal MAR_Load     : std_logic;
    signal PC_Load      : std_logic;
    signal PC_Inc       : std_logic;
    signal A_Load       : std_logic;
    signal B_Load       : std_logic;
    signal CCR_Load     : std_logic;
    signal IR           : std_logic_vector(7 downto 0);
    signal CCR_Result   : std_logic_vector(3 downto 0);
    signal ALU_Sel      : std_logic_vector(2 downto 0);
    signal Bus1_Sel     : std_logic_vector(1 downto 0);
    signal Bus2_Sel     : std_logic_vector(1 downto 0);

    component CONTROL_UNIT is
    port(Clk           : in std_logic;                    
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
end component;
    
    component DATA_PATH is
    port(Clk           : in std_logic;                    
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
end component;
    
begin

--PORT MAP
CONTROL_UNIT_Inst: CONTROL_UNIT port map
(
    Clk         =>  Clk,
    Reset       =>  Reset,
    IR          =>  IR,
    CCR_Result  =>  CCR_Result,
    IR_Load     =>  IR_Load,
    MAR_Load    =>  MAR_Load,
    PC_Load     =>  PC_Load,
    PC_Inc      =>  PC_Inc,
    A_Load      =>  A_Load,
    B_Load      =>  B_Load,
    ALU_Sel     =>  ALU_Sel,
    CCR_Load    =>  CCR_Load,
    Bus1_Sel    =>  Bus1_Sel,
    Bus2_Sel    =>  Bus2_Sel,
    write       =>  write 
);

DATA_PATH_Inst: DATA_PATH port map
(
    Clk         =>  Clk,
    Reset       =>  Reset,
    IR_Load     =>  IR_Load,
    MAR_Load    =>  MAR_Load,
    PC_Load     =>  PC_Load,
    PC_Inc      =>  PC_Inc,
    A_Load      =>  A_Load,
    B_Load      =>  B_Load,
    CCR_Load    =>  CCR_Load,
    ALU_Sel     =>  ALU_Sel,
    Bus1_Sel    =>  Bus1_Sel,
    Bus2_Sel    =>  Bus2_Sel,
    from_memory =>  from_memory,
    IR          =>  IR,
    to_memory   =>  to_memory,
    address     =>  address,
    CCR_Result  =>  CCR_Result
);
end Behavioral;



