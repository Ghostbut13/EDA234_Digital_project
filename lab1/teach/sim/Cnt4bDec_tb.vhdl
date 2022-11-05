-----------------------
-- counter_tb3.vhdl  --
-- test bench type 3 --
-- for counter       --
-----------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Cnt4b_tb IS
  
END Cnt4b_tb;

ARCHITECTURE arch_Cnt4b_tb OF Cnt4b_tb IS

  COMPONENT Cnt4b IS
     PORT ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Cnt : out STD_LOGIC_VECTOR (3 downto 0);
           EC : out STD_LOGIC);
   END COMPONENT Cnt4b;

   SIGNAL clk_tb_signal:STD_LOGIC:='1';
   SIGNAL reset_n_tb_signal:STD_LOGIC;
   SIGNAL ce_tb_signal:STD_LOGIC:='1';
   SIGNAL count_tb_signal:STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL ec_tb_signal:STD_LOGIC;

BEGIN
   counter_comp:
   COMPONENT Cnt4b
     PORT MAP(  clk=> clk_tb_signal,
                 reset=> reset_n_tb_signal,
                 CE => ce_tb_signal,
                 Cnt=> count_tb_signal,
	         EC=> ec_tb_signal);

   reset_n_tb_signal<='1', 
                '0' AFTER 125 ns,
                '1' AFTER 325 ns,
                '0' AFTER 1825 ns,
                '1' AFTER 2025 ns;
                
   clk_proc:
   PROCESS
   BEGIN
      WAIT FOR 50 ns;
      clk_tb_signal<=NOT(clk_tb_signal);
   END PROCESS clk_proc;

   test_proc:
   PROCESS
   BEGIN
      WAIT FOR 150 ns; -- 150 ns
      ASSERT (reset_n_tb_signal='0' AND count_tb_signal(3 downto 0)="0000")
      REPORT "Error for reset_n=0 and count=0000"
      SEVERITY ERROR;
      WAIT FOR 200 ns; -- 350 ns
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="0000")
      REPORT "Error for reset_n=1 and count=0000"
      SEVERITY ERROR;
      WAIT FOR 100 ns; -- 450 ns
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="0001")
      REPORT "Error for reset_n=1 and count=0001"
      SEVERITY ERROR;
      WAIT FOR 700 ns; --  1150 ns
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="1000" AND ec_tb_signal='0')
      REPORT "Error for reset_n=1 and count=1000 and EC=0"
      SEVERITY ERROR;
      WAIT FOR 100 ns; -- 1250 ns Cnt = 9, EC =1
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="1001" AND ec_tb_signal='1')
      REPORT "Error for reset_n=1 and count=1001 and EC=1"
      SEVERITY ERROR;
      WAIT FOR 100 ns; -- 1350 ns Cnt = 0, EC =0
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="0000" AND ec_tb_signal='0')
      REPORT "1350 ns Error for reset_n=1 and count=0000 and EC=0"
      SEVERITY ERROR;
      WAIT FOR 100 ns; -- 1450 ns Cnt = 1, EC =0
      ASSERT (reset_n_tb_signal='1' AND count_tb_signal(3 downto 0)="0001" AND ec_tb_signal='0')
      REPORT "1450ns Error for reset_n=1 and count=0000 and EC=0"
      SEVERITY ERROR;

      WAIT FOR 2000 ns;

   END PROCESS test_proc;

END arch_Cnt4b_tb;