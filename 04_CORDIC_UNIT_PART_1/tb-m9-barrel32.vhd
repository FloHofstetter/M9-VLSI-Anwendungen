library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_m9_barrel32 is
end tb_m9_barrel32;

architecture Behavioral of tb_m9_barrel32 is
signal l_x   : std_logic_vector(31 downto 0) := x"00000000";
signal l_pos : std_logic_vector( 4 downto 0) :=  "00000";
signal l_lnr : std_logic                     :='0';
signal l_y   : std_logic_vector(31 downto 0);
begin

DUT: entity work.m_m9_barrel32(Behavioral)
port map(x   => l_x,
         pos => l_pos,
         lnr => l_lnr,
         y   => l_y);
         
    l_x <= "00000000000000001111111111111111", x"ff_ff_ff_ff" after 5 ns;
    l_pos <=    "00000" after  10 ns, "00001" after  20 ns, "00010" after  30 ns,
                "00011" after  40 ns, "00100" after  50 ns, "00101" after  60 ns, 
                "00110" after  70 ns, "00111" after  80 ns, "01000" after  90 ns, 
                "01001" after 100 ns, "01010" after 110 ns, "01011" after 120 ns, 
                "01100" after 130 ns, "01101" after 140 ns, "01110" after 150 ns, 
                "01111" after 160 ns, "10000" after 170 ns, "10001" after 180 ns, 
                "10010" after 190 ns, "10011" after 200 ns, "10100" after 210 ns, 
                "10101" after 220 ns, "10110" after 230 ns, "10111" after 240 ns, 
                "11000" after 250 ns, "11001" after 260 ns, "11010" after 270 ns, 
                "11011" after 280 ns, "11100" after 290 ns, "11101" after 300 ns, 
                "11110" after 310 ns, "11111" after 320 ns;
    l_lnr <= '1';
end Behavioral;
