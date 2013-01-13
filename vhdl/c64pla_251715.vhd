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
signal chip2_ic13_y12n: std_logic;
signal chip2_ic13_y13n: std_logic;

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

	chip2_ic13: entity ttl74139
		port map(
			-- decoder 1
			g1n => ioBuffer,
			a1 => a(10),
			b1 => a(11),
			y10n => vic,
			y11n => sid,
			y12n => chip2_ic13_y12n,
			y13n => chip2_ic13_y13n,
			
			-- decoder 2
			g2n => chip2_ic13_y13n,
			a2 => a(8),
			b2 => a(9),
			y20n => cia1,
			y21n => cia2,
			y22n => io1,
			y23n => io2
	);
	
	chip2_ic11: entity ttl74257
		port map(
			-- common signals
			sel => cas,
			gn => not aec,
			-- multiplexer 1
			a1 => a(11),
			b1 => a(3),
			y1 => ma(3),
			-- multiplexer 2
			a2 => a(10),
			b2 => a(2),
			y2 => ma(2),
			-- multiplexer 3
			a3 => a(9),
			b3 => a(1),
			y3 => ma(1),
			-- multiplexer 4
			a4 => a(8),
			b4 => a(0),
			y4 => ma(0)
	);
	
	chip1_ic26: entity ttl74257
		port map(
			-- common signals
			sel => cas,
			gn => not aec,
			-- multiplexer 1
			a1 => a(14),
			b1 => a(6),
			y1 => ma(6),
			-- multiplexer 2
			a2 => a(13),
			b2 => a(5),
			y2 => ma(5),
			-- multiplexer 3
			a3 => a(15),
			b3 => a(7),
			y3 => ma(7),
			-- multiplexer 4
			a4 => a(12),
			b4 => a(4),
			y4 => ma(4)
	);
	
	chip2_ic14: entity ttl74258
		port map(
			-- common signals
			sel => cas,
			gn => aec,
			-- multiplexer 1
			a1 => va(15),
			b1 => not a(7),
			yn1 => ma(7)
		);
		
	chip1_ic28: entity ttl74258
		port map(
			-- common signals
			sel => cas,
			gn => aec,
			-- multiplexer 1
			a1 => va(14),
			b1 => not va6,
			yn1 => ma(6)
	);
		
	chip2_ic12: entity ttl74373
		port map(
			-- common signals
			g => ras,
			oen => aec,
			-- D (input)
			d(1) => a(0),
			d(2) => a(1),
			d(3) => a(2),
			d(4) => a(3),
			-- Q (output)
			q(1) => ma(0),
			q(2) => ma(1),
			q(3) => ma(2),
			q(4) => ma(3)
		);
		
	chip1_ic27: entity ttl74373
		port map(
			-- common signals
			g => ras,
			oen => aec,
			-- D (input)
			d(1) => ma(4),
			d(2) => ma(5),
			d(3) => ma(6),
			d(4) => ma(7),
			-- Q (output)
			q(1) => a(4),
			q(2) => a(5),
			q(3) => a(6),
			q(4) => a(7)
		);
	
	colram <= chip2_ic13_y12n and aec;

	process(a, phi0, restore, cas, aec, va, ras, clk)
	begin
			
			-- A direct mapping. Might work ok but might need additional logic.
			nmi <= restore;
			-- Define directions for outputs..
			dir1 <= '1';
			dir2 <= '1';
			aux_dir <= '1';
			-- Enable the voltage level shifters..
			oe <= '0';
			-- Avoid a few other warnings about un-connected signals at this time..
			misc1 <= clk;
			misc2 <= restore;
			misc3 <= not clk;
			
	end process;
	
	-- Connect the ioBuffer to the 'io' output pin..
	io <= ioBuffer;

end architecture rtl;
