library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_m9_cordic is
end t_m9_cordic;

architecture Behavioral of t_m9_cordic is
  signal l_reset     : std_logic := '0';
  signal l_clk       : std_logic := '0';
  signal l_valid_in  : std_logic := '0';
  signal l_theta     : std_logic_vector(31 downto 0) := (others => '0');
  signal l_valid_out : std_logic;
  signal l_cos_theta : std_logic_vector(31 downto 0);
  signal l_sin_theta : std_logic_vector(31 downto 0);
begin
  M9_CE_DUT: entity work.m_m9_cordic(Behavioral)
  port map(reset     => l_reset,
           clk       => l_clk,
           valid_in  => l_valid_in,
           theta     => l_theta,
           valid_out => l_valid_out,
           cos_theta => l_cos_theta,
           sin_theta => l_sin_theta);

  l_reset    <= '1', '0' after 1 ps;
  l_clk      <= not l_clk after 5 ms;
  l_theta    <= x"00_E6_66_66" after 40 ms;  -- 0.6 in 2's compliment and Q8.24
  l_valid_in <= '1' after 50 ms, '0' after 60 ms, '1' after 400 ms, '0' after 410 ms;

end Behavioral;
