library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_m9_addsub32 is
end tb_m9_addsub32;

architecture Behavioral of tb_m9_addsub32 is
  signal l_a   : std_logic_vector(31 downto 0) := x"00_00_00_00";
  signal l_b   : std_logic_vector(31 downto 0) := x"00_00_00_00";
  signal l_ans : std_logic := '0';
  signal l_y   : std_logic_vector(31 downto 0);
begin

M9_Addsub32:
    entity work.m9_addsub32(Behavioral)
    port map(a => l_a,
             b => l_b,
             ans => l_ans,
             y => l_y);
    
    l_a <= x"ff_ff_ff_ff" after 10 ns, x"00_00_00_00" after 20 ns, 
           x"00_00_00_ff" after 30 ns;
    l_b <= x"ff_ff_ff_ff" after 10 ns, x"00_00_00_ef" after 20 ns,
           x"00_00_00_ff" after 30 ns;
    l_ans <= not l_ans after 5 ns;
end Behavioral;
