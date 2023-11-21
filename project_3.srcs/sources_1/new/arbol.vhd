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
  
package utility2 is 
    function Log2( input:integer) return integer;
    constant num_num: integer := 16;
    constant tamano: integer := 4;
    type arr is array (Log2(num_num) downto 0, num_num - 1 downto 0) of STD_LOGIC_VECTOR(tamano - 1 downto 0);
end package utility2;

package body utility2 is
    function Log2( input:integer) return integer is
            variable temp, log: integer;
        begin
            temp := input;
            log := 0;
            while(temp > 1) loop
                temp := temp/2;
                log := log+1;
            end loop;
            return log;
    end function Log2;
end utility2;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.utility2.ALL;

entity Sistema_arbol is
    Port ( nums : in STD_LOGIC_VECTOR (tamano * num_num - 1 downto 0);
           mayor : out STD_LOGIC_VECTOR (tamano - 1 downto 0));
end Sistema_arbol;

architecture Behavioral of Sistema_arbol is
    
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
    gen_niveles: for i in 0 to Log2(num_num) - 1 generate
        gen_comparadores: for j in 0 to (num_num/2**(i+1)) - 1 generate
            comparator_i: comparator
                generic map (
                    n => tamano
                )
                port map (
                    A => C(i, j*2),
                    B => C(i, j*2 + 1),
                    S => C(i+1, j)
                );
        end generate gen_comparadores;
    end generate gen_niveles;
    
    i_c: process (nums)
    begin 
        for k in 0 to num_num - 1 loop
            C(0, k) <= nums((k + 1) * tamano - 1 downto k * tamano);
        end loop;
    end process i_c;
    mayor <= C(Log2(num_num), 0); 
end Behavioral;
