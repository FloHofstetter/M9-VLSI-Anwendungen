entity m9_pp is
generic (width_opa_in   : positive,
         width_opb_in   : positive,
         width_prod_in  : positive,
         width_opa_out  : positive,
         width_opb_out  : positive,
         width_prod_out : positive);
port (clk   : in  std_logic,
      reset : in  std_logic,
      a_in  : in  std_logic_vector(width_opa_in   - 1 downto 0),
      b_in  : in  std_logic_vector(width_opb_in   - 1 downto 0),
      y_in  : in  std_logic_vector(width_prod_in  - 1 downto 0),
      a_out : out std_logic_vector(width_opa_out  - 1 downto 0),
      b_out : out std_logic_vector(width_opb_out  - 1 downto 0),
      y_out : out std_logic_vector(width_prod_out - 1 downto 0));
end m9_pp;
