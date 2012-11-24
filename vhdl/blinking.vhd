library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Blinking is
	port(
		dir1: out std_logic;
		dir2: out std_logic;

		oe: out std_logic;

		kernal: out std_logic;
		cia2: out std_logic;
		casram: out std_logic;
		ramr_w: out std_logic;
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
		romlo: out std_logic;
		io2: out std_logic;
		romh: out std_logic;
		io1: out std_logic;
		nmi: out std_logic;
		va7: in std_logic;
		r_w: in std_logic;
		loram: in std_logic;
		charen: in std_logic;
		hiram: in std_logic;
		va14: in std_logic;
		va15: in std_logic;
		restore: in std_logic;
		game: in std_logic;

		clk: in std_logic;

		aux_dir: out std_logic;
		aux: inout std_logic_vector(7 downto 0);

		misc1: out std_logic;
		misc2: out std_logic;
		misc3: out std_logic
	);
end Blinking;

architecture rtl of Blinking is

constant FREQUENCY: natural := 1;
constant CYCLES: natural := 10e6 / FREQUENCY / 2;
signal counter: integer range 0 to CYCLES := CYCLES;
signal blinkBuffer: std_logic;

begin

	process(clk)
	begin
		if rising_edge(clk) then 
			if counter < CYCLES then
				counter <= Counter + 1;
			else
				counter <= 0;
				blinkBuffer <= not blinkBuffer;
			end if;
		end if;
	end process;
	
	-- directions to output
	dir1 <= '1';
	dir2 <= '1';
	aux_dir <= '1';

	-- enable voltage level shifters
	oe <= '0';

	-- red LED blinking with 1 Hz for 10 MHz input at clk
	misc2 <= blinkBuffer;

	-- for testing: 10 MHz clock to misc1 and inverted signal to misc3
	misc1 <= clk;
	misc3 <= not clk;

	-- rest to 1 or tri-state
	kernal <= '1';
	cia1 <= '1';
	cia2 <= '1';
	casram <= '1';
	ramr_w <= '1';
	charom <= '1';
	basic <= '1';
	io <= '1';
	colram <= '1';
	ma <= (others => '1');
	a(7 downto 0) <= (others => '1');
	a(15 downto 8) <= (others => 'Z');
	ma <= (others => '1');
	sid <= '1';
	vic <= '1';
	romlo <= '1';
	io2 <= '1';
	romh <= '1';
	io1 <= '1';
	nmi <= '1';

end architecture rtl;
