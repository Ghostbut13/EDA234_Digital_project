-------------------------------------------------------------------------------
-- Title      : <title string>
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top.vhdl
-- Author     :   <ASUS@LAPTOP-M6B560H3>
-- Company    : 
-- Created    : 2022-11-03
-- Last update: 2022-11-05
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

    --clk : in STD_LOGIC;
    clk_sw : in STD_LOGIC;
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
      EC: out std_logic;
      cnt_L: out std_logic_vector (3 downto 0);
      cnt_H: out std_logic_vector (2 downto 0)
      );
  end component Cntsecond_forBolt;

  signal cnt_L_signal : std_logic_vector(3 downto 0);
  signal cnt_H_signal : std_logic_vector(2 downto 0);
  signal EC_signal : std_logic;
  signal clk_1s:std_logic;
  signal count_1s : integer;
  
  
  
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
      EC    => EC_signal,
      cnt_L => cnt_L_signal,
      cnt_H => cnt_H_signal);
  
  
  proc_clk: process (clk_sw,rstn) is
  begin  -- process proc_clk
    if rstn='0' then
      clk_1s <= '0';
      count_1s <= 0;
    elsif rising_edge(clk_sw) then
      --if count_1s=10000000 then
	if count_1s=10 then
        count_1s <= 0;
        clk_1s <= not(clk_1s);
      else
        count_1s <= count_1s+1;
      end if;
    end if;
  end process proc_clk;
  
end architecture arch_top;
