-------------------------------------------------------------------------------
-- Title      : Top
-- Project    : EDA234-lab1
-------------------------------------------------------------------------------
-- File       : top.vhdl
-- Author     : weihanga@chalmers.se  <ASUS@LAPTOP-M6B560H3>
-- Company    : 
-- Created    : 2022-11-03
-- Last update: 2022-11-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: <cursor>
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-11-03  1.0      ASUS	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity top is
  
  port (
    CA : out STD_LOGIC;
    CB : out STD_LOGIC;
    CC : out STD_LOGIC;
    CD : out STD_LOGIC;
    CE : out STD_LOGIC;
    CF : out STD_LOGIC;
    CG : out STD_LOGIC;
    DP : out STD_LOGIC;
    AN : out STD_LOGIC_VECTOR (7 downto 0);

    clk : in STD_LOGIC;
    rstn : in STD_LOGIC);

end entity top;


architecture arch_top of top is

  component digital_show is
    Port (
    clk_sw : in STD_LOGIC;
    rstn : in STD_LOGIC;
    CA : out STD_LOGIC;
    CB : out STD_LOGIC;
    CC : out STD_LOGIC;
    CD : out STD_LOGIC;
    CE : out STD_LOGIC;
    CF : out STD_LOGIC;
    CG : out STD_LOGIC;
    DP : out STD_LOGIC;
    AN : out STD_LOGIC_VECTOR (7 downto 0);
    cnt_L : in STD_LOGIC_VECTOR (3 downto 0);
    cnt_H : in STD_LOGIC_VECTOR (2 downto 0)
    );
  end component digital_show;

  component Cntsecond_forBolt is
    port(
      clk : in std_logic;
      rstn: in std_logic;
      cnt_L: out std_logic_vector (3 downto 0);
      cnt_H: out std_logic_vector (2 downto 0)
      );
  end component Cntsecond_forBolt;

  signal cnt_L_signal : std_logic_vector(3 downto 0);
  signal cnt_H_signal : std_logic_vector(2 downto 0);
  signal clk_1s:std_logic;
  signal clk_sw:std_logic;
  signal count_1s : std_logic_vector(27 downto 0);
  signal count_sw : std_logic_vector(19 downto 0);
  
begin  -- architecture arch_top
  digital_show_1: digital_show
    port map (
      clk_sw => clk_sw,
      rstn => rstn,
      CA => CA,
      CB => CB,
      CC => CC,
      CD => CD,
      CE => CE,
      CF => CF,
      CG => CG,
      DP => DP,
      AN => AN,
      cnt_H => cnt_H_signal,
      cnt_L => cnt_L_signal);
      
  Cntsecond_forBolt_1: Cntsecond_forBolt
    port map (
      clk   => clk_1s,
      rstn  => rstn,
      cnt_L => cnt_L_signal,
      cnt_H => cnt_H_signal);
  
  
  proc_clk: process (clk,rstn)
  begin  -- process proc_clk
    if rstn='0' then
      clk_1s <= '0';
      count_1s <= x"0000000";
      --clk_sw <= '0';
    elsif rising_edge(clk) then
      if count_1s=x"2faf07f" then
      --if count_1s=x"00000010" then
        count_1s <= x"0000000";
        clk_1s <= not(clk_1s);
      else 
        count_1s <= conv_std_logic_vector((unsigned(count_1s)+1),28);
        
      end if;
      
      -- if ("000000000000000000" = count_1s(17 downto 0)) then
      -- --if ("000" = count_1s(2 downto 0)) then
      --   clk_sw <= not(clk_sw);
      -- else
      --   --clk_sw <= clk_sw;
      -- end if;
           
    end if;
  end process proc_clk;

 proc_clk_sw: process (clk,rstn)
  begin  -- process proc_clk
    if rstn='0' then
      count_sw <= x"00000";
      clk_sw <= '0';
    elsif rising_edge(clk) then
      if count_sw=x"7a120" then
      --if count_1s=x"00000010" then
        count_sw <= x"00000";
        clk_sw <= not(clk_sw);
      else 
        count_sw <= conv_std_logic_vector((unsigned(count_sw)+1),20);       
      end if;
      
    end if;
  end process proc_clk_sw;

  
  
end architecture arch_top;
