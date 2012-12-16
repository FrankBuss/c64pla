library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.all;

entity decoder_testbench is
end entity decoder_testbench;

architecture test of decoder_testbench is

	signal a: std_logic;
	signal b: std_logic;
	signal y: std_logic_vector(3 downto 0);
	signal g: std_logic;

begin
	
	decoder_inst: entity decoder
		port map(
			a => a,
			b => b,
			y => y,
			g => g
		);

	process
	-- helper procedure to test one line of the function table
	procedure functionTest(g_test: std_logic; b_test: std_logic; a_test: std_logic; y_test: std_logic_vector(3 downto 0)) is
	begin
		-- set input signals
		a <= a_test;
		b <= b_test;
		g <= g_test;
		
		-- wait a bit (simulated gates are infinite fast, for behavorial simulations)
		wait for 1 ns;
		
		-- test output
		assert y <= y_test report "error" severity failure;
	end procedure;
	begin
		-- function table on page 1 of http://www.ti.com/lit/ds/symlink/sn74s139a.pdf
		functionTest('1', '0', '0', "1111");
		functionTest('1', '0', '1', "1111");
		functionTest('1', '1', '0', "1111");
		functionTest('1', '1', '1', "1111");
		functionTest('0', '0', '0', "1110");
		functionTest('0', '0', '1', "1101");
		functionTest('0', '1', '0', "1011");
		functionTest('0', '1', '1', "0111");

		-- show simulation end
		assert false report "no failure, simulation successful" severity failure;
		
	end process;
	

end architecture test;
