library ieee;
use ieee.std_logic_1164.all;

entity memory_display is
	port (
		clk_in		:	in 	std_logic;
		long_press	:	in		std_logic;
		short_press	:	in		std_logic;
		c_ones		:	in		std_logic_vector(3 downto 0);
		c_tens		:	in		std_logic_vector(3 downto 0);
		segm1			:	out	std_logic_vector(6 downto 0);
		segm2			:	out	std_logic_vector(6 downto 0)
	);
end memory_display;

architecture arch of memory_display is
SIGNAL s_save_10_count		:	std_logic_vector(3 downto 0);
SIGNAL s_current_10_saved	:	std_logic_vector(3 downto 0);
SIGNAL s_show_10_current	:	std_logic_vector(3 downto 0);
SIGNAL s_current_10_shown	:	std_logic_vector(3 downto 0);

SIGNAL s_save_1_count		:	std_logic_vector(3 downto 0);
SIGNAL s_current_1_saved	:	std_logic_vector(3 downto 0);
SIGNAL s_show_1_current		:	std_logic_vector(3 downto 0);
SIGNAL s_current_1_shown	:	std_logic_vector(3 downto 0);
begin
-- ulozeni/vyvolani hodnoty
Inst_mux16_10_1: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_10_saved,
		data1 => c_tens,
      a => long_press,
      y => s_save_10_count
	);
Inst_d8_10_1: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_save_10_count,
		o => s_current_10_saved
	);
Inst_mux16_10_2: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_10_shown,
		data1 => s_current_10_saved,
      a => short_press,
      y => s_show_10_current
	);
Inst_d8_10_2: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_show_10_current,
		o => s_current_10_shown
	);
	
Inst_mux16_1_1: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_1_saved,
		data1 => c_ones,
      a => long_press,
      y => s_save_1_count
	);
Inst_d8_1_1: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_save_1_count,
		o => s_current_1_saved
	);
Inst_mux16_1_2: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_1_shown,
		data1 => s_current_1_saved,
      a => short_press,
      y => s_show_1_current
	);
Inst_d8_1_2: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_show_1_current,
		o => s_current_1_shown
	);	
	

Inst_dec_7segm3: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_current_10_shown,
		output7 => segm1
	);
Inst_dec_7segm4: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_current_1_shown,
		output7 => segm2
	);
end arch;