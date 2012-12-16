library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttl74139 is
	port(
		-- decoder 1
		g1n: in std_logic;
		a1: in std_logic;
		b1: in std_logic;
		y10n: out std_logic;
		y11n: out std_logic;
		y12n: out std_logic;
		y13n: out std_logic;
		
		-- decoder 2
		g2n: in std_logic;
		a2: in std_logic;
		b2: in std_logic;
		y20n: out std_logic;
		y21n: out std_logic;
		y22n: out std_logic;
		y23n: out std_logic
	);
end ttl74139;

architecture rtl of ttl74139 is

signal y1: std_logic_vector(3 downto 0);
signal y2: std_logic_vector(3 downto 0);

begin

	decoder1: entity decoder
		port map(
			a => a1,
			b => b1,
			y => y1,
			g => g1n
	);

	decoder2: entity decoder
		port map(
			a => a2,
			b => b2,
			y => y2,
			g => g2n
	);
	
	y10n <= y1(0);
	y11n <= y1(1);
	y12n <= y1(2);
	y13n <= y1(3);

	y20n <= y2(0);
	y21n <= y2(1);
	y22n <= y2(2);
	y23n <= y2(3);

end architecture rtl;
