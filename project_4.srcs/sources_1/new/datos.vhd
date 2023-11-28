---------------------------------------------------------------------------------- 
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2023 19:36:31
-- Design Name: 
-- Module Name: datos - Behavioral
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

entity datos is
  Port ( 
    op1 : in STD_LOGIC_VECTOR (3 downto 0);
    op2 : in STD_LOGIC_VECTOR (3 downto 0);
    rst: in STD_LOGIC;
    clk: in STD_LOGIC;
    b_1: out STD_LOGIC;
    n_0: out STD_LOGIC;
    result: out STD_LOGIC_VECTOR (7 downto 0);
    a_reg: in STD_LOGIC;
    b_reg: in STD_LOGIC;
    n_reg: in STD_LOGIC;
    n_red: in STD_LOGIC;
    acc_reg: in STD_LOGIC;
    acc_0: in STD_LOGIC;
    a_shift: in STD_LOGIC;
    b_shift: in STD_LOGIC
  );
end datos;

architecture Behavioral of datos is
    signal acc: STD_LOGIC_VECTOR (7 downto 0);
    signal a: STD_LOGIC_VECTOR(7 downto 0);
    signal b: STD_LOGIC_VECTOR (3 downto 0);
    signal n: integer range 4 downto 0;
begin
    p_acc: process (rst, clk) 
    begin
        if rst = '1' then
            acc <= (others => '0');
        elsif rising_edge(clk) then
            if acc_reg = '1' then
                if acc_0 = '1' then
                    acc <= (others => '0');
                else 
                    acc <= std_logic_vector(unsigned(acc) + unsigned(a));
                end if;
            end if;
        end if;
    end process;

    p_a: process (rst, clk) 
    begin
        if rst = '1' then
            a <= (others => '0');
        elsif rising_edge(clk) then
            if a_reg = '1' then
                a <= "0000" & op1;
            else 
                if a_shift = '1' then
                     a <= std_logic_vector(shift_left(unsigned(a), 1));
                end if;
            end if;
            
        end if;
    end process;
    
    p_b: process (rst, clk) 
    begin
        if rst = '1' then
            b <= (others => '0');
        elsif rising_edge(clk) then
            if b_reg = '1' then
                b <= op2;
            else 
                if b_shift = '1' then
                     b <= std_logic_vector(shift_right(unsigned(b), 1));
                end if;
            end if;
            
        end if;
    end process;
    
    p_n: process (rst, clk) 
    begin
        if rst = '1' then
            n <= 0;
        elsif rising_edge(clk) then
            if n_reg = '1' then
                if n_red = '1' then 
                    n <= n -1;
                else 
                    n <= 4;
                end if;
            end if;
        end if;
    end process p_n;
    
    p_sal: process (n, b, acc) 
    begin 
        if n = 0 then
            n_0 <= '1';
        else
            n_0 <= '0';
        end if;
        b_1 <= b(0);
        result <= acc;
    end process;
    
end Behavioral;
