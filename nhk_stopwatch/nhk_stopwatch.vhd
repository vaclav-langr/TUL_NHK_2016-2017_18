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
		segm4		:	out	std_logic_vector(6 downto 0);		
		led1		:	out	std_logic;
		led2		:	out	std_logic;
		led3		:	out	std_logic
	);
end nhk_stopwatch;

architecture arch of nhk_stopwatch is
SIGNAL s_start_state		:	std_logic;
SIGNAL s_stop_state		:	std_logic;
SIGNAL s_clear_state		:	std_logic;
SIGNAL s_counter			: 	std_logic_vector(7 downto 0);

SIGNAL s_long_press		:	std_logic;
SIGNAL s_short_press		:	std_logic;
begin

Inst_stopwatch:	ENTITY work.stopwatch
		PORT MAP(
			clk_in => clk_in,
			button => button1,
			stop_state => s_stop_state,
			clear_state => s_clear_state,
			count => s_counter,
			segm1 => segm1,
			segm2	=> segm2
		);
led1 <= s_stop_state;
led2 <= not s_stop_state and not s_clear_state;
led3 <= s_clear_state;
Inst_hold_detector:	ENTITY work.hold_detector
	PORT MAP(
		clk_in => clk_in,
		button => button2,
		stop_state => s_stop_state,
		clear_state => s_clear_state,
		long_press => s_long_press,
		short_press => s_short_press
	);
	
Inst_memory_display:	ENTITY work.memory_display
	PORT MAP(
		clk_in => clk_in,
		long_press => s_long_press,
		short_press => s_short_press,
		count => s_counter,
		segm1 => segm3,
		segm2	=> segm4
	);
end arch;