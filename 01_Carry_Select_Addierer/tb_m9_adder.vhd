library IEEE; use IEEE.STD_LOGIC_1164.ALL;
entity tb_m9_adder is
    generic (w : positive := 10);
end tb_m9_adder;
architecture Behavioral of tb_m9_adder is
signal l_cin  : STD_LOGIC := '0';
signal l_a    : STD_LOGIC_VECTOR (w-1 downto 0) := (others => '0');
signal l_b    : STD_LOGIC_VECTOR (w-1 downto 0) := (others => '0');
signal l_s    : STD_LOGIC_VECTOR (w-1 downto 0);
signal l_cout : STD_LOGIC;
begin
CS_Adder: entity work.m9_adder(Behavioral)
    generic map(width => w)
    port map(cin => l_cin, a => l_a, b => l_b,
                    s => l_s, cout => l_cout);
    l_a <= "0000000001" after  0 ns, "0000000010" after  1 ns,
           "0000000011" after  2 ns, "1111111111" after  4 ns;
    l_b <= "0000000001" after  0 ns, "0000000010" after  8 ns,
           "0000000011" after 16 ns, "1111111111" after 24 ns;
end Behavioral;
