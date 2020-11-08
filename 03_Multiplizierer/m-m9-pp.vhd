library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity m9_pp is
generic (width_opa_in   : positive;
         width_opb_in   : positive;
         width_prod_in  : positive;
         width_opa_out  : positive;
         width_opb_out  : positive;
         width_prod_out : positive);
port (clk   : in  std_logic;
      reset : in  std_logic;
      a_in  : in  std_logic_vector(width_opa_in   - 1 downto 0);
      b_in  : in  std_logic_vector(width_opb_in   - 1 downto 0);
      y_in  : in  std_logic_vector(width_prod_in  - 1 downto 0);
      a_out : out std_logic_vector(width_opa_out  - 1 downto 0);
      b_out : out std_logic_vector(width_opb_out  - 1 downto 0);
      y_out : out std_logic_vector(width_prod_out - 1 downto 0));
end m9_pp;

architecture Behavioral of m9_pp is
signal sum : std_logic_vector (width_prod_out-1 downto 0);
begin

    sum <= (b_in + y_in) when a_in(0) = '1' else
                      y_in when a_in(0) = '0';
                      
    REG_OUT : process (clk, reset)
    begin
        if (reset='1') then
            a_out <= (others => '0');  -- reset a shift register
            b_out <= (others => '0');  -- reset b shift register
            y_out <= (others => '0');  -- reset y register
        elsif (clk'event and clk='1') then
            b_out <= b_in(width_opb_in - 2 downto 0) & "0";
            a_out <=  "0" & a_in(width_opa_in - 1 downto 1); -- error?
            y_out <= sum;
        end if;
    end process;
end Behavioral;

