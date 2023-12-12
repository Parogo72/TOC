----------------------------------------------------------------------------------
-- Company:        Universidad Complutense de Madrid
-- Engineer:       
-- 
-- Create Date:    
-- Design Name:    Practica 1b 
-- Module Name:    divisor - rtl
-- Project Name:   Practica 1b 
-- Target Devices: Spartan-3 
-- Tool versions:  ISE 14.1
-- Description:    Creacion de un reloj de 1 Hz a partir de un reloj de 100 MHz
-- Dependencies: 
-- Revision: 
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor is
  port (
    rst        : in  std_logic;         -- asynch reset
    clk_100mhz : in  std_logic;         -- 100 MHz input clock
    clk_1hz    : out std_logic;          -- 1 Hz output clock
    cont1_en : out std_logic;
    cont2_en : out std_logic
    );
end divisor;

architecture rtl of divisor is
  signal cntr_reg    : unsigned(24 downto 0);
  signal cont1_reg    : unsigned(25 downto 0);
  signal cont2_reg    : unsigned(18 downto 0);
  signal clk_1hz_reg, cont1_en_reg, cont2_en_reg : std_logic;
begin

  p_cntr : process(rst, clk_100mhz)
  begin
    if (rst = '1') then
      cntr_reg    <= (others => '0');
      clk_1hz_reg <= '0';
    elsif rising_edge(clk_100mhz) then
      if cont1_reg = (25 downto 0 => '1') then 
        cont1_reg <= (others => '0');
        cont1_en_reg <= not cont1_en_reg;
      else 
        cont1_reg <= cont1_reg + 1;
        cont1_en_reg <= cont1_en_reg;
      end if;
      
      if cont2_reg = (18 downto 0 => '1') then 
        cont2_reg <= (others => '0');
        cont2_en_reg <= not cont2_en_reg;
      else 
        cont2_reg <= cont2_reg + 1;
        cont2_en_reg <= cont2_en_reg;
      end if;
      
      if cntr_reg = (24 downto 0 => '1') then
        cntr_reg    <= (others => '0');
        clk_1hz_reg <= not clk_1hz_reg;
      else
        cntr_reg    <= cntr_reg + 1;
        clk_1hz_reg <= clk_1hz_reg;
      end if;
    end if;
  end process p_cntr;

  output_clock : clk_1hz <= clk_1hz_reg;
  output_cont1 : cont1_en <= cont1_en_reg;
  output_cont2 : cont2_en <= cont2_en_reg;
end rtl;