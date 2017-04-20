library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_1 is
   port (
      x : in std_logic_vector (1 downto 0);
      a : in std_logic;
      y : out std_logic
   	  );
end mux2_1;

architecture a_mux16_8 of mux2_1 is
begin
   process (x, a)
   begin      
		case a is
			when '0' => y <= x(0);
			when '1' => y <= x(1);
		end case;
   end process;
end a_mux16_8;