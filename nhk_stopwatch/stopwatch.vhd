library ieee;
use ieee.std_logic_1164.all;

entity stopwatch is
	port (
		clk_in		:	in 	std_logic;
		button		:	in		std_logic;
		stop_state	:	out	std_logic;
		clear_state	:	out	std_logic;
		count			:	out	std_logic_vector(7 downto 0);
		segm1			:	out	std_logic_vector(6 downto 0);
		segm2			:	out	std_logic_vector(6 downto 0)
	);
end stopwatch;

architecture arch of stopwatch is
SIGNAL s_start_state		:	std_logic;
SIGNAL s_stop_state		:	std_logic;
SIGNAL s_clear_state		:	std_logic;
SIGNAL s_timer_tick		:	std_logic;
SIGNAL s_counter			: 	std_logic_vector(7 downto 0);
SIGNAL s_segm1_num4		: 	std_logic_vector(3 downto 0);
SIGNAL s_segm2_num4		:	std_logic_vector(3 downto 0);
begin
-- hlavni cast stopek
Inst_machine:	ENTITY work.machine
	PORT MAP(
		clk => clk_in,
		user_input => button,
		stop_state => s_stop_state,
		start_state => s_start_state,
		clear_state => s_clear_state
	);
stop_state <= s_stop_state;
clear_state <= s_clear_state;
Inst_timer1: ENTITY work.timer
	PORT MAP(
		clk_in => clk_in,
		reset_in => s_clear_state,
		timer1_en_in => s_start_state,
		timer1_out	=> s_timer_tick
	);

Inst_counter: ENTITY work.counter
	PORT MAP(
		count_inc => s_timer_tick,
		clk => clk_in,
		reset => s_clear_state,
		output8 => s_counter
	);
count <= s_counter;	
s_segm1_num4 <= s_counter(3 downto 0);
s_segm2_num4 <= s_counter(7 downto 4);
Inst_dec_7segm1: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_segm1_num4,
		output7 => segm1
	);
Inst_dec_7segm2: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_segm2_num4,
		output7 => segm2
	);
end arch;