entity m9_adder is 
    generic (width : positive := 5);
    port (cin  : in  std_logic;
          a, b : in  std_logic_vector (width - 1 downto 0);
          s    : out std_logic_vector (width - 1 downto 0);
          cout : out std_logic);
end m9_adder;
