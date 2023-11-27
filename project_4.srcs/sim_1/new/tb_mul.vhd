----------------------------------------------------------------------------------
-- Company:  
-- Engineer: 
-- 
-- Create Date: 26.11.2023 14:59:20
-- Design Name: 
-- Module Name: tb_mul - Behavioral
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

entity tb_mul is
--  Port ( );
end tb_mul;

architecture Behavioral of tb_mul is
    component Sistema 
        Port ( clk : in STD_LOGIC;
               start : in STD_LOGIC;
               rst : in STD_LOGIC;
               op1 : in STD_LOGIC_VECTOR (3 downto 0);
               op2 : in STD_LOGIC_VECTOR (3 downto 0);
               done : out STD_LOGIC;
               ldisplay : out STD_LOGIC_VECTOR (6 downto 0);
               an: out STD_LOGIC_VECTOR (3 downto 0);
               result: out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    signal clk, start, rst, done: STD_LOGIC;
    signal op1, op2, an: STD_LOGIC_VECTOR(3 downto 0);
    signal ldisplay: STD_LOGIC_VECTOR(6 downto 0);
    signal result: STD_LOGIC_VECTOR(7 downto 0);
    constant clk_period : time := 10 ns;
begin
    
    uut: Sistema 
    Port map (
        clk => clk,
        start => start,
        rst => rst,
        op1 => op1,
        op2 => op2,
        done => done,
        ldisplay => ldisplay,
        an => an,
        result => result
    );
    
    clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
    
    stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '0';
      wait until falling_edge(clk);	
      rst <= '1';
      
      op1 <= "1101";
      op2 <= "1101";
      start <= '0';
      wait;
   end process;

end Behavioral;
