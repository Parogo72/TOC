----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 12:25:58
-- Design Name: 
-- Module Name: led_gen - Behavioral
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

entity led_gen is
    Port ( state : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ini_state: in STD_LOGIC_VECTOR(9 downto 0);
           leds : out STD_LOGIC_VECTOR (9 downto 0));
end led_gen;

architecture Behavioral of led_gen is
    signal leds_reg: STD_LOGIC_VECTOR(9 downto 0);
    signal int_reset: std_logic;
begin
    p_reg: process(clk, rst)
    begin
        if rst = '1' then
            leds_reg <= (others => '0');
            int_reset <= '1';
        elsif rising_edge(clk) then
            if int_reset = '0' then 
               case state is
                when "00" => 
                    leds_reg <= (others => '0');
                when "01" => 
                    leds_reg <= not leds_reg(0) & leds_reg(9 downto 1);
                when "10" => 
                    leds_reg <= not leds_reg;
                when "11" => 
                    leds_reg <= not leds_reg;
                when others => 
                    leds_reg <= (others => '0');
               end case;
           else
             case state is
                when "00" => 
                    leds_reg <= (others => '0');
                when "01" => 
                    leds_reg <= (others => '0');
                when "10" => 
                    leds_reg <= "0101010101";
                when "11" => 
                    leds_reg <= (others => '0');
                when others => 
                    leds_reg <= (others => '0');
            end case;
            int_reset <= '0';
           end if;
       end if;
   end process;
   
   leds <= leds_reg;
end Behavioral;
