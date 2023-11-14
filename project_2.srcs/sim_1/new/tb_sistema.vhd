----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2023 20:15:07
-- Design Name: 
-- Module Name: tb_sistema - Behavioral
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

entity tb_sistema is
end tb_sistema;

architecture Behavioral of tb_sistema is
    component sistema is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               boton : in STD_LOGIC;
               clave : in STD_LOGIC_VECTOR (7 downto 0);
               bloqueado : out STD_LOGIC_VECTOR (9 downto 0);
               ldisplay : out STD_LOGIC_VECTOR (6 downto 0));
    end component sistema;
        
    signal boton, clk, rst: STD_LOGIC;
    signal clave: STD_LOGIC_VECTOR (7 downto 0);
    signal bloqueado: STD_LOGIC_VECTOR (9 downto 0);
    signal ldisplay: STD_LOGIC_VECTOR (6 downto 0);
begin
  i_s: sistema
  port map (
    clk => clk,
    rst => rst,
    boton => boton,
    clave => clave,
    bloqueado => bloqueado,
    ldisplay => ldisplay
  );
    
  -- Input clock
  p_clk : process
  begin
    clk <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process p_clk;
  
 
  
  p_stim : process
  begin
    -- se mantiene el rst activado durante 50 ns.
    rst  <= '1';
    boton <= '0';
    clave    <= (others => '0');
    wait for 50 ns;
    wait until rising_edge(clk);
    rst  <= '0';
    wait until rising_edge(clk);
    clave    <= (others => '1');
    boton <= '1';
    wait for 10 ns;
    boton <= '0';
    clave    <= "00000001";
    boton <= '1';
    wait for 20ns;
    clave    <= (others => '1');
    wait for 20ns;
    clave    <= "00000001";
    wait for 150ns;
    boton <= '0';
    rst <= '1';
    wait for 50ns;
    rst <= '0';
    wait for 10ns;
    boton <= '1'; 
    clave    <= (others => '1');
    wait;
  end process p_stim;
end Behavioral;
