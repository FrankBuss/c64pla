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

signal lastvalue: std_logic_vector(4 downto 1);

begin
	process(oen)
	begin
		if oen = '0' and g = '1' then
			q <= d;
			-- store value
			lastvalue <= d;
		else
			if oen = '0' and g = '0' then
				-- drive the last value..
				q <= lastvalue;
			else
				q <= (others => 'Z');			
			end if;
		end if;
	end process;
end architecture rtl;

