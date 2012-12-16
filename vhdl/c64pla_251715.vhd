library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c64pla_251715 is
	port(
		dir1: out std_logic;
		dir2: out std_logic;

		oe: out std_logic;

		kernal: out std_logic;
		cia2: out std_logic;
		casram: out std_logic;
		ramrw: out std_logic;
		charom: out std_logic;
		basic: out std_logic;
		io: out std_logic;
		colram: out std_logic;
		ma: inout std_logic_vector(7 downto 0);
		phi0: in std_logic;
		a: inout std_logic_vector(15 downto 0);
		ras: in std_logic;
		va6: in std_logic;
		ba: in std_logic;
		sid: out std_logic;
		aec: in std_logic;
		exrom: in std_logic;
		cas: in std_logic;
		vic: out std_logic;
		cia1: out std_logic;
		roml: out std_logic;
		io2: out std_logic;
		romh: out std_logic;
		io1: out std_logic;
		nmi: out std_logic;
		va7: in std_logic;
		rw: in std_logic;
		loram: in std_logic;
		charen: in std_logic;
		hiram: in std_logic;
		va: in std_logic_vector(15 downto 12);
		restore: in std_logic;
		game: in std_logic;

		clk: in std_logic;

		aux_dir: out std_logic;
		aux: inout std_logic_vector(7 downto 0);

		misc1: out std_logic;
		misc2: out std_logic;
		misc3: out std_logic
	);
end c64pla_251715;

architecture rtl of c64pla_251715 is

signal ioBuffer: std_logic;
signal sideB: std_logic;

begin

	c64pla7_inst: entity c64pla7 
		port map(
			fe => '1',
			a13 => a(13),
			a14 => a(14),
			a15 => a(15),
			va14 => va(14),
			charen => charen,
			hiram => hiram,
			loram => loram,
			cas => cas,
			romh => romh,
			roml => roml,
			io => ioBuffer,
			ramrw => ramrw,
			grw => open,
			charom => charom,
			kernal => kernal,
			basic => basic,
			casram => casram,
			xoe => '0',
			va12 => va(12),
			va13 => va(13),
			game => game,
			exrom => exrom,
			rw => rw,
			aec => aec,
			ba => ba,
			a12 => a(12)
		);

	process(a(0), a(1), a(2), a(3), a(4), a(5), a(6), a(7), a(8), a(9), a(10), a(11), phi0, restore)
	subtype demuxA is std_logic_vector(1 downto 0);
	subtype demuxB is std_logic_vector(1 downto 0);
	begin
	-- From chip1.pdf .. START 
			ma(6) <= (
				-- From 74257
				(cas and not aec and a(14))
				or (cas and not aec and a(15))
				-- From 74258
				or (cas and aec and not va(14))
				-- From 74373
				or (aec and a(6) and ras)
				);
			ma(5) <= (
			   -- From 74257
			  (cas and not aec and a(13))
			  or (cas and not aec and a(15))
			  -- From 74373
			  or (aec and a(5) and ras)
			   );
			ma(7) <= (
			   -- From 74257
				(cas and not aec and a(6))
				or (cas and not aec and a(7))
				-- From 74373
				or (aec and a(7) and ras)
			   );
			ma(4) <= (
				-- From 74257
				(cas and not aec and a(7))
				or (cas and not aec and a(5))
				-- From 74373
				or (aec and a(4) and ras)
				);
	-- From chip1.pdf .. STOP
	-- From chip2.pdf .. START
			ma(3) <= (
				-- From 74257
				(cas and not aec and a(11))
				or (cas and not aec and a(9))
				-- From 74373
				or (aec and a(3) and ras)
				);
			ma(2) <= (
				-- From 74257
				(cas and not aec and a(10))
				or (cas and not aec and a(9))
				-- From 74373
				or (aec and a(2) and ras)
				);
			ma(1) <= (
				-- From 74257
				(cas and not aec and a(3))
				or (cas and not aec and a(1))
				-- From 74373
				or (aec and a(1) and ras)
				);
			ma(0) <= (
				-- From 74257
				(cas and not aec and a(2))
				or (cas and not aec and a(0))
				-- From 74373
				or (aec and a(0) and ras)
				);
				-- 74139 2->4 demux - Side 'A'
				if ioBuffer = '0' then
					case demuxA'(a(8) & a(10)) is
						when "00" => vic <= '0';
						when "01" => sid <= '0';
						when "10" => colram <= aec;
						when "11" => sideB <= '0';
						when others => null;
					end case;
				end if;
				-- 74139 2->4 demux - Side 'B'
				if sideB = '0' then
					case demuxB'(a(9) & a(11)) is
						when "00" => cia1 <= '0';
						when "01" => cia2 <= '0';
						when "10" => io1 <= '0';
						when "11" => io2 <= '0';
						when others => null;
					end case;
				end if;
			ma(7) <= (
				-- From 74258
				(aec and cas and va(15))
				);
	-- From chip2.pdf .. STOP
		
	end process;
	
	-- Connect the ioBuffer to the 'io' output pin..
	io <= ioBuffer;

end architecture rtl;
