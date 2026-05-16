library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COMPUTER is
    Port (Clk           : in std_logic;
          Reset         : in std_logic;
          port_in_0     : in std_logic_vector(7 downto 0);
          port_in_1     : in std_logic_vector(7 downto 0);
          port_in_2     : in std_logic_vector(7 downto 0);
          port_in_3     : in std_logic_vector(7 downto 0);
          port_in_4     : in std_logic_vector(7 downto 0);
          port_in_5     : in std_logic_vector(7 downto 0);
          port_in_6     : in std_logic_vector(7 downto 0);
          port_in_7     : in std_logic_vector(7 downto 0);
          port_in_8     : in std_logic_vector(7 downto 0);
          port_in_9     : in std_logic_vector(7 downto 0);
          port_in_10    : in std_logic_vector(7 downto 0);
          port_in_11    : in std_logic_vector(7 downto 0);
          port_in_12    : in std_logic_vector(7 downto 0);
          port_in_13    : in std_logic_vector(7 downto 0);
          port_in_14    : in std_logic_vector(7 downto 0);
          port_in_15    : in std_logic_vector(7 downto 0);
          
          CCR_Out       : out std_logic_vector(3 downto 0);
          
          port_out_0    : out std_logic_vector(7 downto 0);
          port_out_1    : out std_logic_vector(7 downto 0);
          port_out_2    : out std_logic_vector(7 downto 0);
          port_out_3    : out std_logic_vector(7 downto 0);
          port_out_4    : out std_logic_vector(7 downto 0);
          port_out_5    : out std_logic_vector(7 downto 0);
          port_out_6    : out std_logic_vector(7 downto 0);
          port_out_7    : out std_logic_vector(7 downto 0);
          port_out_8    : out std_logic_vector(7 downto 0);
          port_out_9    : out std_logic_vector(7 downto 0);
          port_out_10   : out std_logic_vector(7 downto 0);
          port_out_11   : out std_logic_vector(7 downto 0);
          port_out_12   : out std_logic_vector(7 downto 0);
          port_out_13   : out std_logic_vector(7 downto 0);
          port_out_14   : out std_logic_vector(7 downto 0);
          port_out_15   : out std_logic_vector(7 downto 0)
    );
end COMPUTER;

architecture Behavioral of COMPUTER is

    signal write        : std_logic;
    signal address      : std_logic_vector(7 downto 0);
    signal from_memory  : std_logic_vector(7 downto 0);
    signal to_memory    : std_logic_vector(7 downto 0);

    component CPU is port
    (Clk          : in std_logic;                    
     Reset        : in std_logic;                    
     from_memory  : in std_logic_vector(7 downto 0); 
     
     CCR_Out      : out std_logic_vector(3 downto 0);
     
     write        : out std_logic;                   
     to_memory    : out std_logic_vector(7 downto 0);
     address      : out std_logic_vector(7 downto 0)
    );        
    end component;

    component MEMORY_SYSTEM is port
    (Clk            : in std_logic;                   
     Reset          : in std_logic;                  
     write          : in std_logic; 
     address        : in std_logic_vector(7 downto 0);
     data_in        : in std_logic_vector(7 downto 0);
     port_in_0      : in std_logic_vector(7 downto 0);
     port_in_1      : in std_logic_vector(7 downto 0);
     port_in_2      : in std_logic_vector(7 downto 0);
     port_in_3      : in std_logic_vector(7 downto 0);
     port_in_4      : in std_logic_vector(7 downto 0);
     port_in_5      : in std_logic_vector(7 downto 0);
     port_in_6      : in std_logic_vector(7 downto 0);
     port_in_7      : in std_logic_vector(7 downto 0);
     port_in_8      : in std_logic_vector(7 downto 0);
     port_in_9      : in std_logic_vector(7 downto 0);
     port_in_10     : in std_logic_vector(7 downto 0);
     port_in_11     : in std_logic_vector(7 downto 0);
     port_in_12     : in std_logic_vector(7 downto 0);
     port_in_13     : in std_logic_vector(7 downto 0);
     port_in_14     : in std_logic_vector(7 downto 0);
     port_in_15     : in std_logic_vector(7 downto 0);
                                                      
     data_out       :out std_logic_vector(7 downto 0);
     port_out_0     :out std_logic_vector(7 downto 0);
     port_out_1     :out std_logic_vector(7 downto 0);
     port_out_2     :out std_logic_vector(7 downto 0);
     port_out_3     :out std_logic_vector(7 downto 0);
     port_out_4     :out std_logic_vector(7 downto 0);
     port_out_5     :out std_logic_vector(7 downto 0);
     port_out_6     :out std_logic_vector(7 downto 0);
     port_out_7     :out std_logic_vector(7 downto 0);
     port_out_8     :out std_logic_vector(7 downto 0);
     port_out_9     :out std_logic_vector(7 downto 0);
     port_out_10    :out std_logic_vector(7 downto 0);
     port_out_11    :out std_logic_vector(7 downto 0);
     port_out_12    :out std_logic_vector(7 downto 0);
     port_out_13    :out std_logic_vector(7 downto 0);
     port_out_14    :out std_logic_vector(7 downto 0);
     port_out_15    :out std_logic_vector(7 downto 0)
    );
    end component;
begin

    CPU_Inst: CPU port map
    (Clk            => Clk,
     Reset          => Reset,
     
     CCR_Out        => CCR_Out,
     
     from_memory    => from_memory,
     write          => write,
     to_memory      => to_memory,
     address        => address
    );

    MEMORY_SYSTEM_Inst: MEMORY_SYSTEM port map
    (Clk        => Clk,
     Reset      => Reset,
     address    => address,
     write      => write,
     data_in    => to_memory,
     port_in_0  => port_in_0,
     port_in_1  => port_in_1,
     port_in_2  => port_in_2,
     port_in_3  => port_in_3,
     port_in_4  => port_in_4,
     port_in_5  => port_in_5,
     port_in_6  => port_in_6,
     port_in_7  => port_in_7,
     port_in_8  => port_in_8,
     port_in_9  => port_in_9,
     port_in_10 => port_in_10,
     port_in_11 => port_in_11,
     port_in_12 => port_in_12,
     port_in_13 => port_in_13,
     port_in_14 => port_in_14,
     port_in_15 => port_in_15,
     data_out   => from_memory,
     port_out_0 => port_out_0,
     port_out_1 => port_out_1,
     port_out_2 => port_out_2,
     port_out_3 => port_out_3,
     port_out_4 => port_out_4,
     port_out_5 => port_out_5,
     port_out_6 => port_out_6,
     port_out_7 => port_out_7,
     port_out_8 => port_out_8,
     port_out_9 => port_out_9,
     port_out_10=> port_out_10,
     port_out_11=> port_out_11,
     port_out_12=> port_out_12,
     port_out_13=> port_out_13,
     port_out_14=> port_out_14,
     port_out_15=> port_out_15
    );
end Behavioral;
