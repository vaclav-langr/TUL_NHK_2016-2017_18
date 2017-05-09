library ieee;
use ieee.std_logic_1164.all;

entity hold_detector is
	port (
		clk_in		:	in 	std_logic;
		button		:	in		std_logic;
		stop_state	:	in		std_logic;
		clear_state	:	in		std_logic;
		long_press	:	out	std_logic;
		short_press	:	out	std_logic
	);
end hold_detector;

architecture arch of hold_detector is
SIGNAL s_timer_tick		:	std_logic;
SIGNAL s_long_press		:	std_logic;
SIGNAL s_mux1				:	std_logic;
SIGNAL s_d1					:	std_logic;
SIGNAL s_mux2				:	std_logic;
SIGNAL s_d2					:	std_logic;
begin
-- detekce delky drzeni tlacitka 2
Inst_timer: ENTITY work.timer
	PORT MAP(
		clk_in => clk_in,
		reset_in => clear_state,
		timer1_en_in => button and stop_state,
		timer1_out => s_timer_tick
	);
Inst_detectorMachine:	ENTITY work.detectorMachine
	PORT MAP(
		clk => clk_in,
		reset => not button,
		user_input => s_timer_tick,
		long_press => s_long_press
	);
	
Inst_mux2_1_1:	ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d1,
		data1 => s_long_press,
      a => button,
      y => s_mux1
	);
Inst_d1_1:	ENTITY work.hr_d
	PORT MAP(
	   data => s_mux1,
		reset => clear_state,
		clk => clk_in,
		o => s_d1
	);
long_press <= s_d1 and not button;

Inst_mux2_1_2:	ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d2,
		data1 => button,
      a => button,
      y => s_mux2
	);
Inst_d1_2:	ENTITY work.hr_d
	PORT MAP(
	   data => s_mux2,
		reset => clear_state,
		clk => clk_in,
		o => s_d2
	);
short_press <= s_d2 and not button and not s_d1;
end arch;