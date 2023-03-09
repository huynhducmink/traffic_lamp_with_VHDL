library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_lamp is
	port (
		i_clock           : in  std_logic;
		i_reset           : in  std_logic;
		count		  : out integer;

		o_lamp1_red       : out std_logic;
		o_lamp1_yellow    : out std_logic;
		o_lamp1_green     : out std_logic;
		o_lamp1_num_tens   : out integer range 0 to 9;
        o_lamp1_num_units   : out integer range 0 to 9;

		o_lamp2_red       : out std_logic;
		o_lamp2_yellow    : out std_logic;
		o_lamp2_green     : out std_logic;
		o_lamp2_num_tens   : out integer range 0 to 9;
        o_lamp2_num_units   : out integer range 0 to 9
	);
end traffic_lamp;

architecture traffic_lamp_arch of traffic_lamp is

	-- SiSpeed Tang Nano 9K 27MHz clock
	-- count_s go to 27000000 / 1 = 27000000
	constant count_s_max : natural := 27; -- use 9000000 to speedup 3 times
	signal count_s : natural := 1;
	-- max time_counter to 59
	signal time_counter : natural := 0;

begin

	process (i_clock, i_reset)
	begin
		if (i_reset = '0') then
			count_s <= 1;
			time_counter <=0;
		elsif (i_clock'event and i_clock='1') then
			count_s <= count_s + 1;
			if (count_s >= count_s_max) then
				count_s <= 1;
				if (time_counter >=59) then
					time_counter <= 0;
					count <= 0;
				else 
				time_counter <= time_counter + 1;
				count <= time_counter +1;
				end if;
			end if;
		end if;
	end process;

	process (i_clock)
	begin
		if (i_clock'event and i_clock='1') then
			if (time_counter < 30) then
				o_lamp1_red <= '1';
				o_lamp1_yellow <= '0';
				o_lamp1_green <= '0';
				o_lamp1_num_tens <= (30 - time_counter)/10;
                o_lamp1_num_units <= (30-time_counter)-((30 - time_counter)/10)*10;
			elsif (time_counter >=30 and time_counter < 55) then
				o_lamp1_red <= '0';
				o_lamp1_yellow <= '0';
				o_lamp1_green <= '1';
				o_lamp1_num_tens <= (55 - time_counter)/10;
                o_lamp1_num_units <= (55-time_counter)-((55 - time_counter)/10)*10;
			elsif (time_counter >=55 and time_counter < 60) then
				o_lamp1_red <= '0';
				o_lamp1_yellow <= '1';
				o_lamp1_green <= '0';
				o_lamp1_num_tens <= (60 - time_counter)/10;
                o_lamp1_num_units <= (60-time_counter)-((60 - time_counter)/10)*10;
			end if;
		end if;
	end process;

	process (i_clock)
	begin
		if (i_clock'event and i_clock='1') then
			if (time_counter < 25) then
				o_lamp2_red <= '0';
				o_lamp2_yellow <= '0';
				o_lamp2_green <= '1';
				o_lamp2_num_tens <= (25 - time_counter)/10;
                o_lamp2_num_units <= (25-time_counter)-((25 - time_counter)/10)*10;
			elsif (time_counter >=25 and time_counter < 30) then
				o_lamp2_red <= '0';
				o_lamp2_yellow <= '1';
				o_lamp2_green <= '0';
				o_lamp2_num_tens <= (30 - time_counter)/10;
                o_lamp2_num_units <= (30-time_counter)-((30 - time_counter)/10)*10;
			elsif (time_counter >=30 and time_counter < 60) then
				o_lamp2_red <= '1';
				o_lamp2_yellow <= '0';
				o_lamp2_green <= '0';
				o_lamp2_num_tens <= (60 - time_counter)/10;
                o_lamp2_num_units <= (60-time_counter)-((60 - time_counter)/10)*10;
			end if;
		end if;
	end process;

end traffic_lamp_arch;
