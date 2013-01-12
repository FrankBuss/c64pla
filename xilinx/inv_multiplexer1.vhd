library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inv_multiplexer is
	port(
		a: in std_logic;
		b: in std_logic;
		y: out std_logic;
		sel: in std_logic
	);
end inv_multiplexer;

architecture rtl of inv_multiplexer is

begin

	process(a, b, sel)
	begin
		if sel = '1' then y <= not a; else y <= not b; end if;
	end process;

end architecture rtl;
