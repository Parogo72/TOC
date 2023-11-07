----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2023 22:14:36
-- Design Name: 
-- Module Name: reg_div - Behavioral
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

entity reg_div is
    Port ( rst : in STD_LOGIC;
           load : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC);
end reg_div;

architecture Behavioral of reg_div is
    component divisor 
        port (
            rst        : in  std_logic;         -- asynch reset
            clk_100mhz : in  std_logic;         -- 100 MHz input clock
            clk_1hz    : out std_logic          -- 1 Hz output clock
        );
    end component;
    
    component pipo
        port( d: in std_logic_vector(3 downto 0);
            rst: in std_logic;
            clk: in std_logic;
            load: in std_logic;
            q: out std_logic_vector(3 downto 0) 
        );
    end component;
    signal clk_1hz: std_logic;
begin
    i_d: divisor
    port map (
        rst => rst,
        clk_100mhz => clk,
        clk_1hz => clk_1hz
    );
    
    i_p: pipo
    port map (
        rst => rst,
        d => d,
        clk => clk_1hz,
        q => q,
        load => load
    );
end Behavioral;
