library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity m_m9_mul is
generic (width : positive := 4);
port (clk, reset : in  std_logic;
      a, b       : in  std_logic_vector(width - 1 downto 0);
      y          : out std_logic_vector((2 * width) - 1 downto 0));
end m_m9_mul;

architecture Behavioral of m_m9_mul is


type an is array (0 to width -1) of std_logic_vector(width-1 downto 0);
signal ans : an;
type bn is array (0 to width -1) of std_logic_vector(width-1 downto 0);
signal bns : bn;
 -- last solution in array in pipline not needet -> output
type yn is array (0 to width -1 -1) of std_logic_vector((2*width)-1 downto 0);
signal yns : yn;
begin

gen : for i in 0 to width-1 generate
    genFirst : if (i = 0) generate
        M9_PP1: entity work.m9_pp(Behavioral)
        generic map(width_opa_in   => width,
                    width_opb_in   => width,
                    width_prod_in  => width + width,
                    width_opa_out  => width,
                    width_opb_out  => width,
                    width_prod_out => width + width)
        port map(clk => clk,
                 reset => reset,
                 a_in  => a,
                 b_in  => b,
                 y_in  => (others => '0'),
                 a_out => ans(i),
                 b_out => bns(i),
                 y_out => yns(i));
    end generate;  
    genMid : if (i > 0 and i < width -1) generate
        M9_PP2: entity work.m9_pp(Behavioral)
        generic map(width_opa_in   => width,
                    width_opb_in   => width,
                    width_prod_in  => width + width,
                    width_opa_out  => width,
                    width_opb_out  => width,
                    width_prod_out => width + width)
        port map(clk => clk,
                 reset => reset,
                 a_in  => ans(i-1),
                 b_in  => bns(i-1),
                 y_in  => yns(i-1),
                 a_out => ans(i),
                 b_out => bns(i),
                 y_out => yns(i));   
    end generate;
     genLast : if (i = width-1) generate
         M9_PP3: entity work.m9_pp(Behavioral)
            generic map(width_opa_in   => width,
                        width_opb_in   => width,
                        width_prod_in  => width + width,
                        width_opa_out  => width,
                        width_opb_out  => width,
                        width_prod_out => width + width)
            port map(clk => clk,
                     reset => reset,
                     a_in  => ans(i-1),
                     b_in  => bns(i-1),
                     y_in  => yns(i-1),
                     a_out => ans(i),
                     b_out => bns(i),
                     y_out => y);  
    end generate;
end generate;
end Behavioral;
