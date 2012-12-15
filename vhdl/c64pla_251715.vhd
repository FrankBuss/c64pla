library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c64pla_251715 is
	port(
		fe: in std_logic;
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
		ramrw: out std_logic;
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
		a12: in std_logic;
		vic: out std_logic;
		ras: out std_logic;
		va7: out std_logic;
		va6: out std_logic;
		ma5: out std_logic;
		ma4: out std_logic;
		ma3: out std_logic;
		ma2: out std_logic;
		ma1: out std_logic;
		ma0: out std_logic;
		a0: in std_logic;
		a1: in std_logic;
		a2: in std_logic;
		a3: in std_logic;
		a4: in std_logic;
		a5: in std_logic;
		a6: in std_logic;
		a7: in std_logic;
		a8: in std_logic;
		a9: in std_logic;
		a10: in std_logic;
		a11: in std_logic;
		d1: in std_logic;
		d2: in std_logic;
		d3: in std_logic;
		d4: in std_logic;
		phi0: in std_logic;
		io2: out std_logic;
		cia1: out std_logic;
		cia2: out std_logic;
		nmi: out std_logic;
		restore: in std_logic
	);
end c64pla_251715;

architecture rtl of c64pla_251715 is

begin

	process(fe, a13, a14, a15, va14, charen, hiram, loram, cas, xoe, va12, va13, game, exrom, rw, aec, ba, a12, vic, ras, va7, va6, ma0, ma1, ma2, ma3, ma4, ma5, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, d1, d2, d3, d4, phi0, io2, cia1, cia2, nmi, restore)
	begin
		if xoe = '1' then
			romh <= 'Z';
			roml <= 'Z';
			io <= 'Z';
			ramrw <= 'Z';
			charom <= 'Z';
			kernal <= 'Z';
			basic <= 'Z';
			casram <= 'Z';
		else
			romh <= not (
				((hiram and a15 and not a14 and a13 and not aec and rw and not exrom and not game) 
				or (a15 and a14 and a13 and not aec and exrom and not game) 
				or (aec and exrom and not game and va13 and va12))  );

			roml <= not (
				((loram and hiram and a15 and not a14 and not a13 and not aec and rw and not exrom) 
				or (a15 and not a14 and not a13 and not aec and exrom and not game))  );

			io <= not (
				((hiram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and not exrom and not game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and not exrom and not game) 
				or (a15 and a14 and not a13 and a12 and ba and not aec and rw and exrom and not game) 
				or (a15 and a14 and not a13 and a12 and not aec and not rw and exrom and not game))  );

			grw <= cas or not a15 or not a14 or a13 or not a12 or aec or rw;

			ramrw <= not (
				(not rw and not aec)  ) ;

			charom <= not (
				((hiram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and game) 
				or (loram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and not exrom and not game) 
				or (va14 and aec and game and not va13 and va12)
				or (va14 and aec and not exrom and not game and not va13 and va12))  );

			kernal <= not (
				((hiram and a15 and a14 and a13 and not aec and rw and game) 
				or (hiram and a15 and a14 and a13 and not aec and rw and not exrom and not game))  );

			basic <= not (
				(loram and hiram and a15 and not a14 and a13 and not aec and rw and game)  );

			casram <= (
				((loram and hiram and a15 and not a14 and a13 and not aec and rw and game) 
				or (hiram and a15 and a14 and a13 and not aec and rw and game) 
				or (hiram and a15 and a14 and a13 and not aec and rw and not exrom and not game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and game) 
				or (loram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and game) 
				or (hiram and not charen and a15 and a14 and not a13 and a12 and not aec and rw and not exrom and not game) 
				or (va14 and aec and game and not va13 and va12) 
				or (va14 and aec and not exrom and not game and not va13 and va12) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and not exrom and not game) 
				or (hiram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and ba and not aec and rw and not exrom and not game) 
				or (loram and charen and a15 and a14 and not a13 and a12 and not aec and not rw and not exrom and not game) 
				or (a15 and a14 and not a13 and a12 and ba and not aec and rw and exrom and not game) 
				or (a15 and a14 and not a13 and a12 and not aec and not rw and exrom and not game) 
				or (loram and hiram and a15 and not a14 and not a13 and not aec and rw and not exrom) 
				or (a15 and not a14 and not a13 and not aec and exrom and not game) 
				or (hiram and a15 and not a14 and a13 and not aec and rw and not exrom and not game) 
				or (a15 and a14 and a13 and not aec and exrom and not game) 
				or (aec and exrom and not game and va13 and va12) 
				or (not a15 and not a14 and a12 and exrom and not game) 
				or (not a15 and not a14 and a13 and exrom and not game) 
				or (not a15 and a14 and exrom and not game) 
				or (a15 and not a14 and a13 and exrom and not game) 
				or (a15 and a14 and not a13 and not a12 and exrom and not game) 
				or cas)  );
	-- From chip1.pdf .. START 
			ma6 <= (
				-- From 74257
				(cas and not aec and a14)
				or (cas and not aec and a15)
				-- From 74258
				or (cas and aec and not va14)
				-- From 74373
				or (aec and a6 and ras)
				);
			ma5 <= (
			   -- From 74257
			  (cas and not aec and a13)
			  or (cas and not aec and a15)
			  -- From 74373
			  or (aec and a5 and ras)
			   );
			ma7 <= (
			   -- From 74257
				(cas and not aec and a6)
				or (cas and not aec and a7)
				-- From 74373
				or (aec and a7 and ras)
			   );
			ma4 <= (
				-- From 74257
				(cas and not aec and a7)
				or (cas and not aec and a5)
				-- From 74373
				or (aec and a4 and ras)
				);
	-- From chip1.pdf .. STOP
	-- From chip2.pdf .. START
			ma3 <= (
				-- From 74257
				(cas and not aec and a11)
				or (cas and not aec and a9)
				-- From 74373
				or (aec and a3 and ras)
				);
			ma2 <= (
				-- From 74257
				(cas and not aec and a10)
				or (cas and not aec and a9)
				-- From 74373
				or (aec and a2 and ras)
				);
			ma1 <= (
				-- From 74257
				(cas and not aec and a3)
				or (cas and not aec and a1)
				-- From 74373
				or (aec and a1 and ras)
				);
			ma0 <= (
				-- From 74257
				(cas and not aec and a2)
				or (cas and not aec and a0)
				-- From 74373
				or (aec and a0 and ras)
				);
			colram <= (
				-- From 74373 and 74139
				(a8 and io and a10 and a11)
				);
			vic <= (
				-- From 74139
				(a8 and io)
				);
			sid <= (
				-- From 74139
				(a8 and io and a11)
				);
			cia1 <= (
				-- From 74139
				(a8 and io and a10)
				);
			cia2 <= (
				-- From 74139
				(a8 and io and a9)
				);
			io1 <= (
				-- From 74139
				(a8 and io and a9 and a10)
				);
			io2 <= (
				-- From 74139
				(a8 and io and a9 and a11 and 10)
				);
			ma7 <= (
				-- From 74258
				(aec and cas and va15)
				);
	-- From chip2.pdf .. STOP
		end if;
		
	end process;

end architecture rtl;
