library ieee;
use ieee.std_logic_1164.all;

entity hold_detector is
	port (
		clk_in		:	in 	std_logic;
		button		:	in		std_logic;
		stop_state	:	in		std_logic;
		clear_state	:	in		std_logic;
		long_press	:	out	std_logic;
		short_press	:	out	std_logic;
		pulse			:	out	std_logic
	);
end hold_detector;

architecture arch of hold_detector is
SIGNAL s_timer2_tick		:	std_logic;
SIGNAL s_mux2_1			: 	std_logic;
SIGNAL s_mux2_2			: 	std_logic;
SIGNAL s_d1_1				:	std_logic;
SIGNAL s_d1_2				:	std_logic;
begin
-- detekce delky drzeni tlacitka 2
Inst_timer2: ENTITY work.timer2
	PORT MAP(
		clk_in => clk_in,
		reset_in => clear_state,
		timer2_en_in => button and stop_state,
		timer2_out => s_timer2_tick
	);
pulse <= s_timer2_tick;
Inst_detectorMachine:	ENTITY work.detectorMachine
	PORT MAP(
		clk => clk_in,
		reset => not button,
		user_input => s_timer2_tick,
		long_press => long_press,
		short_press => short_press
	);
end arch;