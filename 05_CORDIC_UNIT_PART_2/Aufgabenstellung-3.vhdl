entity m9_ce is
  port (m                   : in std_logic;
        sigma               : in std_logic;
        i                   : in std_logic_vector( 4 downto 0);
        x_in, y_in, z_in    : in std_logic_vector(31 downto 0);
        x_out, y_out, z_out : in std_logic_vector(31 downto 0));
end m9_ce;
      
