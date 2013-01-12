library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttl74258 is
	port(
		-- generic
		gn: in std_logic;
		sel: in std_logic;
		-- multiplexer 1
		a1: in std_logic;
		b1: in std_logic;
		yn1: out std_logic
	);
end ttl74258;

architecture rtl of ttl74258 is

begin

	inv_multiplexer1: entity inv_multiplexer
		port map (
			a => a1,
			b => b1,
			y => yn1,
			sel => sel
	);

end architecture rtl;

