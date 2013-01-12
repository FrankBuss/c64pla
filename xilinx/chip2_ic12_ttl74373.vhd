library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttl74373 is
	port(
		-- generic
		g: in std_logic;
		oen: in std_logic;
		-- latch signals
		q: out std_logic_vector(4 downto 1);
		d: in std_logic_vector(4 downto 1)
	);
end ttl74373;

architecture rtl of ttl74373 is

begin
	process(oen)
	begin
		if oen = '0' and g = '1' then
			q <= d;
		else
			q <= (others => 'Z');
		end if;
	end process;
end architecture rtl;

