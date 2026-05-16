library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_BASYS_3 is
    Port (Clk100MHz : in std_logic;
          Reset     : in std_logic;
          SW        : in std_logic_vector(15 downto 0);
          LED       : out std_logic_vector(9 downto 0)
    );
end TOP_BASYS_3;

architecture Behavioral of TOP_BASYS_3 is

    signal port_out_0  : std_logic_vector(7 downto 0);
    signal port_out_1  : std_logic_vector(7 downto 0);
    signal port_out_2  : std_logic_vector(7 downto 0);
    signal port_out_3  : std_logic_vector(7 downto 0);
    signal port_out_4  : std_logic_vector(7 downto 0);
    signal port_out_5  : std_logic_vector(7 downto 0);
    signal port_out_6  : std_logic_vector(7 downto 0);
    signal port_out_7  : std_logic_vector(7 downto 0);
    signal port_out_8  : std_logic_vector(7 downto 0);
    signal port_out_9  : std_logic_vector(7 downto 0);
    signal port_out_10 : std_logic_vector(7 downto 0);
    signal port_out_11 : std_logic_vector(7 downto 0);
    signal port_out_12 : std_logic_vector(7 downto 0);
    signal port_out_13 : std_logic_vector(7 downto 0);
    signal port_out_14 : std_logic_vector(7 downto 0);
    signal port_out_15 : std_logic_vector(7 downto 0);
    
    signal CCR_Out     : std_logic_vector(3 downto 0);

begin

    U_COMPUTER : entity work.COMPUTER
        port map(
                 Clk => Clk100MHz,
                 Reset => Reset,
                 
                 port_in_0  => SW(7 downto 0),
                 port_in_1  => SW(15 downto 8),
                 port_in_2  => x"00",
                 port_in_3  => x"00",
                 port_in_4  => x"00",
                 port_in_5  => x"00",
                 port_in_6  => x"00",
                 port_in_7  => x"00",
                 port_in_8  => x"00",
                 port_in_9  => x"00",
                 port_in_10 => x"00",
                 port_in_11 => x"00",
                 port_in_12 => x"00",
                 port_in_13 => x"00",
                 port_in_14 => x"00",
                 port_in_15 => x"00",
                 
                 CCR_Out    => CCR_Out,
                 
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
                 port_out_15 => port_out_15
                 );

            LED(7 downto 0) <= port_out_0;
            LED(8) <= CCR_Out(0);           --CARRY
            LED(9) <= CCR_Out(1);           --Overflow

end Behavioral;
