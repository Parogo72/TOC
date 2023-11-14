----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2023 19:01:44
-- Design Name: 
-- Module Name: cerrojo - Behavioral
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cerrojo is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           boton : in STD_LOGIC;
           clave : in STD_LOGIC_VECTOR (7 downto 0);
           bloqueado : out STD_LOGIC_VECTOR (9 downto 0);
           ldisplay : out STD_LOGIC_VECTOR (3 downto 0));
end cerrojo;

architecture Behavioral of cerrojo is
    type estado_t is (s0, s1, s2, s3, s4);
    signal estado_actual, estado_siguiente : estado_t;
    signal claveActual: STD_LOGIC_VECTOR (7 downto 0);
    signal intentos : integer range 0 to 3;
begin
    p_reg : process(clk, rst)
    begin
        if rst = '1' then 
            estado_actual <= s0;
        else 
            if rising_edge(clk) then 
                estado_actual <= estado_siguiente;
            end if;
        end if;
    end process p_reg;
    
    p_estado : process(boton, estado_siguiente, clave, claveActual, estado_actual)
    begin
        if boton = '1' then
            case estado_actual is
                when s0 =>
                    estado_siguiente <= s1;
                when s1 =>
                    if (clave = claveActual) then
                        estado_siguiente <= s0;
                    else
                        estado_siguiente <= s2;
                    end if;
                when s2 =>
                    if (clave = claveActual) then
                        estado_siguiente <= s0;
                    else
                        estado_siguiente <= s3;
                    end if;
                when s3 =>
                    if (clave = claveActual) then
                        estado_siguiente <= s0;
                    else
                        estado_siguiente <= s4;
                    end if;
                when s4 =>
                    estado_siguiente <= s4;
                when others => 
                    estado_siguiente <= s0;
            end case;
        else 
            estado_siguiente <= estado_actual;
        end if;
    end process p_estado;
    
    p_clave: process(clk, estado_actual, boton, rst)
    begin
        if rst = '1' then 
            claveActual <= (others => '0');
        elsif rising_edge(clk) and estado_actual = s0 then 
                claveActual <= clave;
        end if;
    end process p_clave;
    
    p_sal : process(estado_actual, claveActual, clave)
    begin
         case estado_actual is 
             when s0 => 
                intentos <= 3;  
                bloqueado <= (others => '1');
             when s1 => 
                intentos <= 3;  
                bloqueado <= (others => '1');
             when s2 => 
                intentos <= 2;  
                bloqueado <= (others => '0');
             when s3 => 
                intentos <= 1;  
                bloqueado <= (others => '0');
             when s4 => 
                intentos <= 0;  
                bloqueado <= (others => '0');
             when others =>
                intentos <= 0;
                bloqueado <= (others => '0');
         end case;
    end process p_sal;
    
    ldisplay <= std_logic_vector(to_signed(intentos, 4));
end Behavioral;
