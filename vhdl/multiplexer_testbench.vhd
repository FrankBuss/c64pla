library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.all;

entity multiplexer_testbench is
end entity multiplexer_testbench;

architecture test of multiplexer_testbench is

	signal a: std_logic;
	signal b: std_logic;
	signal y: std_logic;
	signal gn: std_logic;
	signal sel: std_logic;

begin
	
	multiplexer_inst: entity multiplexer
		port map(
			a => a,
			b => b,
			y => y,
			sel => sel,
			gn => gn
		);

	process
	-- helper procedure to test one line of the function table
	procedure functionTest(gn_test: std_logic; sel_test: std_logic; a_test: std_logic;  b_test: std_logic; y_test: std_logic) is
	begin
		-- set input signals
		a <= a_test;
		b <= b_test;
		gn <= gn_test;
		sel <= sel_test;
		
		-- wait a bit (simulated gates are infinite fast, for behavorial simulations)
		wait for 1 ns;
		
		-- test output
		assert y = y_test report "error, gn: " & std_Logic'image(gn_test) &
			", sel: " & std_Logic'image(sel_test) &
			", a: " & std_Logic'image(a_test) &
			", b: " & std_Logic'image(b_test) &
			", y: " & std_Logic'image(y_test)
			severity failure;
	end procedure;
	begin
		-- function table on page 4 of http://www.nxp.com/documents/data_sheet/74HC258.pdf
		functionTest('1', '0', '0', '0', 'Z');
		functionTest('0', '0', '0', '0', '0');
		functionTest('0', '0', '1', '0', '1');
		functionTest('0', '1', '0', '0', '0');
		functionTest('0', '1', '0', '1', '1');
		-- No Care permutations..
		functionTest('1', '1', '0', '0', 'Z');
		functionTest('1', '0', '1', '0', 'Z');
		functionTest('1', '0', '0', '1', 'Z');
		functionTest('0', '0', '0', '1', '0');
		functionTest('0', '0', '1', '1', '1');
		functionTest('0', '1', '1', '0', '0');
		functionTest('0', '1', '1', '1', '1');
		functionTest('1', '0', '1', '1', 'Z');
		functionTest('1', '1', '0', '1', 'Z');
		functionTest('1', '1', '1', '0', 'Z');
		functionTest('1', '1', '1', '1', 'Z');

		-- show simulation end
		assert false report "no failure, simulation successful" severity failure;
		
	end process;
	

end architecture test;
