library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c64pla_251715 is
	port(
		-- internal PLA adapter signals
		
		-- direction for the voltage level converters (dir2 not used)
		dir1: out std_logic;
		dir2: out std_logic;

		-- output enable for the voltage level converters
		oe: out std_logic;

		-- auxiliary input/output, currently mapped to phi0
		clk: out std_logic;

		-- direction (1=output) and bits for the auxiliary 8 bit port
		aux_dir: out std_logic;
		aux: out std_logic_vector(7 downto 0);

		-- misc pins (misc2 = LED)
		misc1: out std_logic;
		misc2: out std_logic;
		misc3: in std_logic;


		-- C64 signals

		-- chip selects for the peripheral chips
		io: out std_logic;
		vic: out std_logic;
		cia1: out std_logic;
		cia2: out std_logic;
		sid: out std_logic;
		io1: out std_logic;
		io2: out std_logic;
		
		-- ROM chip selects
		basic: out std_logic;
		kernal: out std_logic;
		charom: out std_logic;

		-- RAM signals
		casram: out std_logic;
		ramrw: out std_logic;
		colram: out std_logic;
		ras: in std_logic;
		cas: in std_logic;
		ma: inout std_logic_vector(7 downto 0);
		va6: in std_logic;
		va7: in std_logic;
		va14: in std_logic;
		va15: in std_logic;
		
		-- address inputs (0..7 is output, when the VIC owns the bus for color RAM)
		a: inout std_logic_vector(15 downto 0);

		-- clock, not used
		phi0: in std_logic;
		
		-- address enable control: 1, when the 6510 controls the bus, 0 when for the VIC
		aec: in std_logic;
		
		-- cartridge and other signals
		exrom: in std_logic;
		roml: out std_logic;
		romh: out std_logic;
		ba: in std_logic;
		nmi: out std_logic;
		rw: in std_logic;
		loram: in std_logic;
		charen: in std_logic;
		hiram: in std_logic;
		restore: in std_logic;
		game: in std_logic
	);
end c64pla_251715;

architecture rtl of c64pla_251715 is

signal ioBuffer: std_logic;
signal io1Buffer: std_logic;
signal io2Buffer: std_logic;
signal casramBuffer: std_logic;
signal addressBuffer: std_logic_vector(7 downto 0);
signal ledBuffer: std_logic := '0';

begin

	c64pla7_inst: entity c64pla7 
		port map(
			a13 => a(13),
			a14 => a(14),
			a15 => a(15),
			va14 => va14,
			charen => charen,
			hiram => hiram,
			loram => loram,
			cas => cas,
			romh => romh,
			roml => roml,
			io => ioBuffer,
			grw => open,
			charom => charom,
			kernal => kernal,
			basic => basic,
			casram => casramBuffer,
			xoe => '0',
			va12 => ma(4),
			va13 => ma(5),
			game => game,
			exrom => exrom,
			rw => rw,
			aec => aec,
			ba => ba,
			a12 => a(12)
		);

	process(aec, cas, ioBuffer, va6, va7, va14, va15, ras, addressBuffer, phi0)
	begin
		-- default initializations
		vic <= '1';
		sid <= '1';
		cia1 <= '1';
		cia2 <= '1';
		io1Buffer <= '1';
		io2Buffer <= '1';
		colram <= '1';
		
		-- test which chip controls the address bus
		if aec = '1' then
			-- the CPU controls the address bus

			-- address is input
			a(7 downto 0) <= (others => 'Z');

			-- RAM row/column output
			if cas = '1' then
				ma <= a(7 downto 0);
			else
				ma <= a(15 downto 8);
			end if;
			
			-- io: "a15 and a14 and not a13 and a12" = $d000
			if ioBuffer = '0' then
				case a(11 downto 10) is
					-- $d000
					when "00" =>
						vic <= '0';

					-- $d400
					when "01" =>
						sid <= '0';

					-- $d800
					when "10" =>
						colram <= '0';

					-- $dc00
					when "11" =>
						case a(9 downto 8) is

							-- $dc00
							when "00" =>
								cia1 <= '0';

							-- $dd00
							when "01" =>
								cia2 <= '0';

							-- $de00
							when "10" =>
								io1Buffer <= '0';

							-- $df00
							when "11" =>
								io2Buffer <= '0';

							when others => null;
						end case;
					when others => null;
				end case;
			end if;

		else
			-- the VIC controls the address bus

			-- ma 0..5 from VIC
			ma(5 downto 0) <= (others => 'Z');

			-- ma 6..7 from VIC for A6 and A7, and from CIA for A14 and A15
			if cas = '1' then
				ma(6) <= va6;
				ma(7) <= va7;
			else
				ma(6) <= not va14;
				ma(7) <= not va15;
			end if;
			
			-- save address for color RAM
			if ras = '1' then
				addressBuffer <= va7 & va6 & ma(5 downto 0);
			end if;
			
			-- select colram
			colram <= '0';

			-- output address for color RAM (bit 8 and 9 is connected to the VIC outside of the PLA)
			a(7 downto 0) <= addressBuffer;
		end if;
	end process;

	-- LED test
	-- The CPLD is too fast, sometimes spikes are detected at the beginning when the
	-- address lines are unstable.
	-- This process samples in the middle of a cycle, which is on falling edge of CAS.
	process(cas)
	begin
		if falling_edge(cas) then
			if io1Buffer = '0' then
				ledBuffer <= '1';
			end if;
			if io2Buffer = '0' then
				ledBuffer <= '0';
			end if;
		end if;
	end process;
	
	-- allow RAM write when RAS is 0
	ramrw <= rw or not aec or ras;

	-- A direct mapping. Might work ok but might need additional logic.
	nmi <= restore;

	-- Define directions for outputs..
	dir1 <= not aec;
	dir2 <= '0';
	aux_dir <= '1';

	-- Enable the voltage level shifters..
	oe <= '0';
	
	-- Connect the ioBuffer to the 'io' output pin..
	io <= ioBuffer;
	io1 <= io1Buffer;
	io2 <= io2Buffer;

	-- external RC delay
	misc1 <= casramBuffer;
	casram <= misc3;
	
	-- map some interesting signals to the auxiliary lines
	aux <= a(7 downto 0);
	
	-- map clock
	clk <= phi0;

	-- LED output
	misc2 <= ledBuffer;

end architecture rtl;
