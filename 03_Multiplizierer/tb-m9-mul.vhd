library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_m9_mul is
end tb_m9_mul;

architecture Behavioral of tb_m9_mul is
signal l_width : positive := 4;
signal l_clk   : std_logic := '0';
signal l_reset : std_logic := '0';
signal l_a     : std_logic_vector (l_width -1 downto 0) := (others => '0');
signal l_b     : std_logic_vector(l_width - 1 downto 0) := (others => '0');
signal l_y     : std_logic_vector((2 * l_width) - 1 downto 0);

begin

M9_MUL : entity work.m_m9_mul(Behavioral)
generic map (width  => l_width)
port map (clk     => l_clk,
          reset => l_reset,
          a     => l_a,
          b     => l_b,
          y     => l_y);

l_clk   <= not l_clk after 10 ns;
l_reset <=  '1', '0' after 01 ns;

l_a <= "0000", "0011" after 220 ns, "0000" after 420 ns, "1111" after 620 ns;
l_b <= "0000", "0011" after 220 ns, "0000" after 420 ns, "1111" after 620 ns;
end Behavioral;

