LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY traffic_lamp_tb IS
END traffic_lamp_tb;
 
ARCHITECTURE traffic_lamp_tb_arch OF traffic_lamp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT traffic_lamp
PORT(
i_clock : IN std_logic;
i_reset : IN std_logic;

o_lamp1_red : OUT std_logic;
o_lamp1_yellow : OUT std_logic;
o_lamp1_green : OUT std_logic;
o_lamp1_num_tens : OUT integer;
o_lamp1_num_units : OUT integer;

o_lamp2_red : OUT std_logic;
o_lamp2_yellow : OUT std_logic;
o_lamp2_green : OUT std_logic;
o_lamp2_num_tens : OUT integer;
o_lamp2_num_units : OUT integer;
count : OUT integer
);
END COMPONENT;
 
--Inputs
signal i_clock : std_logic := '0';
signal i_reset : std_logic := '1';
 
--Outputs
signal o_lamp1_red : std_logic;
signal o_lamp1_yellow : std_logic;
signal o_lamp1_green : std_logic;
signal o_lamp1_num_tens : integer;
signal o_lamp1_num_units : integer;

signal o_lamp2_red : std_logic;
signal o_lamp2_yellow : std_logic;
signal o_lamp2_green : std_logic;
signal o_lamp2_num_tens : integer;
signal o_lamp2_num_units : integer;

signal count : integer;
 
-- Clock period definitions
constant clk_period : time := 10 us;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: traffic_lamp PORT MAP (
i_clock => i_clock,
i_reset => i_reset,
o_lamp1_red => o_lamp1_red,
o_lamp1_yellow => o_lamp1_yellow,
o_lamp1_green => o_lamp1_green,
o_lamp1_num_tens => o_lamp1_num_tens,
o_lamp1_num_units => o_lamp1_num_units,
o_lamp2_red => o_lamp2_red,
o_lamp2_yellow => o_lamp2_yellow,
o_lamp2_green => o_lamp2_green,
o_lamp2_num_tens => o_lamp2_num_tens,
o_lamp2_num_units => o_lamp2_num_units,
count => count
);
 
-- Clock process definitions
clk_process: process
begin
i_clock <= '0';
wait for clk_period/2;
i_clock <= '1';
wait for clk_period/2;
end process;
 
-- Stimulus process
stim_proc: process
begin
wait for 100 us;
i_reset <= '0';
wait for 100 us;
i_reset <= '1';
wait;
end process;
 
END;

