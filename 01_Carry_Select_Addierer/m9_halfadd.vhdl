--  
--  M9 VLSI Architekturen SS 2018
--

library ieee;
use ieee.std_logic_1164.all;

entity m9_halfadd is
  generic (tpd      :  time := 0 ns);
  port (a, b        : in  std_logic;
	sum, carry  : out std_logic);
end m9_halfadd;


architecture behaviour of m9_halfadd is
begin
  process (a, b)
    variable tmp_sum, tmp_carry : std_logic;
  begin
    if (a = '1' and b = '0') or (a = '0' and b = '1') then
      tmp_sum   := '1';
      tmp_carry := '0';
    elsif (a = '1' and b = '1') then
      tmp_sum   := '0';
      tmp_carry := '1';
    elsif a = '0' and b = '0' then
      tmp_sum   := '0';
      tmp_carry := '0';
    end if;
    
    sum   <= tmp_sum;
    carry <= tmp_carry;
  end process;
end;


architecture gatelevel of m9_halfadd is
begin
  sum   <= transport a xor b after tpd;
  carry <= transport a and b after tpd;
end gatelevel;
