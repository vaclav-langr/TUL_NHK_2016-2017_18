LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity hr_d8 is port (
	 clk		:	in std_logic;
    data: in std_logic_vector(7 downto 0);
    o: out std_logic_vector(7 downto 0)
    );
end hr_d8;

architecture arch of hr_d8 is

begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			o <= data;
		end if;
	end process;

end arch;