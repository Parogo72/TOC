----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2023 19:21:03
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

package utility is 
    constant num_num: integer := 4;
    constant tamano: integer := 4;
    type arr is array (num_num - 1 downto 0) of STD_LOGIC_VECTOR(tamano - 1 downto 0);
end package utility;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.utility.ALL;

entity Sistema_lineal is
    Port ( nums : in STD_LOGIC_VECTOR (tamano * num_num - 1 downto 0);
           mayor : out STD_LOGIC_VECTOR (tamano - 1 downto 0));
end Sistema_lineal;

architecture Behavioral of Sistema_lineal is
    component comparator is
        Generic (
            n: integer := tamano
        );
        Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
               B : in STD_LOGIC_VECTOR (n-1 downto 0);
               S : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component comparator;
    
    signal C: arr;
begin
    gen_comparadores: for i in 0 to (num_num - 2) generate
        comparador_i: comparator
            generic map (
                n => tamano
            )
            port map (
                A => C(i),
                B => nums((i + 2) * tamano - 1 downto (i + 1) * tamano),
                S => C(i + 1)
            );
        end generate gen_comparadores;
        C(0) <= nums(tamano - 1 downto 0);
        mayor <= C(num_num - 1);
end Behavioral;
