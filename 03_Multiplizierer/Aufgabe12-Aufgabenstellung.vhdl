entity m9_mul
generic (width : positive := 8)
port    (clk,
         reset : in  std_logic
         a, b  : in  std_logic_vector (width - 1 downto 0)
         y     : out std_logic_vector ((2 * width) - 1 downto 0));
end m9_mul;
