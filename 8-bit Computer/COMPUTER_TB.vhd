library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COMPUTER_TB is
----  Port ( );
end COMPUTER_TB;

architecture Behavioral of COMPUTER_TB is

    constant CLK_PERIOD : time := 10 ns;

    signal Clk   : std_logic := '0';
    signal Reset : std_logic := '1';

    signal port_in_0  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_1  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_2  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_3  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_4  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_5  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_6  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_7  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_8  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_9  : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_10 : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_11 : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_12 : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_13 : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_14 : std_logic_vector(7 downto 0) := (others => '0');
    signal port_in_15 : std_logic_vector(7 downto 0) := (others => '0');

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

begin

    --------------------------------------------------------------------
    -- Clock generation
    --------------------------------------------------------------------
    Clk <= not Clk after CLK_PERIOD / 2;


    --------------------------------------------------------------------
    -- DUT: Device Under Test
    --------------------------------------------------------------------
    DUT: entity work.COMPUTER
        port map (
            Clk        => Clk,
            Reset      => Reset,

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

            port_out_0  => port_out_0,
            port_out_1  => port_out_1,
            port_out_2  => port_out_2,
            port_out_3  => port_out_3,
            port_out_4  => port_out_4,
            port_out_5  => port_out_5,
            port_out_6  => port_out_6,
            port_out_7  => port_out_7,
            port_out_8  => port_out_8,
            port_out_9  => port_out_9,
            port_out_10 => port_out_10,
            port_out_11 => port_out_11,
            port_out_12 => port_out_12,
            port_out_13 => port_out_13,
            port_out_14 => port_out_14,
            port_out_15 => port_out_15
        );


    --------------------------------------------------------------------
    -- Stimulus and checking
    --------------------------------------------------------------------
    stim_proc: process
    begin

        ----------------------------------------------------------------
        -- 1) Reset aktif
        ----------------------------------------------------------------
        Reset <= '1';

        for i in 0 to 4 loop
            wait until rising_edge(Clk);
        end loop;


        ----------------------------------------------------------------
        -- 2) Reset býrakýlýyor
        ----------------------------------------------------------------
        Reset <= '0';


        ----------------------------------------------------------------
        -- 3) Programýn çalýþmasý için bekle
        ----------------------------------------------------------------
        for i in 0 to 150 loop
            wait until rising_edge(Clk);
        end loop;

        wait for 1 ns;


        ----------------------------------------------------------------
        -- 4) Sonucu kontrol et
        ----------------------------------------------------------------
        assert port_out_0 = x"67"
        report "HATA: port_out_0 beklenen x67 degerine esit degil."
        severity error;

        report "TEST BASARILI: port_out_0 = x67";


        ----------------------------------------------------------------
        -- 5) Simulasyonu burada beklet
        ----------------------------------------------------------------
        wait;

    end process;

end Behavioral;