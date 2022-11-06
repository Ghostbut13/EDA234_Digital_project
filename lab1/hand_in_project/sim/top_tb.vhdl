library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

ENTITY top_tb IS

END ENTITY top_tb;


ARCHITECTURE arch_top_tb of top_tb IS
  COMPONENT top IS 
  PORT(
    CA : out STD_LOGIC;
    CB : out STD_LOGIC;
    CC : out STD_LOGIC;
    CD : out STD_LOGIC;
    CE : out STD_LOGIC;
    CF : out STD_LOGIC;
    CG : out STD_LOGIC;
    DP : out STD_LOGIC;
    AN : out STD_LOGIC_VECTOR (7 downto 0);
    clk_sw : in STD_LOGIC;
    rstn : in STD_LOGIC);
  END COMPONENT top;

  signal CA_signal : std_logic;
  signal CB_signal : std_logic;
  signal CC_signal : std_logic;
  signal CD_signal : std_logic;
  signal CE_signal : std_logic;
  signal CF_signal : std_logic;
  signal CG_signal : std_logic;
  signal DP_signal : std_logic;
  signal AN_signal : STD_LOGIC_VECTOR(7 downto 0);
  signal clk_sw_signal : std_logic:='0';
  signal rstn_signal : std_logic;

  
BEGIN 
  
  top_1:
  COMPONENT top
    PORT MAP(
      CA =>CA_signal,
      CB =>CB_signal,
      CC =>CC_signal,
      CD =>CD_signal,
      CE =>CE_signal,
      CF =>CF_signal,
      CG =>CG_signal,
      DP =>DP_signal,
      AN =>AN_signal,
      clk_sw => clk_sw_signal,
      rstn => rstn_signal);
  

  clk_tb_proc:    
  PROCESS 
  BEGIN
    WAIT FOR 5 ns; 
    clk_sw_signal <= NOT(clk_sw_signal);
  END PROCESS clk_tb_proc;

  
  rstn_signal <= '1',
                      '0' after 150 ns,
                      '1' after 300 ns;
    


End Architecture;
