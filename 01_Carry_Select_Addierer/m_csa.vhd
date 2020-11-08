library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity m_csa is
    Port ( a    : in  STD_LOGIC;
           b    : in  STD_LOGIC;
           cin  : in  STD_LOGIC;
           s    : out STD_LOGIC;
           cout : out STD_LOGIC);
end m_csa;

architecture Behavioral of m_csa is
signal s_i   : STD_LOGIC_VECTOR (1 downto 0);
signal c_out : STD_LOGIC_VECTOR (1 downto 0);
begin

VaCarry: entity work.m9_fulladd(behaviour)
port map(a => a, b => b, cin => '0', sum => s_i(0), cout => c_out(0));
VaNoCarry: entity work.m9_fulladd(behaviour)
port map(a => a, b => b, cin => '1', sum => s_i(1), cout => c_out(1));

cout <= c_out(0) when cin = '0' else
        c_out(1) when cin = '1';
    
s <= s_i(0) when cin = '0' else
     s_i(1) when cin = '1';

end Behavioral;
