library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity m_m9_cordic is
  port(reset     : in  std_logic;
       clk       : in  std_logic;
       valid_in  : in  std_logic;
       theta     : in  std_logic_vector(31 downto 0);
       valid_out : out std_logic;
       cos_theta : out std_logic_vector(31 downto 0);
       sin_theta : out std_logic_vector(31 downto 0));
end m_m9_cordic;

architecture Behavioral of m_m9_cordic is
  type state_type is (init, idle, load, execute);
  signal current_state : state_type;
  signal next_state    : state_type;
  signal n             : std_logic_vector( 4 downto 0);
  signal x_in          : std_logic_vector(31 downto 0);
  signal y_in          : std_logic_vector(31 downto 0);
  signal z_in          : std_logic_vector(31 downto 0);
  signal x_out         : std_logic_vector(31 downto 0);
  signal y_out         : std_logic_vector(31 downto 0);
  signal z_out         : std_logic_vector(31 downto 0);
  signal sigma         : std_logic;
begin

  STATE_MEMORY:
  process(clk, reset)
    begin
      if (reset = '1') then
        current_state <= init;
      elsif (clk'event and clk = '1') then
        current_state <= next_state;
      end if;
    end process;

  NEXT_STATE_LOGIC:
  process (current_state, valid_in, n)
    begin
      case (current_state) is
        when init =>  -- only after reset
          if (valid_in = '1') then
            next_state <= load;
          else
            next_state <= init;
          end if;
        when idle =>  -- after cordic has calculated
          if (valid_in = '1') then
            next_state <= load;
          else
            next_state <= idle;
          end if;
        when load =>
          next_state <= execute;
        when execute =>
          if (n > "10111") then  -- if(n<=24)
            next_state <= idle;
          else
            next_state <= execute;
          end if;
        when others =>
          next_state <= idle;  -- just in case...
      end case;
    end process;

  OUTPUT_LOGIC:
  process (clk, current_state)
    begin
        case (current_state) is
          when init =>
            -- reset all Outputs and Signals
            cos_theta <= (others => '0');
            sin_theta <= (others => '0');
            x_in <= (others => '0');
            y_in <= (others => '0');
            z_in <= (others => '0');
            n <= (others => '0');
            sigma <= '0';
            valid_out <= '0';
          when idle =>
            cos_theta <= x_out;
            sin_theta <= y_out;
            valid_out <= '1';
          when load =>
            valid_out <= '0';
            sigma     <= theta(31);
            n         <= "00000";  -- n=1
            x_in <= x"01_00_00_00";
            y_in <= x"00_00_00_00";
            z_in <= theta;
          when execute =>
            valid_out <= '0';
            if (clk'event and clk = '1') then 
              sigma <= z_out(31);
              x_in  <= x_out;
              y_in  <= y_out;
              z_in  <= z_out;
              n <= n + 1;
            end if;  
          when others   =>
            null;  -- will not happen
          end case;
    end process;

    M9_CE: entity work.m9_ce(Behavioral)
    port map(m     => '0',    -- what is this? 
             sigma => sigma,  -- Vorzeichen = MSB des Winkels
             i     => n,      -- Iterationsebene
             x_in  => x_in,   -- X-Kooridinate Eingang
             y_in  => y_in,   -- Y-Koordinate-Eingang
             z_in  => z_in,   -- Winkeleingang
             x_out => x_out,  -- X-Koordinate Ausang
             y_out => y_out,  -- Y-Koordinate-Ausgang
             z_out => z_out); -- Winkelausgang
end Behavioral;
