library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_m9_pp is
end tb_m9_pp;

architecture Behavioral of tb_m9_pp is

signal l_clk   : std_logic := '0';
signal l_reset : std_logic := '0';
signal l_a_in  : std_logic_vector (3 downto 0) := "0000";
signal l_b_in  : std_logic_vector (3 downto 0) := "0000";
signal l_y_in  : std_logic_vector (3 downto 0) := "0000";
signal l_a_out : std_logic_vector (3 downto 0);
signal l_b_out : std_logic_vector (3 downto 0);
signal l_y_out : std_logic_vector (3 downto 0);

begin

M9_PP: entity work.m9_pp(Behavioral)
generic map(width_opa_in   => 4,
            width_opb_in   => 4,
            width_prod_in  => 4,
            width_opa_out  => 4,
            width_opb_out  => 4,
            width_prod_out => 4)
port map(clk => l_clk,
         reset => l_reset,
         a_in  => l_a_in,
         b_in  => l_b_in,
         y_in  => l_y_in,
         a_out => l_a_out,
         b_out => l_b_out,
         y_out => l_y_out);
         
l_clk   <= not l_clk after 10 ns;
l_reset <=  '1', '0' after 01 ns;

l_a_in <= "0000" after  22 ns,  "0001" after  42 ns, "1110" after  52 ns, "1111" after  62 ns,
          "0000" after  82 ns,  "0001" after 102 ns, "1110" after 122 ns, "1111" after 142 ns,
          "0000" after 162 ns,  "0001" after 182 ns, "1110" after 202 ns, "1111" after 222 ns;
l_b_in <= "0000" after  22 ns,  "0000" after  42 ns, "0000" after  52 ns, "0000" after  62 ns,
          "0000" after  82 ns,  "0001" after 102 ns, "1110" after 122 ns, "1111" after 142 ns,
          "0000" after 162 ns,  "0001" after 182 ns, "1110" after 202 ns, "1111" after 222 ns;
l_y_in <= "0000" after  22 ns,  "0000" after  42 ns, "0000" after  52 ns, "0000" after  62 ns,
          "0000" after  82 ns,  "0001" after 102 ns, "1110" after 122 ns, "1111" after 142 ns,
          "0000" after 162 ns,  "0001" after 182 ns, "1110" after 202 ns, "1111" after 222 ns;

end Behavioral;

