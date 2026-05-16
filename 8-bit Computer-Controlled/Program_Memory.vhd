library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Program_Memory is
    Port (address : in std_logic_vector(7 downto 0);
          Clk     : in std_logic;
          data_out: out std_logic_vector(7 downto 0));
end Program_Memory;

architecture Behavioral of Program_Memory is

constant    c_A_yukle_sbt        : std_logic_vector(7 downto 0) := x"86";        --A kaydýna operand olarak verilen deðeri yazar.
constant    c_A_yukle            : std_logic_vector(7 downto 0) := x"87";        --Operand olarak verilen bellek adresindeki veriyi A kaydýna yazar.
constant    c_B_yukle_sbt        : std_logic_vector(7 downto 0) := x"88";        --B kaydýna operand olarak verilen deðeri yazar.
constant    c_B_yukle            : std_logic_vector(7 downto 0) := x"89";        --Operand olarak verilen bellek adresindeki veriyi B kaydýna yazar.
constant    c_A_yaz              : std_logic_vector(7 downto 0) := x"96";        --A kaydýndaki veriyi operand olarak verilen bellek adresine yazar.
constant    c_B_yaz              : std_logic_vector(7 downto 0) := x"97";        --B kaydýndaki veriyi operand olarak verilen bellek adresine yazar.

constant    c_AtopB              : std_logic_vector(7 downto 0) := x"42";        --A ve B kayýtlarýný toplar, sonucu A kaydýna yazar.
constant    c_AcikB              : std_logic_vector(7 downto 0) := x"43";        --A kaydýndan B kaydýný çýkarýr, sonucu A kaydýna yazar.
constant    c_AandB              : std_logic_vector(7 downto 0) := x"44";        --A ve B kayýtlarý arasýnda bit düzeyinde AND iþlemi yapar, sonucu A kaydýna yazar.
constant 	c_AorB               : std_logic_vector(7 downto 0) := x"45";        --: A ve B kayýtlarý arasýnda bit düzeyinde OR iþlemi yapar, sonucu A kaydýna yazar.
constant 	c_Aartir             : std_logic_vector(7 downto 0) := x"46";        --: A kaydýndaki deðeri 1 artýrýr.
constant 	c_Bartir             : std_logic_vector(7 downto 0) := x"47";        --: B kaydýndaki deðeri 1 artýrýr.
constant 	c_Aazalt             : std_logic_vector(7 downto 0) := x"48";        --: A kaydýndaki deðeri 1 azaltýr.
constant 	c_Bazalt             : std_logic_vector(7 downto 0) := x"49";        --: B kaydýndaki deðeri 1 azaltýr.
                                                                                 
constant    c_ATLA               : std_logic_vector(7 downto 0) := x"20";        --Koþulsuz olarak operand olarak verilen adrese dallanýr.
constant    c_ATLA_NEG           : std_logic_vector(7 downto 0) := x"21";        --N bayraðý 1 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_POZ           : std_logic_vector(7 downto 0) := x"22";        --N bayraðý 0 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_SIFIR         : std_logic_vector(7 downto 0) := x"23";        --Z bayraðý 1 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_SIFIR_DEGIL   : std_logic_vector(7 downto 0) := x"24";        --Z bayraðý 0 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_OVERFLOW      : std_logic_vector(7 downto 0) := x"25";        --V bayraðý 1 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_OVERFLOW_YOK  : std_logic_vector(7 downto 0) := x"26";        --V bayraðý 0 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_TASMA         : std_logic_vector(7 downto 0) := x"27";        --C bayraðý 1 ise operand olarak verilen adrese dallanýr.
constant    c_ATLA_TASMA_YOK     : std_logic_vector(7 downto 0) := x"28";        --C bayraðý 0 ise operand olarak verilen adrese dallanýr.

signal s_ENABLE : std_logic;

type ROM_type is array (0 to 127) of std_logic_vector(7 downto 0);

constant ROM: ROM_type := (0 => c_A_yukle,
                           1 => x"F0",
                           2 => c_B_yukle,
                           3 => x"F1",
                           4 => c_AtopB,
                           5 => c_A_yaz,
                           6 => x"E0",
                           7 => c_ATLA,
                           8 => x"00",
                           others => x"00");
begin

    ENABLE :process(address)
        begin  
            if(address >= x"00" AND address <= x"7F") then      -- 7F = 127 => 0 to 127
                s_ENABLE <= '1';
            else
                s_ENABLE <= '0';
            end if;
    end process;
    
    MEMORY :process(Clk)
        begin
            if(rising_edge(Clk)) then
                if(s_ENABLE='1') then
                    data_out <= ROM(to_integer(unsigned(address)));
                end if;
            end if;
    end process;
end Behavioral;
