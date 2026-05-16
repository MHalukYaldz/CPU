library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Data_Memory is
    Port (Clk       : in std_logic;
          address   : in std_logic_vector(7 downto 0);
          data_in   : in std_logic_vector(7 downto 0);
          write     : in std_logic;
          data_out  : out std_logic_vector(7 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is

type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);

signal RW     : rw_type := (others => x"00") ;
signal ENABLE : std_logic;

begin

L_ENABLE : process(address)
    begin
        if(address >= x"80" AND address <= x"DF") then
            ENABLE <= '1';
        else
            ENABLE <= '0';
        end if;
end process;
        
MEMORY : process(Clk)
    begin
        if(rising_edge(Clk)) then
            if(ENABLE='1' AND write='1') then
                RW(to_integer(unsigned(address))) <= data_in;
            elsif(ENABLE='1' AND write='0') then
                data_out <= RW(to_integer(unsigned(address)));
            end if;
        end if;
end process;
end Behavioral;














