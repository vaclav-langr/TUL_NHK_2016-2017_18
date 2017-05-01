library ieee;
use ieee.std_logic_1164.all;

entity stopwatch_test is
	port (
		clk_in		:	in 	std_logic;
		c_int			:	in 	std_logic;
		segm1			:	out	std_logic_vector(6 downto 0);
		segm2			:	out	std_logic_vector(6 downto 0)
	);
end stopwatch_test;

architecture arch of stopwatch_test is
SIGNAL s_start_state		:	std_logic;
SIGNAL s_stop_state		:	std_logic;
SIGNAL s_clear_state		:	std_logic;
SIGNAL s_timer_tick		:	std_logic;
SIGNAL s_c_tens			: 	std_logic_vector(3 downto 0);
SIGNAL s_c_ones			: 	std_logic_vector(3 downto 0);
begin
-- hlavni cast stopek
Inst_counter: ENTITY work.counter
	PORT MAP(
		count_inc => c_int,
		clk => clk_in,
		reset => s_clear_state,
		tens => s_c_tens,
		ones => s_c_ones
	);
Inst_dec_7segm1: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_c_tens,
		output7 => segm1
	);
Inst_dec_7segm2: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_c_ones,
		output7 => segm2
	);
end arch;