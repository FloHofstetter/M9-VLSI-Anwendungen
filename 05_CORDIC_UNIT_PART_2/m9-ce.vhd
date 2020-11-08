library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity m9_ce is
  Port (m     : in std_logic;
        sigma : in  std_logic;
        i     : in  std_logic_vector(4 downto 0);
        x_in  : in  std_logic_vector (31 downto 0);
        y_in  : in  std_logic_vector (31 downto 0);
        z_in  : in  std_logic_vector (31 downto 0);
        x_out : out std_logic_vector (31 downto 0);
        y_out : out std_logic_vector (31 downto 0);
        z_out : out std_logic_vector (31 downto 0));
end m9_ce;

architecture Behavioral of m9_ce is
  signal rShiftToRadd : std_logic_vector (31 downto 0);
  signal lShiftToLadd : std_logic_vector (31 downto 0);
begin
  M9_PP: entity work.m9_artan_rom(Behavioral)
    port map(i => i,
             d => open);

  rAddSub:
    entity work.m9_addsub32(Behavioral)
    port map(a   => x_in,
             b   => rShiftToRadd,
             ans => sigma,  -- select add/sub
             y   => x_out);

  rSHIFT: entity work.m_m9_barrel32(Behavioral)
    port map(x   => x_in,
             pos => i,
             lnr => '0',
             y   => x_out);
            
  lAddSub:
    entity work.m9_addsub32(Behavioral)
    port map(a   => lShiftToLadd,
             b   => y_in,
             ans => sigma,  -- select add/sub
             y   => y_out);
             
  lSHIFT: entity work.m_m9_barrel32(Behavioral)
    port map(x   => x_in,
             pos => i,
             lnr => '1',
             y   => lShiftToLadd);

end Behavioral;