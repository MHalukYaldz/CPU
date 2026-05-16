library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory_System is
    Port (   Clk            : in std_logic;
             Reset          : in std_logic;
             address        : in  std_logic_vector(7 downto 0);
             write          : in std_logic;
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
end Memory_System;

architecture Behavioral of Memory_System is

component Program_Memory is
port( address : in std_logic_vector(7 downto 0);  
      Clk        : in std_logic;                     
      data_out: out std_logic_vector(7 downto 0));
end component;

component Data_Memory is
port( Clk       : in std_logic;
      address   : in std_logic_vector(7 downto 0);
      data_in   : in std_logic_vector(7 downto 0);
      write     : in std_logic;
      data_out  : out std_logic_vector(7 downto 0));
end component;

component Output_ports is
port( Clk           : in std_logic;
      Reset         : in std_logic;
      address       : in std_logic_vector(7 downto 0);
      data_in       : in std_logic_vector(7 downto 0);
      write         : in std_logic;
      
      port_out_0    : out std_logic_vector(7 downto 0);     --E0
      port_out_1    : out std_logic_vector(7 downto 0);     --E1 
      port_out_2    : out std_logic_vector(7 downto 0);     --E2 
      port_out_3    : out std_logic_vector(7 downto 0);     --E3 
      port_out_4    : out std_logic_vector(7 downto 0);     --E4 
      port_out_5    : out std_logic_vector(7 downto 0);     --E5 
      port_out_6    : out std_logic_vector(7 downto 0);     --E6 
      port_out_7    : out std_logic_vector(7 downto 0);     --E7 
      port_out_8    : out std_logic_vector(7 downto 0);     --E8 
      port_out_9    : out std_logic_vector(7 downto 0);     --E9
      port_out_10   : out std_logic_vector(7 downto 0);     --EA
      port_out_11   : out std_logic_vector(7 downto 0);     --EB
      port_out_12   : out std_logic_vector(7 downto 0);     --EC
      port_out_13   : out std_logic_vector(7 downto 0);     --ED
      port_out_14   : out std_logic_vector(7 downto 0);     --EE
      port_out_15   : out std_logic_vector(7 downto 0));    --EF
end component;

signal program_memory_out : std_logic_vector(7 downto 0);
signal data_memory_out : std_logic_vector(7 downto 0);

begin

Program_memory_inst : Program_Memory port map(
    Clk         => Clk,
    address     => address,
    data_out    => program_memory_out);
    
Data_memory_inst : Data_Memory port map (
    Clk         => Clk,
    address     => address,
    data_in     => data_in,
    write       => write,
    data_out    => data_memory_out );
    
Output_ports_inst : Output_Ports port map (
    Clk         => Clk,
    Reset       => Reset,
    address     => address,
    data_in     => data_in,
    write       => write,
    port_out_0  => port_out_0 ,
    port_out_1  => port_out_1 ,
    port_out_2  => port_out_2 ,
    port_out_3  => port_out_3 ,
    port_out_4  => port_out_4 ,
    port_out_5  => port_out_5 ,
    port_out_6  => port_out_6 ,
    port_out_7  => port_out_7 ,
    port_out_8  => port_out_8 ,
    port_out_9  => port_out_9 ,
    port_out_10 => port_out_10,
    port_out_11 => port_out_11,
    port_out_12 => port_out_12,
    port_out_13 => port_out_13,
    port_out_14 => port_out_14,
    port_out_15 => port_out_15 );
    
--MULTIPLEXER
    process (address,program_memory_out,data_memory_out,
             port_in_0,port_in_1,port_in_2,port_in_3,port_in_4,port_in_5,
             port_in_6,port_in_7,port_in_8,port_in_9,port_in_10,port_in_11,
             port_in_12,port_in_13,port_in_14,port_in_15)
             
        begin
            if(address >= x"00" AND address <= x"7F") then
                data_out <= program_memory_out;
            elsif(address >= x"80" AND address <= x"DF") then
                data_out <= data_memory_out;
            
            elsif(address = x"F0") then 
                data_out <= port_in_0;
            elsif(address = x"F1") then
                data_out <= port_in_1; 
            elsif(address = x"F2") then
                data_out <= port_in_2; 
            elsif(address = x"F3") then
                data_out <= port_in_3; 
            elsif(address = x"F4") then
                data_out <= port_in_4; 
            elsif(address = x"F5") then
                data_out <= port_in_5; 
            elsif(address = x"F6") then
                data_out <= port_in_6;             
            elsif(address = x"F7") then
                data_out <= port_in_7;             
            elsif(address = x"F8") then
                data_out <= port_in_8;             
            elsif(address = x"F9") then
                data_out <= port_in_9;             
            elsif(address = x"FA") then
                data_out <= port_in_10; 
            elsif(address = x"FB") then
                data_out <= port_in_11;             
            elsif(address = x"FC") then
                data_out <= port_in_12;             
            elsif(address = x"FD") then
                data_out <= port_in_13;             
            elsif(address = x"FE") then
                data_out <= port_in_14;             
            elsif(address = x"FF") then
                data_out <= port_in_15;
            
            else
                data_out <= x"00"; 
            
            end if;
    end process; 
                 
end Behavioral;  

