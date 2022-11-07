-------------------------------------------------------------------------------
-- Title      : Counting_clk_TESTBENCH
-- Project    : EDA234-lab1
-------------------------------------------------------------------------------
-- File       : Cntsecond_forBolt_tb3.vhdl
-- Author     :   <ASUS@LAPTOP-M6B560H3>
-- Company    : 
-- Created    : 2022-11-02
-- Last update: 2022-11-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: second counter 0 to 59
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-11-02  1.0      ASUS	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Cntsecond_forBolt_tb3 is
  
end entity Cntsecond_forBolt_tb3;



architecture arch_Cntsecond_forBolt_tb3 of Cntsecond_forBolt_tb3 is

  component Cntsecond_forBolt is
    port (
      clk : in std_logic;
      rstn : in std_logic;
      cnt_H : out std_logic_vector(2 downto 0);
      cnt_L : out std_logic_vector(3 downto 0)
      );
  end component Cntsecond_forBolt;

  signal clk_tb3_signal : std_logic := '1';
  signal rstn_tb3_signal : std_logic;
  signal ce_tb3_signal : std_logic := '1';
  signal count_L_tb3_signal : std_logic_vector(3 downto 0);
  signal count_H_tb3_signal : std_logic_vector(2 downto 0);

  signal cnt_clk1s_tb3_signal: integer := 0;

begin
  counter:
    component Cntsecond_forBolt
      port map (
        clk => clk_tb3_signal,
        rstn => rstn_tb3_signal,
        cnt_L => count_L_tb3_signal,
        cnt_H => count_H_tb3_signal);
  

  rstn_tb3_signal <= '1',
                     '0' after 100 ns,
                     '1' after 300 ns;
  --'0' after 1825 ns,
  --'1' after 2025 ns;

  
  proc_clk:
  process
  begin
    wait for 100 ns;
    clk_tb3_signal <= NOT(clk_tb3_signal);
  end process proc_clk;

  proc_test_cnt:
  process (clk_tb3_signal)
  begin
    if(cnt_clk1s_tb3_signal = 59) then
      cnt_clk1s_tb3_signal<=0;
    else
      cnt_clk1s_tb3_signal<=cnt_clk1s_tb3_signal+1;
    end if;
  end process proc_test_cnt;



  
  proc_test_algorithm:
  process
  begin
    wait for 400 ns;
    for i in 500 downto 1 loop
      assert (cnt_clk1s_tb3_signal=
              (10*unsigned(count_H_tb3_signal)+
               unsigned(count_L_tb3_signal))) 
      report "Error in count_1s algorithm" 
      severity error;
      wait for 100 ns;
    end loop;
  end process proc_test_algorithm;
  
end architecture;
