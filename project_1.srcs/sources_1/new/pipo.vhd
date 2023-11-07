----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2023 16:51:46
-- Design Name: 
-- Module Name: pipo - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipo is
    port( d: in std_logic_vector(3 downto 0);
    rst: in std_logic;
    clk: in std_logic;
    load: in std_logic;
    q: out std_logic_vector(3 downto 0) );
end pipo;

architecture rtl of pipo is
begin
    p_ff : process (clk, rst) is
    begin
        if rst = '1' then
            q <= (others => '0');
        elsif rising_edge(clk) then
            if (load = '1') then 
                q <= d;
            end if;
        end if;
    end process p_ff;
end rtl;