library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_m9_artan_rom is

end tb_m9_artan_rom;

architecture Behavioral of tb_m9_artan_rom is
   signal l_i : std_logic_vector( 4 downto 0) := "00000";
   signal l_d : std_logic_vector(31 downto 0);
begin

  M9_PP: entity work.m9_artan_rom(Behavioral)
    port map(i => l_i,
             d => l_d);
  l_i <= "00001" after 10 ns,
         "00010" after 20 ns,
         "00011" after 30 ns,
         "00100" after 40 ns,
         "00101" after 50 ns,
         "00110" after 60 ns,
         "00111" after 70 ns,
         "01000" after 80 ns,
         "11111" after 90 ns;
end Behavioral;
