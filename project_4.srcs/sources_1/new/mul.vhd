----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2023 12:13:25
-- Design Name: 
-- Module Name: mul - Behavioral
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

entity mul is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           op1 : in STD_LOGIC_VECTOR (3 downto 0);
           op2 : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (7 downto 0));
end mul;

architecture Behavioral of mul is
    type states is (s0, s1, s2, s3, s4);
    signal next_state, curr_state: states;
    signal acc: STD_LOGIC_VECTOR (7 downto 0);
    signal a: STD_LOGIC_VECTOR(7 downto 0);
    signal b: STD_LOGIC_VECTOR (3 downto 0);
    signal n: integer range 4 downto 0;
begin
    
    p_reg: process (clk, rst, next_state) 
    begin
        if rst = '1' then
            curr_state <= s0;
        else 
            if rising_edge(clk) then
                curr_state <= next_state;
            end if;
        end if;
    end process p_reg;
    
    p_state: process(curr_state, start, n, b)  
    begin
        case curr_state is 
            when s0 => 
                if start = '1' then
                    next_state <= s1;
                else 
                    next_state <= s0;
                end if;
            when s1 => 
                next_state <= s2;
            when s2 => 
                if n = 0 then 
                    next_state <= s0;
                else 
                    if b(0) = '1' then
                        next_state <= s3;
                    else
                        next_state <= s4;
                    end if;
                end if;
            when s3 => 
                next_state <= s2;
            when s4 =>
                next_state <= s2;
            when others => next_state <= s0;
        end case; 
    end process p_state;
    
    p_acc: process (rst, clk) 
    begin
        if rst = '1' then
            acc <= (others => '0');
            a <= (others => '0');
            b <= (others => '0');
        else 
            if rising_edge(clk) then
                case curr_state is
                    when s1 => 
                        acc <= (others => '0');
                        a <= "0000" & op1;
                        b <= op2;
                    when s3 => 
                        acc <= std_logic_vector(unsigned(acc) + unsigned(a));
                        a <= std_logic_vector(shift_left(unsigned(a), 1));
                        b <= std_logic_vector(shift_right(unsigned(b), 1));
                    when s4 => 
                        a <= std_logic_vector(shift_left(unsigned(a), 1));
                        b <= std_logic_vector(shift_right(unsigned(b), 1));
                    when others =>
                end case;
            end if;
        end if;
    end process p_acc;
    
    p_n: process (rst, clk) 
    begin
        if rst = '1' then
            n <= 0;
        else 
            if rising_edge(clk) then
                case curr_state is
                    when s1 => n <= 4;
                    when s3 => n <= n - 1;
                    when s4 => n <= n - 1;
                    when others =>
                end case;
            end if;
        end if;
    end process p_n;
    
    p_comb: process (curr_state)
    begin
        case curr_state is
            when s0 => done <= '1';
            when others => done <= '0';         
        end case;
    end process;
    
    result <= acc;
end Behavioral;
