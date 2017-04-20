LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity invertor is port (
    i: in std_logic;
    o: out std_logic
    );
end invertor;

architecture arch of invertor is

begin

  o <= not i;

end arch;