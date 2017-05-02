library ieee;
use ieee.std_logic_1164.all;

entity detectorMachine is
	port (
		clk			:	in		std_logic;
		reset			:	in		std_logic;
		user_input	:	in		std_logic;
		long_press	:	out	std_logic;
		short_press	:	out	std_logic
	);
end detectorMachine;

architecture behav of detectorMachine is
	type states is (s0, s1, s2, s3);
	signal reg_state, next_state	:	states := s0;
begin
	-- pamet automatu
	process (reset, clk)
	begin
		if reset = '1' then
			reg_state <= s0;
		elsif clk'event and clk = '1' then
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
			when others =>
				next_state <= reg_state;
		end case;
	end process;
	
	process(reg_state)
	begin
		case reg_state is
			when s0 =>
				long_press  <= '0';
				short_press <= '0';
			when s1 =>
				long_press  <= '0';
				short_press <= '1';
			when s2 =>
				long_press  <= '0';
				short_press <= '1';
			when s3 =>
				long_press  <= '1';
				short_press <= '0';
			when others => null;
		end case;
	end process;
end behav;