--  
-- M9 VLSI Architekturen SS 2018
--

library ieee;
use ieee.std_logic_1164.all;


entity m9_fulladd is
  generic (tpd      :  time := 0 ns);
  port (a, b, cin  : in  std_logic;
	sum , cout : out std_logic);
end m9_fulladd;


architecture behaviour of m9_fulladd is
begin

  compute_result : process (a, b, cin)
    variable tmp_sum, tmp_carry : std_logic;
  begin
    if cin = '0' then
      if a = '0' and b = '0' then
	tmp_sum := '0';
        tmp_carry := '0';
      elsif (a = '0' and b = '1') or (a = '1' and b = '0') then
	tmp_sum := '1';
        tmp_carry := '0';	
      else
	tmp_sum := '0';
        tmp_carry := '1';
      end if;
    else
      if a = '0' and b = '0' then
	tmp_sum := '1';
        tmp_carry := '0';
      elsif (a = '0' and b = '1') or (a = '1' and b = '0') then
	tmp_sum := '0';
        tmp_carry := '1';	
      else
	tmp_sum := '1';
        tmp_carry := '1';
      end if;
    end if;

    sum  <= tmp_sum;
    cout <= tmp_carry;
  end process;

end behaviour;


architecture gatelevel of m9_fulladd is
  signal sum1, carry1, carry2 : std_logic;

  component m9_halfadd   
    port (a, b        : in  std_logic;
	  sum, carry  : out std_logic);
  end component;

begin
  
  stage_one : m9_halfadd 
    port map (a => a, b => b, sum => sum1, carry => carry1);

  stage_two : m9_halfadd
    port map (a => cin, b => sum1, sum => sum, carry => carry2);

  cout <= transport carry1 or carry2 after 2 ns;
end gatelevel;  
