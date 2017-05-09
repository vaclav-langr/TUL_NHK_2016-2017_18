library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_1 is
   port (
      data0 : in std_logic;
		data1	: in std_logic;
      a : in std_logic;
      y : out std_logic
   	  );
end mux2_1;

architecture a_mux16_8 of mux2_1 is
begin
   process (data0, data1, a)
   begin      
		case a is
			when '0' => y <= data0;
			when '1' => y <= data1;
		end case;
   end process;
end a_mux16_8;