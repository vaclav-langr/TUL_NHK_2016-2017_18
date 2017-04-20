library ieee;
use ieee.std_logic_1164.all;

entity nhk_stopwatch is
	port (
		clk_in	:	in 	std_logic;
		button1	:	in		std_logic;
		button2	:	in		std_logic;
		segm1		:	out	std_logic_vector(6 downto 0);
		segm2		:	out	std_logic_vector(6 downto 0);
		segm3		:	out	std_logic_vector(6 downto 0);
		segm4		:	out	std_logic_vector(6 downto 0)
	);
end nhk_stopwatch;

architecture arch of nhk_stopwatch is
SIGNAL s_start_state		:	std_logic;
SIGNAL s_stop_state		:	std_logic;
SIGNAL s_clear_state		:	std_logic;
SIGNAL s_timer_tick		:	std_logic;
SIGNAL s_counter			: 	std_logic_vector(7 downto 0);
SIGNAL s_segm1_num4		: 	std_logic_vector(3 downto 0);
SIGNAL s_segm2_num4		:	std_logic_vector(3 downto 0);

SIGNAL s_timer2_tick		:	std_logic;
SIGNAL s_mux2_1			: 	std_logic;
SIGNAL s_mux2_2			: 	std_logic;
SIGNAL s_d1_1				:	std_logic;
SIGNAL s_d1_2				:	std_logic;
SIGNAL s_inv_d1_1			:	std_logic;
SIGNAL s_inv_button2		:	std_logic;
SIGNAL s_long_press		:	std_logic;
SIGNAL s_short_press		:	std_logic;
SIGNAL s_reset_detector	:	std_logic;
begin

-- hlavni cast stopek
Inst_machine:	ENTITY work.machine
	PORT MAP(
		clk => clk_in,
		user_input => button1,
		stop_state => s_stop_state,
		start_state => s_start_state,
		clear_state => s_clear_state
	);

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
	
-- detekce delky drzeni tlacitka 2
Inst_timer2: ENTITY work.timer2
	PORT MAP(
		clk_in => clk_in,
		reset_in => s_reset_detector,
		timer2_en_in => button2,
		timer2_out => s_timer2_tick
	);
Inst_mux2_1: ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d1_1,
		data1	=> s_timer2_tick,
      a => button2,
      y => s_mux2_1
	);
Inst_d1_1: ENTITY work.hr_d
	PORT MAP(
	   data => s_mux2_1,
		reset => s_reset_detector,
		clk => clk_in,
		o => s_d1_1
	);
Inst_inv_d1_1:	ENTITY work.invertor
	PORT MAP(
	   i => s_d1_1,
		o => s_inv_d1_1
	);
Inst_mux2_2: ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d1_2,
		data1	=> s_inv_d1_1,
      a => button2,
      y => s_mux2_2
	);
Inst_d1_2: ENTITY work.hr_d
	PORT MAP(
	   data => s_mux2_2,
		reset => s_reset_detector,
		clk => clk_in,
		o => s_d1_2
	);
Inst_inv_button2:	ENTITY work.invertor
	PORT MAP(
		i => button2,
		o => s_inv_button2
	);
Inst_and_long: ENTITY work.hr_and
	PORT MAP(
	   a => s_d1_1,
		b => s_inv_button2,
		o => s_long_press
	);
Inst_and_short: ENTITY work.hr_and
	PORT MAP(
	   a => s_d1_2,
		b => s_inv_button2,
		o => s_short_press
	);
Inst_or:	ENTITY work.hr_or
	PORT MAP(
		a => s_long_press,
		b => s_short_press,
		o => s_reset_detector
	);
end arch;