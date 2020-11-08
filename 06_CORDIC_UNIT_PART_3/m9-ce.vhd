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
  signal romToZadder  : std_logic_vector (31 downto 0);
  signal notSigma     : std_logic;
begin
  notSigma <= not(sigma);
  
  rSHIFT:  -- Barrel Shifter
    entity work.m_m9_barrel32(Behavioral)
    port map(x   => y_in,           -- Eingang
             pos => i,              -- schieben um i Stellen
             lnr => '0',            -- rechts shift
             y   => rShiftToRadd);  -- Ausgang

  rAddSub:  -- Carry Select Addierer
    entity work.m9_addsub32(Behavioral)
    port map(a   => x_in,          -- Summant a
             b   => rShiftToRadd,  -- Summant b
             ans => notSigma,      -- select add/sub
             y   => x_out);        -- Ausgang
             
  lSHIFT:   -- Barrel Shifter
    entity work.m_m9_barrel32(Behavioral)
    port map(x   => x_in,           -- Eingang
             pos => i,              -- schieben um i Stellen
             lnr => '0',            -- rechts shift
             y   => lShiftToLadd);  -- Ausgang

  lAddSub:  -- Carry Select Addierer
    entity work.m9_addsub32(Behavioral)
    port map(a   => y_in,          -- Summant a
             b   => lShiftToLadd,  -- Summant b
             ans => sigma,         -- select add/sub
             y   => y_out);        -- Ausgang
  
  M9_PP:  -- Winkel ROM
    entity work.m9_artan_rom(Behavioral)
    port map(i => i,             -- ROM Addresse
             d => romToZadder);  -- Arctan Wert

  zAddSub:  -- Carry Select Addierer
    entity work.m9_addsub32(Behavioral)
    port map(a   => z_in,         -- Summant a
             b   => romToZadder,  -- Summant b
             ans => notSigma,     -- select add/sub
             y   => z_out);       -- Ausgang

end Behavioral;