----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2023 20:10:23
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
  Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           op1 : in STD_LOGIC_VECTOR (3 downto 0);
           op2 : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (7 downto 0));
end fsm;

architecture Behavioral of fsm is
  component control is
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
    end component control;
    
    component datos is
      Port ( 
        op1 : in STD_LOGIC_VECTOR (3 downto 0);
        op2 : in STD_LOGIC_VECTOR (3 downto 0);
        rst: in STD_LOGIC;
        clk: in STD_LOGIC;
        b_1: out STD_LOGIC;
        n_0: out STD_LOGIC;
        a_reg: in STD_LOGIC;
        b_reg: in STD_LOGIC;
        n_reg: in STD_LOGIC;
        n_red: in STD_LOGIC;
        acc_reg: in STD_LOGIC;
        acc_0: in STD_LOGIC;
        a_shift: in STD_LOGIC;
        b_shift: in STD_LOGIC;
        result : out STD_LOGIC_VECTOR (7 downto 0)
      );
    end component datos;
    signal b_1, n_0, a_reg, b_reg, n_reg, n_red, acc_reg, acc_0, a_shift, b_shift: STD_LOGIC;
begin
    datos_i: datos
    Port map (
        op1 => op1,
        op2 => op2,
        rst => rst,
        clk => clk,
        b_1 => b_1,
        n_0 => n_0,
        a_reg => a_reg,
        b_reg => b_reg,
        n_reg => n_reg,
        n_red => n_red,
        acc_reg => acc_reg,
        acc_0 => acc_0,
        a_shift => a_shift,
        b_shift => b_shift,
        result => result
    );
    
    control_i: control
    Port map (
        rst => rst,
        clk => clk,
        b_1 => b_1,
        n_0 => n_0,
        start => start,
        a_reg => a_reg,
        b_reg => b_reg,
        n_reg => n_reg,
        n_red => n_red,
        acc_reg => acc_reg,
        acc_0 => acc_0,
        a_shift => a_shift,
        b_shift => b_shift,
        done => done
    );
end Behavioral;
