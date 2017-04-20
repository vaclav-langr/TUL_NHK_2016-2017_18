LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity hr_d is port (
    data	: in std_logic;
	 reset: in std_logic;
	 clk	: in std_logic;
    o		: out std_logic
    );
end hr_d;

architecture arch of hr_d is

begin
  process(clk, reset)
  begin
	if(reset = '1') then
		o <= '0';
	elsif (clk'event and clk = '1') then
		o <= data;
	end if;
  end process;
end arch;