library ieee;
use ieee.std_logic_1164.all;

entity encodeur_tb is
end entity encodeur_tb;

architecture tb of encodeur_tb is
    constant cnt_max : positive := 10;
    constant clock_div : positive := 1;

    signal tb_i_clk : std_logic := '0';
    signal tb_i_rst_n : std_logic := '0';

    signal tb_i_ch_a : std_logic;
    signal tb_i_ch_b : std_logic;
    signal tb_pb : std_logic;

    signal tb_o_compteur : natural range 0 to cnt_max-1 := 0;

    constant CLK_PERIOD : time := 20 ns;

begin
    -- Processus de génération de clock
    clk_process : process
    begin
        for i in 0 to 10000 loop
            tb_i_clk <= '0';
            wait for CLK_PERIOD / 2;  -- moitié de la période
            tb_i_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    uut : entity work.encodeur
    generic map (
		CNT_MAX => cnt_max,
		CLOCK_DIV => clock_div
	)
    port map
    (
        i_clk => tb_i_clk,
        i_rst_n => tb_i_rst_n,

        i_ch_a => tb_i_ch_a,
        i_ch_b => tb_i_ch_b,
        i_pb => tb_pb,

        o_compteur => tb_o_compteur
    );

    process
    begin
        tb_pb <= '0';
        tb_i_ch_b <= '0';
        tb_i_rst_n <= '1';

        for i in 0 to 3 loop
            -- ==> coompteur +1
            tb_i_ch_a <= '0';
            tb_i_ch_b <= '0';
            wait for 100 ns; 
            tb_i_ch_b <= '1';
            wait for 100 ns;
        end loop;

        -- ==> compteur -1
        tb_i_ch_b <= '0';
        tb_i_ch_a <= '0';
        wait for 100 ns;
        tb_i_ch_a <= '1';
        wait for 100 ns;

        -- reset à 0 ==> raz du compteur
        tb_i_rst_n <= '0';
        wait for 100 ns;

        -- reset à 1 
        tb_i_rst_n <= '1';

        for i in 0 to 15 loop
            -- ==> coompteur +1
            tb_i_ch_a <= '0';
            tb_i_ch_b <= '0';
            wait for 100 ns; 
            tb_i_ch_b <= '1';
            wait for 100 ns;
        end loop;

        for i in 0 to 15 loop
            -- ==> compteur -1
            tb_i_ch_b <= '0';
            tb_i_ch_a <= '0';
            wait for 100 ns;
            tb_i_ch_a <= '1';
            wait for 100 ns;
        end loop;

        wait for 5000 ns;
        wait;
    end process;
end architecture tb;