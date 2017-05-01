library ieee;
use ieee.std_logic_1164.all;

entity hold_detector_test is
	port (
		clk_in		:	in 	std_logic;
		button		:	in		std_logic;
		clear_state	:	in		std_logic;
		stop_state	:	in		std_logic;
		long_press	:	out	std_logic;
		short_press	:	out	std_logic
	);
end hold_detector_test;

architecture arch of hold_detector_test is
SIGNAL s_timer2_tick		:	std_logic;
SIGNAL s_mux2_1			: 	std_logic;
SIGNAL s_mux2_2			: 	std_logic;
SIGNAL s_d1_1				:	std_logic;
SIGNAL s_d1_2				:	std_logic;
begin
-- detekce delky drzeni tlacitka 2
Inst_mux2_1: ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d1_1,
		data1	=> button,
      a => button,
      y => s_mux2_1
	);
Inst_d1_1: ENTITY work.hr_d
	PORT MAP(
	   data => s_mux2_1,
		reset => clear_state,
		clk => clk_in,
		o => s_d1_1
	);
Inst_mux2_2: ENTITY work.mux2_1
	PORT MAP(
	   data0 => s_d1_2,
		data1	=> not s_d1_1,
      a => button,
      y => s_mux2_2
	);
Inst_d1_2: ENTITY work.hr_d
	PORT MAP(
	   data => s_mux2_2,
		reset => clear_state,
		clk => clk_in,
		o => s_d1_2
	);
long_press <= not button and s_d1_1 and stop_state;
short_press <= not button and s_d1_2 and stop_state;
end arch;