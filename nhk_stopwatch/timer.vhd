--casovac

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;

entity timer is
	port(
		clk_in		: in	std_logic;
		reset_in		: in	std_logic;
		timer1_en_in : in	std_logic;
		timer1_out	: out	std_logic
		);
end timer;

architecture ar of timer is
signal s_cnt8: integer range 0 to 99; -- 0 to 200
signal s_enable: std_logic;	
	
begin
	
   process (reset_in, clk_in)
      variable cnt : unsigned (19 downto 0);
   begin
      if reset_in = '1' then
         cnt := (others => '0');
         s_enable <= '0';
      elsif clk_in'event and clk_in = '1' then
         if cnt = 320000 then --320000
            cnt := (others => '0');
            s_enable <= '1';
         else
            cnt := cnt + 1;
            s_enable <= '0';
         end if;
      end if;
   end process;

   process (clk_in)
   begin
	 if clk_in'event and clk_in = '1' then
		if timer1_en_in = '1' then
			if s_enable = '1' then
				s_cnt8 <= s_cnt8 + 1;
			end if;
		else
			s_cnt8 <= 0;
		end if;
    end if;
   end process;
   
   process (s_cnt8)
   begin
		IF (s_cnt8 < 99) THEN timer1_out <= '1'; ELSE timer1_out <= '0'; END IF; --99
   end process;  
	
END ar;