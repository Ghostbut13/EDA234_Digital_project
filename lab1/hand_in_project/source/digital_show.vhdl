-------------------------------------------------------------------------------
-- Title      : Digital segments showing 
-- Project    : EDA234-LAB1
-------------------------------------------------------------------------------
-- File       : digital_show.vhdl
-- Author     : weihanga@chalmers.se>
-- Company    : 
-- Created    : 2022-11-06
-- Last update: 2022-11-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: show the numbers from the second counter on digital segment
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-11-06  1.0      ASUS	Created
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digital_show is
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
end digital_show;

architecture arch_digital_show of digital_show is
  signal digital : std_logic_vector(6 downto 0);
  signal sel : std_logic;
  signal AN_TURN_ON : std_logic_vector(7 downto 0);
  signal show_number : std_logic_vector(3 downto 0);
  
begin
  
  L: process (clk_sw, rstn) is
  begin
    if(rstn ='0') then
      digital <= "0000000";
      sel <= '1';
      AN_TURN_ON<="11111110";
    elsif rising_edge(clk_sw) then
     sel<='1';
      if(sel='1') then
        AN_TURN_ON<="11111101";
        show_number <= '0'&cnt_H;
      elsif(sel='0') then
        AN_TURN_ON<="11111110";
        show_number <= cnt_L;
      end if; 
        case show_number is
        when "0000" =>
          digital <= "1000000";
        when "0001" =>
          digital <= "1111001";
        when "0010" =>
          digital <= "0100100";
        when "0011" =>
          digital <= "0110000";
        when "0100" =>
          digital <= "0011001";
        when "0101" =>
          digital <= "0010010";
        when "0110" =>
          digital <= "0000010";
        when "0111" =>
          digital <= "1111000";
        when "1000" =>
          digital <= "0000000";
        when "1001" =>
          digital <= "0010000";
          
        when others => 
        digital <="1111111";
      end case;
      sel <= not(sel);
    end if;
    
  end process L;
  
  AN<=AN_TURN_ON;
  CA<=digital(0);
  CB<=digital(1);
  CC<=digital(2);
  CD<=digital(3);
  CE<=digital(4);
  CF<=digital(5);
  CG<=digital(6);
  DP<='1';

end arch_digital_show;
