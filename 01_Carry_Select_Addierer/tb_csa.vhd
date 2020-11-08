library IEEE; use IEEE.STD_LOGIC_1164.ALL;
entity tb_csa is
end tb_csa;
architecture Behavioral of tb_csa is
signal l_a    : STD_LOGIC := '0';
signal l_b    : STD_LOGIC := '0';
signal l_cin  : STD_LOGIC := '0';
signal l_s    : STD_LOGIC;
signal l_cout : STD_LOGIC; 
begin
CSA: entity work.m_csa(Behavioral)
    port map(a    => l_a,
             b    => l_b,
             cin  => l_cin,
             s    => l_s,
             cout => l_cout);
l_a   <= not l_a   after 10 ns;
l_b   <= not l_b   after 20 ns;
l_cin <= not l_cin after 40 ns;
end Behavioral;
