----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2023 19:36:31
-- Design Name: 
-- Module Name: control - Behavioral
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
  Port ( 
    rst: in STD_LOGIC;
    clk: in STD_LOGIC;
    b_1: in STD_LOGIC;
    n_0: in STD_LOGIC;
    start: in STD_LOGIC;
    a_reg: out STD_LOGIC;
    b_reg: out STD_LOGIC;
    n_reg: out STD_LOGIC;
    n_red: out STD_LOGIC;
    acc_reg: out STD_LOGIC;
    acc_0: out STD_LOGIC;
    a_shift: out STD_LOGIC;
    b_shift: out STD_LOGIC;
    done: out STD_LOGIC
  );
end control;

architecture Behavioral of control is
    type states is (s0, s1, s2, s3, s4);
    signal next_state, curr_state: states;
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
    
    p_state: process(curr_state, start, n_0, b_1)  
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
                if n_0 = '1' then 
                    next_state <= s0;
                else 
                    if b_1 = '1' then
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
    
    p_sal: process (curr_state) 
    begin
        case curr_state is
            when s0 =>
                a_reg <= '0';
                b_reg <= '0';
                n_reg <= '0';
                acc_reg <= '0';
                acc_0 <= '0';
                a_shift <= '0';
                b_shift <= '0';
                done <= '1';
                n_red <= '0';
            when s1 =>
                a_reg <= '1';
                b_reg <= '1';
                n_reg <= '1';
                acc_reg <= '1';
                acc_0 <= '1';
                a_shift <= '0';
                b_shift <= '0';
                done <= '0';
                n_red <= '0';
            when s2 =>
                a_reg <= '0';
                b_reg <= '0';
                n_reg <= '0';
                acc_reg <= '0';
                acc_0 <= '0';
                a_shift <= '0';
                b_shift <= '0';
                done <= '0';
                n_red <= '0';
            when s3 =>
                a_reg <= '0';
                b_reg <= '0';
                n_reg <= '1';
                acc_reg <= '1';
                acc_0 <= '0';
                a_shift <= '1';
                b_shift <= '1';
                done <= '0';
                n_red <= '1';
            when s4 =>
                a_reg <= '0';
                b_reg <= '0';
                n_reg <= '1';
                acc_reg <= '0';
                acc_0 <= '0';
                a_shift <= '1';
                b_shift <= '1';
                done <= '0';
                n_red <= '1';
            when others =>
                a_reg <= '0';
                b_reg <= '0';
                n_reg <= '0';
                acc_reg <= '0';
                acc_0 <= '0';
                a_shift <= '0';
                b_shift <= '0';
                done <= '0';
                n_red <= '0';
            end case;
    end process;
end Behavioral;
