library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttl74257 is
	port(
		-- generic
		gn: in std_logic;
		sel: in std_logic;
		-- multiplexer 1
		a1: in std_logic;
		b1: in std_logic;
		y1: out std_logic;
		-- multiplexer 2
		a2: in std_logic;
		b2: in std_logic;
		y2: out std_logic;
		-- multiplexer 3
		a3: in std_logic;
		b3: in std_logic;
		y3: out std_logic;
		-- multiplexer 4
		a4: in std_logic;
		b4: in std_logic;
		y4: out std_logic
	);
end ttl74257;

architecture rtl of ttl74257 is

begin

	multiplexer1: entity multiplexer
		port map (
			gn => gn,
			a => a1,
			b => b1,
			y => y1,
			sel => sel
	);
	
	multiplexer2: entity multiplexer
		port map (
			gn => gn,
			a => a2,
			b => b2,
			y => y2,
			sel => sel
	);
	
	multiplexer3: entity multiplexer
		port map (
			gn => gn,
			a => a3,
			b => b3,
			y => y3,
			sel => sel
	);
	
	multiplexer4: entity multiplexer
		port map (
			gn => gn,
			a => a4,
			b => b4,
			y => y4,
			sel => sel
	);

end architecture rtl;
