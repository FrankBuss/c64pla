library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttl74373 is
	port(
		-- generic
		gn: in std_logic;
		oe: in std_logic;
		-- latch signals
		q: inout std_logic_vector(4 downto 1);
		d: inout std_logic_vector(4 downto 1)
	);
end ttl74373;

architecture rtl of ttl74373 is

begin
	process(oe)
	begin
		if oe = '1' and gn = '0' then
			q <= d;
		end if;
	end process;
end architecture rtl;

