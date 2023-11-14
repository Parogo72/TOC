----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2023 19:07:36
-- Design Name: 
-- Module Name: sistema - Behavioral
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

entity sistema is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           boton : in STD_LOGIC;
           clave : in STD_LOGIC_VECTOR (7 downto 0);
           bloqueado : out STD_LOGIC_VECTOR (9 downto 0);
           ldisplay : out STD_LOGIC_VECTOR (6 downto 0));
end sistema;

architecture Behavioral of sistema is
    component cerrojo is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               boton : in STD_LOGIC;
               clave : in STD_LOGIC_VECTOR (7 downto 0);
               bloqueado : out STD_LOGIC_VECTOR (9 downto 0);
               ldisplay : out STD_LOGIC_VECTOR (3 downto 0));
    end component cerrojo;
    
    component conv_7seg is
        port (
            x: in  std_logic_vector (3 downto 0);
            display : out std_logic_vector (6 downto 0));
    end component conv_7seg;
    
    component debouncer is
          port (
            rst             : in  std_logic;
            clk             : in  std_logic;
            x               : in  std_logic;
            xDeb            : out std_logic;
            xDebFallingEdge : out std_logic;
            xDebRisingEdge  : out std_logic
            );
    end component debouncer;
    
    signal boton_b: STD_LOGIC;
    signal ldisplay_c: STD_LOGIC_VECTOR (3 downto 0);
begin
    i_c: cerrojo
    port map (
        clk => clk,
        rst => rst,
        boton => boton_b,
        clave => clave,
        bloqueado => bloqueado,
        ldisplay => ldisplay_c
    );
    
    i_seg: conv_7seg
    port map (
        x => ldisplay_c,
        display => ldisplay
    );
    
    i_d: debouncer
    port map (
        rst => rst,
        clk => clk,
        x => boton,
        xDebRisingEdge => open,
        xDebFallingEdge =>  boton_b,
        xDeb => open
    );
    
end Behavioral;
