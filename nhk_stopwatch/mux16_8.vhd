library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux16_8 is
   port (
      x : in std_logic_vector (15 downto 0);
      a : in std_logic;
      y : out std_logic_vector (7 downto 0)
   	  );
end mux16_8;

architecture a_mux16_8 of mux16_8 is
begin
   process (x, a)
   begin      
		case a is
			when '0' => y <= x(7 downto 0);
			when '1' => y <= x(15 downto 8);
		end case;
   end process;
end a_mux16_8;