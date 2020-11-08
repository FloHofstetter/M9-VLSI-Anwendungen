library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity m9_addsub32 is
port (a, b : in  std_logic_vector(31 downto 0);
      ans  : in  std_logic;
      y    : out std_logic_vector(31 downto 0));
end m9_addsub32;
    
architecture Behavioral of m9_addsub32 is
  signal cin     : std_logic;
  signal b_tmp   : std_logic_vector(31 downto 0);
begin

  -- selcect addition or substraction
  with ans select b_tmp <=
    b      when '1',
    not(b) when others;
  cin <= not(ans);
  -- end select addition or substraction

  -- add /sub
  CS_Adder:
    entity work.m9_adder(Behavioral)
    generic map(width => 32)
    port map(cin => cin, a => a, b => b_tmp,
    s => y, cout => open);
  -- end add / sub
  
end Behavioral;
