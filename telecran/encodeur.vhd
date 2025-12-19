library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encodeur is
	generic (
		CNT_MAX : positive := 10;
		CLOCK_DIV : positive := 50000
	);
 
	port (
		i_clk : in std_logic;
		i_rst_n : in std_logic;
		i_ch_a : in std_logic;
		i_ch_b : in std_logic;
		i_pb : in std_logic;
		
		o_compteur : out natural range 0 to CNT_MAX-1 := 0
	);
end entity encodeur;
 
architecture rtl of encodeur is
	signal r_a_prev : std_logic := '0';
	signal r_b_prev : std_logic := '0';

 
begin

	process(i_ch_a, i_ch_b)
		variable counter_clk : natural range 0 to CLOCK_DIV := 0;
		variable compteur : natural range 0 to CNT_MAX-1 := 0;
		variable vector : std_logic_vector(CNT_MAX-1 downto 0);
	begin
		if (i_rst_n = '0') then 
			compteur := 0;
			vector := (others => '0');
		
		elsif (rising_edge(i_clk)) then
		
			if (counter_clk = CLOCK_DIV) then
				counter_clk := 0;
				
				if (r_a_prev = '0' and i_ch_a = '1')  and i_ch_b = '0' then 
					if (compteur = 0) then 
						compteur := 0;
					else 
						compteur := compteur - 1;
					end if;
					
				end if;
					
				if (r_b_prev = '0' and i_ch_b = '1') and i_ch_a = '0' then 
					if (compteur >= CNT_MAX-1) then 
						compteur := CNT_MAX-1;
					else
						compteur := compteur + 1;
					end if; 
				end if;
				
				r_a_prev <= i_ch_a;
				r_b_prev <= i_ch_b;
				
				
			else 
				counter_clk := counter_clk + 1;
				
			end if;

		
		end if;
		
		vector := (others => '0');
		vector(compteur) := '1';
		o_compteur <= compteur;

	end process;
	
	
 
end architecture rtl;