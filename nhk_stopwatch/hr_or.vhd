LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity hr_or is port (
    a,b: in std_logic;
    o: out std_logic
    );
end hr_or;

architecture arch of hr_or is

begin

  o <= (a or b);

end arch;