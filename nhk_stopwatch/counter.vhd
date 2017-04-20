library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY counter IS
	PORT(
		count_inc	: IN	std_logic;
		clk			: IN 	std_logic;
		reset			: IN 	std_logic;
		output8		: OUT	std_logic_vector(7 downto 0)
		);
END counter;

ARCHITECTURE ar OF counter IS
	TYPE states IS (s0, s1, s2);
	SIGNAL state : states := s0;
	SIGNAL nxt_state : states := s0;
	SIGNAL en	: bit;
	SIGNAL citac	: unsigned (7 downto 0);
BEGIN
	clkd: process(reset,clk)
    begin
        if reset = '1' then
			state <= s0;
        elsif rising_edge(clk) then
			state <= nxt_state;
        end if;
    end process clkd;
	
	state_trans: process(state, count_inc)
	begin
		case state is
			when s0 => if(count_inc = '1') then nxt_state <= s1;
				else nxt_state <= s0;
				end if;
			when s1 => if(count_inc = '1') then nxt_state <= s2;
				else nxt_state <= s0;
				end if;
			when s2 => if(count_inc = '1') then nxt_state <= s2;
				else nxt_state <= s0;
				end if;
		end case;
	end process state_trans;
	
	output: process(state)
	begin
		case state is
			when s1 => en <= '1';
			when others => en <= '0';
		end case;
	end process output;
	
	process (clk, reset)
	begin
		if reset = '1' then
			citac <= "00000000";
		elsif (clk'event and clk = '1') then
			if en = '1' then
				citac <= citac + 1;
				if (citac >= 99) then
					citac <= "00000000";
				end if;
			end if;
		end if;
		output8 <= STD_LOGIC_VECTOR(citac);
	end process;
END ar;