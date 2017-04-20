LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity hr_and is port (
    a,b: in std_logic;
    o: out std_logic
    );
end hr_and;

architecture arch of hr_and is

begin

  o <= (a and b);

end arch;