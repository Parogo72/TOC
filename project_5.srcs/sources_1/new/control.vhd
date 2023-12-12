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

entity control is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           inicio : in STD_LOGIC;
           fin : in STD_LOGIC;
           z: in STD_LOGIC;
           bram_en: out STD_LOGIC;
           led_state: out STD_LOGIC_VECTOR(1 downto 0));
end control;

architecture Behavioral of control is
    type state is (s0, s1, s2);
    
    signal curr_state, next_state: state;
begin
    p_reg_state: process(clk ,rst) 
    begin
        if rst = '1' then
            curr_state <= s0;
        elsif rising_edge(clk) then
            curr_state <= next_state;
        end if;
    end process;
    p_nextState: process(curr_state, inicio, fin)
    begin
        case curr_state is
            when s0 => 
                if inicio = '1' then
                    next_state <= s1;
                else next_state <= s0;
                end if;
            when s1 =>
                if fin = '1' then
                    next_state <= s2;
                else next_state <= s1;
                end if;
            when s2 => 
                if inicio = '1' then
                    next_state <= s1;
                else next_state <= s2;
                end if;
            when others => 
                next_state <= s0;
        end case;
    end process;
    
    p_sal: process(curr_state, z)
    begin
        case curr_state is
            when s0 => 
                bram_en <= '0';
                led_state <= "01";
            when s1 =>
                bram_en <= '1';
                led_state <= "00";
            when s2 => 
                bram_en <= '0';
                if z = '1' then
                    led_state <= "10";
                else led_state <= "11";
                end if;
            when others => 
                bram_en <= '0';
                led_state <= "00";
        end case;
    end process;
    
end Behavioral;
