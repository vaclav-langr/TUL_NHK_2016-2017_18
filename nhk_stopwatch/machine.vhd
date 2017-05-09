library ieee;
use ieee.std_logic_1164.all;

entity machine is
	port (
		clk			:	in		std_logic;
		user_input	:	in		std_logic;
		stop_state	:	out	std_logic;
		start_state	:	out	std_logic;
		clear_state	:	out	std_logic
	);
end machine;

architecture behav of machine is
	type states is (s0, s1, s2, s3, s4, s5);
	signal reg_state, next_state	:	states := s0;
begin
	-- pamet automatu
	process (clk)
	begin
		if clk'event and clk = '1' then
			reg_state <= next_state;
		end if;
	end process;
	
	-- prechodova funkce automatu
	process (reg_state, user_input)
	begin
		next_state <= reg_state;
		case reg_state is
			when s0 =>
				if user_input = '1' then
					next_state <= s1;
				end if;
			when s1 =>
				if user_input = '0' then
					next_state <= s2;
				end if;
			when s2 =>
				if user_input = '1' then
					next_state <= s3;
				end if;
			when s3 =>
				if user_input = '0' then
					next_state <= s4;
				end if;
			when s4 =>
				if user_input = '1' then
					next_state <= s5;
				end if;
			when s5 =>
				if user_input = '0' then
					next_state <= s0;
				end if;
			when others =>
				next_state <= reg_state;
		end case;
	end process;
	
	process(reg_state)
	begin
		case reg_state is
			when s0 =>
				stop_state  <= '0';
				start_state <= '0';
				clear_state <= '1';
			when s1 =>
				stop_state  <= '0';
				start_state <= '0';
				clear_state <= '1';
			when s2 =>
				stop_state  <= '0';
				start_state <= '1';
				clear_state <= '0';
			when s3 =>
				stop_state  <= '0';
				start_state <= '0';
				clear_state <= '0';
			when s4 =>
				stop_state  <= '1';
				start_state <= '0';
				clear_state <= '0';
			when s5 =>
				stop_state  <= '1';
				start_state <= '0';
				clear_state <= '0';
			when others => null;
		end case;
	end process;
end behav;