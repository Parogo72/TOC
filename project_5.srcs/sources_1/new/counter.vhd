----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2023 16:27:49
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (3 downto 0));
end counter;

architecture Behavioral of counter is
    signal cnt: STD_LOGIC_VECTOR (3 downto 0);
begin

    p_reg: process(clk, rst, enable)
    begin
        if rst = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) and enable = '1' then
            if unsigned(cnt) >= 10 then
                cnt <= (others => '0');
            else cnt <= std_logic_vector(unsigned(cnt) + 1);
            end if;
        end if;
    end process;
    
    q <= cnt;
end Behavioral;
