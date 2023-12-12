----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2023 16:25:15
-- Design Name: 
-- Module Name: Sistema - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sistema is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ldisplay : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           leds : out STD_LOGIC_VECTOR (9 downto 0);
           inicio : in STD_LOGIC;
           fin : in STD_LOGIC);
end Sistema;

architecture Behavioral of Sistema is
    component led_gen is
        Port ( state : in STD_LOGIC_VECTOR (1 downto 0);
               clk : in STD_LOGIC;
               led_en: in STD_LOGIC;
               rst : in STD_LOGIC;
               leds : out STD_LOGIC_VECTOR (9 downto 0));
    end component led_gen;
    component divisor is
      port (
        rst        : in  std_logic;         -- asynch reset
        clk_100mhz : in  std_logic;         -- 100 MHz input clock
        clk_1hz    : out std_logic;          -- 1 Hz output clock
        cont1_en : out std_logic;
        cont2_en : out std_logic
        );
    end component divisor;
   component datos is
      Port ( 
            rst             : in  std_logic;   
            clk             : in  std_logic;
            bram_en: in std_logic;
            count1_en: in std_logic;
            count2_en: in std_logic;
            val1: out STD_LOGIC_VECTOR(3 DOWNTO 0);
            val2: out STD_LOGIC_VECTOR(3 DOWNTO 0);
            z: out STD_LOGIC
      );
    end component datos;
    
    component control is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           inicio : in STD_LOGIC;
           fin : in STD_LOGIC;
           z: in STD_LOGIC;
           bram_en: out STD_LOGIC;
           led_state: out STD_LOGIC_VECTOR(1 downto 0));
    end component control;
    
    component debouncer is
      port (
        rst             : in  std_logic;
        clk             : in  std_logic;
        x               : in  std_logic;
        xDeb            : out std_logic;
        xDebFallingEdge : out std_logic;
        xDebRisingEdge  : out std_logic
        );
    end component debouncer;
    
    component displays is
        Port ( 
            rst : in STD_LOGIC;
            clk : in STD_LOGIC;       
            digito_0 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
            display : out  STD_LOGIC_VECTOR (6 downto 0);
            display_enable : out  STD_LOGIC_VECTOR (3 downto 0)
         );
    end component displays;
    
    signal val1, val2: STD_LOGIC_VECTOR(3 downto 0);
    signal led_state: STD_LOGIC_VECTOR(1 downto 0);
    signal z, bram_en, count1_en, count2_en, clk_1hz: STD_LOGIC;
    signal fin_deb, inicio_deb: STD_LOGIC;
begin
    i_led_gen: led_gen
    port map (
        state => led_state,
        clk => clk,
        led_en => clk_1hz,
        rst => rst,
        leds => leds
    );
    i_divisor: divisor
    port map (
        rst => rst,
        clk_100mhz => clk,
        clk_1hz => clk_1hz,
        cont1_en => count1_en,
        cont2_en  => count2_en
    );
    i_datos: datos
    port map (
            rst => rst,
            clk => clk,
            bram_en => bram_en,
            count1_en => count1_en,
            count2_en => count2_en,
            val1 => val1,
            val2 => val2,
            z => z
    );
    
    i_control: control
    port map (
            rst => rst,
            clk => clk,
            bram_en => bram_en,
            z => z,
            inicio => inicio_deb,
            fin => fin_deb,
            led_state => led_state
    );
    
    i_deb_ini: debouncer
    port map (
        rst => rst,
        clk => clk,
        x => inicio,
        xDeb => open,
        xDebFallingEdge => inicio_deb,
        xDebRisingEdge => open
    );
    
    i_deb_fin: debouncer
    port map (
        rst => rst,
        clk => clk,
        x => fin,
        xDeb => open,
        xDebFallingEdge => fin_deb,
        xDebRisingEdge => open
    );
    
    i_display: displays
    port map (
        rst => rst,
        clk => clk,
        digito_0 => val1,
        digito_1 => (others => '0'),
        digito_2 => val2,
        digito_3 => (others => '0'),
        display => ldisplay,
        display_enable => an
    );
    
end Behavioral;
