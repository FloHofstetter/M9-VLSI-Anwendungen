library IEEE; use IEEE.STD_LOGIC_1164.ALL;
entity m9_adder is
    generic (width : positive := 32);
    port (cin  : in  std_logic; 
          a, b : in  std_logic_vector (width - 1 downto 0);
          s    : out std_logic_vector (width - 1 downto 0);
          cout : out std_logic);
end m9_adder;
architecture Behavioral of m9_adder is
signal c : std_logic_vector(width - 1 downto 0);
begin
gen : for i in 0 to width-1 generate
    genlsb : if (i = 0) generate
        CSA_L: entity work.m_csa(Behavioral)
        port map(a => a(0), b => b(0), cin => '0', s => s(0), cout => c(0));
    end generate;
    genmid : if (0 < i) generate
        -- CSA 1 to width-1
        CSA_C: entity work.m_csa(Behavioral)
        port map(a => a(i), b => b(i), cin => c(i-1), s => s(i), cout => c(i));
    end generate;
end generate;
cout <= c(width-1);
end Behavioral;
