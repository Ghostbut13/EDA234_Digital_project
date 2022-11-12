-------------------------------------------------------------------------------
-- Title      : serial_port(UART) receiver
-- Project    : EDA234
-------------------------------------------------------------------------------
-- File       : sp.vhdl
-- Author     : weihanga@chalmers.se
-- Company    : 
-- Created    : 2022-11-12
-- Last update: 2022-11-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  : 1.0
-- Date        Version  Author  Description
-- 2022-11-12  1.0      ASUS	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.unsigned.all;

entity serial_port_receiver is
  -- generic(
  --   mode:boolean:=true;
  --   -- ...
  --   );
  port(
    clk : in std_logic;
    rstn £ºin std_logic;
    uart_rxd : in std_logic;
    uart_data : out std_logic_vector(7 downto 0);
    uart_done : out std_logic;
    );
end entity serial_port_receiver;

architecture arch_serial_port_receiver of serial_port_receiver is

  constant uart_bps : integer := 96000;
  constant clk_frq : integer := 100000000;
  constant bps_cnt : integer := clk_frq / uart_bps;

  signal uart_rxd_d1 : std_logic;  -- rxd
  signal uart_rxd_d2 : std_logic;
  signal uart_done_signal : std_logic;  -- done
  signal cnt_rx : integer;
  signal cnt_clk : integer;

  signal buffer_data8 : std_logic_vector(7 downto 0);
  
  variable data_start_flag : std_logic;

begin  -- architecture arch_serial_port_receiver

  proc_cnt: process (clk, rstn) is
  begin  -- process proc_cnt
    if rstn = '0' then                  -- asynchronous reset (active low)
      cnt_clk <= 0;
      cnt_rx <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if data_start_flag='1' then
        if cnt_clk < CNT_BPS then
          cnt_clk <= cnt_clk +1;
          cnt_rx <= cnt_rx;
        else
          cnt_clk <= 0;
          cnt_rx <= cnt_rx +1;
        end if;
      else
        cnt_clk <= 0;
        cnt_rx <= 0;
      end if;
    end if;
  end process proc_cnt;

  -- 
  proc_rx_falledge_detect: process (clk, rstn) is
  begin  -- process proc_rx_falledge_detect
    if rstn = '0' then                  -- asynchronous reset (active low)
      uart_rxd_d1 <= '0';
      uart_rxd_d2 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      uart_rxd_d1 <= uart_rxd;
      uart_rxd_d2 <= uart_rxd_d1;
    end if;
    data_start_flag <= uart_rxd_d1 and not(uart_rxd_d2);
  end process proc_rx_falledge_detect;

  

  proc_data_tran: process (clk, rstn) is
  begin  -- process proc_rx
    if rstn = '0' then                  -- asynchronous reset (active low)
      buffer_data8 <= "0000000"
    elsif rising_edge(clk) then  -- rising clock edge
        if data_start_flag='1' then
          case cnt_rx is
            when buffer_data8(0) => uart_data;
            when others => null;
          end case;
        end if;
      buffer_data8 <= 
    end if;
  end process proc_data_tran;

end architecture arch_serial_port_receiver;
