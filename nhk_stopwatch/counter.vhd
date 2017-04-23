library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY counter IS
	PORT(
		count_inc	: IN	std_logic;
		clk			: IN 	std_logic;
		reset			: IN 	std_logic;
		tens			: OUT	std_logic_vector(3 downto 0);
		ones			: OUT	std_logic_vector(3 downto 0)
		);
END counter;

ARCHITECTURE ar OF counter IS
	TYPE states IS (s0, s1, s2);
	SIGNAL state : states := s0;
	SIGNAL nxt_state : states := s0;
	SIGNAL en	: bit;
	SIGNAL s_tens	: integer range 0 to 9;
	SIGNAL s_ones	: integer range 0 to 9;
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
			s_tens <= 0;
			s_ones <= 0;
		elsif (clk'event and clk = '1') then
			if en = '1' then
				s_ones <= s_ones + 1;
				if(s_ones >= 9) then
					s_ones <= 0;
					s_tens <= s_tens + 1;
					if(s_tens >= 9) then
						s_tens <= 0;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	tens <= CONV_STD_LOGIC_VECTOR(s_tens,4);
	ones <= CONV_STD_LOGIC_VECTOR(s_ones,4);
END ar;