library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port(
		a: in std_logic;
		b: in std_logic;
		y: out std_logic_vector(3 downto 0);
		g: in std_logic
	);
end decoder;

architecture rtl of decoder is

begin

	process(a, b, g)
	subtype vector2 is std_logic_vector(1 downto 0);
	begin
		y <= (others => '1');
		if g = '0' then
			case vector2'(b & a) is
				when "00" => y(0) <= '0';
				when "01" => y(1) <= '0';
				when "10" => y(2) <= '0';
				when "11" => y(3) <= '0';
				when others => null;
			end case;
		end if;
	end process;

end architecture rtl;
