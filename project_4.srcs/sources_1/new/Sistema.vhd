---------------------------------------------------------------------------------- 
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2023 11:53:51
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
           start : in STD_LOGIC;
           rst : in STD_LOGIC;
           op1 : in STD_LOGIC_VECTOR (3 downto 0);
           op2 : in STD_LOGIC_VECTOR (3 downto 0);
           done : out STD_LOGIC;
           ldisplay : out STD_LOGIC_VECTOR (6 downto 0);
           an: out STD_LOGIC_VECTOR (3 downto 0);
           result: out STD_LOGIC_VECTOR (7 downto 0));
end Sistema;

architecture Behavioral of Sistema is
    component debouncer
        port (
            rst             : in  std_logic;
            clk             : in  std_logic;
            x               : in  std_logic;
            xDeb            : out std_logic;
            xDebFallingEdge : out std_logic;
            xDebRisingEdge  : out std_logic
        );
    end component;
    
    component displays 
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
    end component;
    
    component fsm
        Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           op1 : in STD_LOGIC_VECTOR (3 downto 0);
           op2 : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    signal rst_inv: STD_LOGIC;
    signal start_inv: STD_LOGIC;
    signal start_s: STD_LOGIC;
    signal acc: STD_LOGIC_VECTOR(7 downto 0);
begin
    rst_inv <= not rst;
    start_inv <= not start;
    
    i_deb: debouncer
    Port map (
        rst => rst_inv,
        clk => clk,
        x => start_inv,
        xDeb => open,
        xDebFallingEdge => start_s,
        xDebRisingEdge => open
    );
    
    i_displays: displays 
    Port map (
        rst => rst_inv,
        clk => clk,
        digito_0 => acc(3 downto 0),
        digito_1 => acc(7 downto 4),
        digito_2 => acc(3 downto 0),
        digito_3 => acc(7 downto 4),
        display => ldisplay,
        display_enable => an
    ); 
    
    i_mul: fsm
    Port map (
        rst => rst_inv,
        clk => clk,
        op1 => op1,
        op2 => op2,
        start => start_s,
        done => done,
        result => acc
    );
end Behavioral;
