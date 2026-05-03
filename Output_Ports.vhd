library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Output_ports is
    Port (Clk           : in std_logic;
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
end Output_ports;

architecture Behavioral of Output_ports is

begin
    process(Reset, Clk)
        begin
            if(Reset = '1') then
                port_out_0  <= "0";
                port_out_1  <= "0"; 
                port_out_2  <= "0";
                port_out_3  <= "0";
                port_out_4  <= "0";
                port_out_5  <= "0";
                port_out_6  <= "0";
                port_out_7  <= "0";
                port_out_8  <= "0";
                port_out_9  <= "0";
                port_out_10 <= "0";
                port_out_11 <= "0";
                port_out_12 <= "0";
                port_out_13 <= "0";
                port_out_14 <= "0";
                port_out_15 <= "0";
            elsif (rising_edge(Clk)) then
                if(write = '1') then
                    case (address) is
                        when x"E0" => port_out_0  <= data_in;
                        when x"E1" => port_out_1  <= data_in;
                        when x"E2" => port_out_2  <= data_in;
                        when x"E3" => port_out_3  <= data_in;
                        when x"E4" => port_out_4  <= data_in;
                        when x"E5" => port_out_5  <= data_in;
                        when x"E6" => port_out_6  <= data_in;
                        when x"E7" => port_out_7  <= data_in;
                        when x"E8" => port_out_8  <= data_in;
                        when x"E9" => port_out_9  <= data_in;
                        when x"EA" => port_out_10 <= data_in;
                        when x"EB" => port_out_11 <= data_in;
                        when x"EC" => port_out_12 <= data_in;
                        when x"ED" => port_out_13 <= data_in;
                        when x"EE" => port_out_14 <= data_in;
                        when x"EF" => port_out_15 <= data_in;
                        when others =>
                            port_out_0  <= (others => '0');
                            port_out_1  <= (others => '0');
                            port_out_2  <= (others => '0');
                            port_out_3  <= (others => '0');
                            port_out_4  <= (others => '0');
                            port_out_5  <= (others => '0');
                            port_out_6  <= (others => '0');
                            port_out_7  <= (others => '0');
                            port_out_8  <= (others => '0');
                            port_out_9  <= (others => '0');
                            port_out_10 <= (others => '0');
                            port_out_11 <= (others => '0');
                            port_out_12 <= (others => '0');
                            port_out_13 <= (others => '0');
                            port_out_14 <= (others => '0');
                            port_out_15 <= (others => '0');
                    end case;
                end if;
            end if;
    end process;                                       
end Behavioral;    