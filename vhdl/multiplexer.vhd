library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplexer is
	port(
		gn: in std_logic;
		a: in std_logic;
		b: in std_logic;
		y: out std_logic;
		sel: in std_logic
	);
end multiplexer;

architecture rtl of multiplexer is

begin

	process(a, b, sel, gn)
	begin
		if gn = '0' then
			if sel = '1' then 
				y <= b; 
			else 
				y <= a; 
			end if;
		else
			y <= 'Z';
		end if;
	end process;

end architecture rtl;