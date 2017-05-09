library ieee;
use ieee.std_logic_1164.all;

ENTITY dec_7segm IS
	PORT(
		input4		: IN	std_logic_vector(3 downto 0);
		output7		: OUT	std_logic_vector(6 downto 0)
		);
END dec_7segm;

ARCHITECTURE ar OF dec_7segm IS
	
BEGIN
	PROCESS (input4)
	BEGIN

	CASE input4 IS
  	    WHEN "0000" => output7 <= "0000001";     
  	    WHEN "0001" => output7 <= "1001111";
  	    WHEN "0010" => output7 <= "0010010";
  	    WHEN "0011" => output7 <= "0000110";
 	    WHEN "0100" => output7 <= "1001100";
 	    WHEN "0101" => output7 <= "0100100";
 	    WHEN "0110" => output7 <= "0100000";
	    WHEN "0111" => output7 <= "0001111";
 	    WHEN "1000" => output7 <= "0000000";
  	    WHEN "1001" => output7 <= "0000100";
       WHEN OTHERS => output7 <= "1111111";
    END CASE;


	END PROCESS ;
	
END ar;