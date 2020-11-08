library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity m_m9_barrel32 is
    port(x : in std_logic_vector(31 downto 0);
         pos : in std_logic_vector(4 downto 0);
         lnr : in std_logic;
         y   : out std_logic_vector(31 downto 0));
end m_m9_barrel32;

architecture Behavioral of m_m9_barrel32 is
    signal sl_1  : std_logic_vector(31 downto 0);
    signal sl_2  : std_logic_vector(31 downto 0);
    signal sl_4  : std_logic_vector(31 downto 0);
    signal sl_8  : std_logic_vector(31 downto 0);
    signal sl_16 : std_logic_vector(31 downto 0);
    signal sr_1  : std_logic_vector(31 downto 0);
    signal sr_2  : std_logic_vector(31 downto 0);
    signal sr_4  : std_logic_vector(31 downto 0);
    signal sr_8  : std_logic_vector(31 downto 0);
    signal sr_16 : std_logic_vector(31 downto 0);
begin

    -- shift left --
    with pos(0) select sl_1 <=
           (x(31) & x(29 downto 0) & "0") when '1',
                                        x when others;
    with pos(1) select sl_2 <=
           (sl_1(31) & sl_1(28 downto 0) & "00") when '1',
                                            sl_1 when others;
    with pos(2) select sl_4 <=
           (sl_2(31) & sl_2(26 downto 0) & "0000") when '1',
                                              sl_2 when others;
    with pos(3) select sl_8 <=
           (sl_4(31) & sl_4(22 downto 0) & "00000000") when '1',
                                                  sl_4 when others;
    with pos(4) select sl_16 <=
           (sl_8(31) & sl_8(14 downto 0) & "0000000000000000") when '1',
                                                          sl_8 when others;
    -- end shift left --

    -- shift right --
    with pos(0) select sr_1 <=
           (x(31)    & "0" & x(30 downto 1)) when '1',
                                           x when others;
    with pos(1) select sr_2 <=
           (sr_1(31) & "00") & sr_1(30 downto 2) when '1',
                                            sr_1 when others;
    with pos(2) select sr_4 <=
           (sr_2(31) & "0000") & sr_2(30 downto 4) when '1',
                                              sr_2 when others;
    with pos(3) select sr_8 <=
           (sr_4(31) & "00000000") & sr_4(30 downto 8) when '1',
                                                  sr_4 when others;
    with pos(4) select sr_16 <=
           (sr_8(31) & "0000000000000000") & sr_8(30 downto 16) when '1',
                                                           sr_8 when others;
    -- end shift right --

    -- select left or right --
    with lnr select y <=
           sl_16 when '1',
           sr_16 when others;
    -- end selct left or right
end Behavioral;
