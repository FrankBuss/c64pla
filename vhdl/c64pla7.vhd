library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c64pla7 is
	port(
		a13: in std_logic;
		a14: in std_logic;
		a15: in std_logic;
		va14: in std_logic;
		charen: in std_logic;
		hiram: in std_logic;
		loram: in std_logic;
		cas: in std_logic;
		romh: out std_logic;
		roml: out std_logic;
		io: out std_logic;
		grw: out std_logic;
		charom: out std_logic;
		kernal: out std_logic;
		basic: out std_logic;
		casram: out std_logic;
		xoe: in std_logic;
		va12: in std_logic;
		va13: in std_logic;
		game: in std_logic;
		exrom: in std_logic;
		rw: in std_logic;
		aec: in std_logic;
		ba: in std_logic;
		a12: in std_logic
	);
end c64pla7;

architecture rtl of c64pla7 is

begin

	process(a13, a14, a15, va14, charen, hiram, loram, cas, xoe, va12, va13, game, exrom, rw, aec, ba, a12)
	begin
		if xoe = '1' then
			romh <= 'Z';
			roml <= 'Z';
			io <= 'Z';
			grw <= 'Z';
			charom <= 'Z';
			kernal <= 'Z';
			basic <= 'Z';
			casram <= 'Z';
		else
			romh <= not (
				((hiram and a15 and not a14 and a13 and aec and rw and not exrom and not game) 
				or (a15 and a14 and a13 and aec and exrom and not game) 
				or (not aec and exrom and not game and va13 and va12))  );

			roml <= not (
				((loram and hiram and a15 and not a14 and not a13 and aec and rw and not exrom) 
				or (a15 and not a14 and not a13 and aec and exrom and not game))  );

			io <= not (
				((hiram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and aec and not rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and aec and not rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and not exrom and not game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and aec and not rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and aec and not rw and not exrom and not game) 
				or (a15 and a14 and not a13 and a12 and ba and aec and rw and exrom and not game) 
				or (a15 and a14 and not a13 and a12 and aec and not rw and exrom and not game))  );

			grw <= cas or not a15 or not a14 or a13 or not a12 or not aec or rw;

			charom <= not (
				((hiram and not charen and a15 and a14 and not a13 and a12 and aec and rw and game) 
				or (loram and not charen and a15 and a14 and not a13 and a12 and aec and rw and game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and aec and rw and not exrom and not game) 
				or (va14 and not aec and game and not va13 and va12)
				or (va14 and not aec and not exrom and not game and not va13 and va12))  );

			kernal <= not (
				((hiram and a15 and a14 and a13 and aec and rw and game) 
				or (hiram and a15 and a14 and a13 and aec and rw and not exrom and not game))  );

			basic <= not (
				(loram and hiram and a15 and not a14 and a13 and aec and rw and game)  );

			casram <= (
				((loram and hiram and a15 and not a14 and a13 and aec and rw and game) 
				or (hiram and a15 and a14 and a13 and aec and rw and game) 
				or (hiram and a15 and a14 and a13 and aec and rw and not exrom and not game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and aec and rw and game) 
				or (loram and not charen and a15 and a14 and not a13 and a12 and aec and rw and game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and aec and rw and not exrom and not game) 
				or (va14 and not aec and game and not va13 and va12) 
				or (va14 and not aec and not exrom and not game and not va13 and va12) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and aec and not rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and aec and not rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and not exrom and not game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and aec and not rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and aec and rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and aec and not rw and not exrom and not game) 
				or (a15 and a14 and not a13 and a12 and ba and aec and rw and exrom and not game) 
				or (a15 and a14 and not a13 and a12 and aec and not rw and exrom and not game) 
				or (loram and hiram and a15 and not a14 and not a13 and aec and rw and not exrom) 
				or (a15 and not a14 and not a13 and aec and exrom and not game) 
				or (hiram and a15 and not a14 and a13 and aec and rw and not exrom and not game) 
				or (a15 and a14 and a13 and aec and exrom and not game) 
				or (not aec and exrom and not game and va13 and va12) 
				or (not a15 and not a14 and a12 and exrom and not game) 
				or (not a15 and not a14 and a13 and exrom and not game) 
				or (not a15 and a14 and exrom and not game) 
				or (a15 and not a14 and a13 and exrom and not game) 
				or (a15 and a14 and not a13 and not a12 and exrom and not game) 
				or cas)  );
		end if;
		
	end process;
	

end architecture rtl;
