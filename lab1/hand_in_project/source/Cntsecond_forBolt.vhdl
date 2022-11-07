-------------------------------------------------------------------------------
-- Title      : <Cnt second for Bolt>
-- Project    : EDA234-lab1
-------------------------------------------------------------------------------
-- File       : Cntsecond_forBolt.vhdl
-- Author     : weihanga@chalmers.se
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
use ieee.std_logic_unsigned.all;


entity Cntsecond_forBolt is
  port(
    clk : in std_logic;
    rstn: in std_logic;
    cnt_L: out std_logic_vector (3 downto 0);
    cnt_H: out std_logic_vector (2 downto 0)
    );
end entity Cntsecond_forBolt ;

architecture arch_Cntsecond_forBolt of Cntsecond_forBolt is


begin
  proc_Cnt:
  process (clk, rstn)
    variable zero_nine : std_logic_vector (3 downto 0);
    variable zero_five : std_logic_vector (2 downto 0);
  begin
    if(rstn = '0') then
      zero_nine := "0000";
      zero_five := "000";
    elsif rising_edge(clk) then
        zero_nine := zero_nine + '1';
        if(zero_nine = "1010") then
          zero_nine := "0000";
          if(zero_five = "101")then
            zero_five := "000";
          else
            zero_five := zero_five+'1';
          end if;
        end if;
      end if;
    cnt_L <= zero_nine;
    cnt_H <= zero_five;

  end process;
end architecture arch_Cntsecond_forBolt;

          
         
