library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux16_8 is
   port (
      data0 : in std_logic_vector (7 downto 0);
		data1	: in std_logic_vector (7 downto 0);
      a 		: in std_logic;
      y 		: out std_logic_vector (7 downto 0)
   	  );
end mux16_8;

architecture a_mux16_8 of mux16_8 is
begin
   process (data0, data1, a)
   begin      
		case a is
			when '0' => y <= data0;
			when '1' => y <= data1;
		end case;
   end process;
end a_mux16_8;