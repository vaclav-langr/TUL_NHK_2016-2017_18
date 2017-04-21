library ieee;
use ieee.std_logic_1164.all;

entity memory_display is
	port (
		clk_in		:	in 	std_logic;
		long_press	:	in		std_logic;
		short_press	:	in		std_logic;
		count			:	in		std_logic_vector(7 downto 0);
		segm1			:	out	std_logic_vector(6 downto 0);
		segm2			:	out	std_logic_vector(6 downto 0)
	);
end memory_display;

architecture arch of memory_display is
SIGNAL s_save_count		:	std_logic_vector(7 downto 0);
SIGNAL s_current_saved	:	std_logic_vector(7 downto 0);
SIGNAL s_show_current	:	std_logic_vector(7 downto 0);
SIGNAL s_current_shown	:	std_logic_vector(7 downto 0);
SIGNAL s_segm1_num4		: 	std_logic_vector(3 downto 0);
SIGNAL s_segm2_num4		:	std_logic_vector(3 downto 0);
begin
-- ulozeni/vyvolani hodnoty
Inst_mux16_1: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_saved,
		data1 => count,
      a => long_press,
      y => s_save_count
	);
Inst_d8_1: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_save_count,
		o => s_current_saved
	);
Inst_mux16_2: ENTITY work.mux16_8
	PORT MAP(
		data0 => s_current_shown,
		data1 => s_current_saved,
      a => short_press,
      y => s_show_current
	);
Inst_d8_2: ENTITY work.hr_d8
	PORT MAP(
		clk => clk_in,
		data => s_show_current,
		o => s_current_shown
	);
	
s_segm1_num4 <= s_current_shown(3 downto 0);
s_segm2_num4 <= s_current_shown(7 downto 4);
Inst_dec_7segm3: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_segm1_num4,
		output7 => segm1
	);
Inst_dec_7segm4: ENTITY work.dec_7segm
	PORT MAP(
		input4 => s_segm2_num4,
		output7 => segm2
	);
end arch;