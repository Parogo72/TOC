----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2023 19:59:21
-- Design Name: 
-- Module Name: tb_top - Behavioral
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

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is
    component reg_div
    port(
      rst  : in  std_logic;
      clk  : in  std_logic;
      load : in  std_logic;
      d   : in  std_logic_vector(3 downto 0);
      q   : out std_logic_vector(3 downto 0)
      );
  end component;
  --entradas
  signal rst  : std_logic;
  signal clk  : std_logic;
  signal d    : std_logic_vector(3 downto 0);
  signal load : std_logic;

--salidas
  signal q : std_logic_vector(3 downto 0);
  
  --se define el periodo de reloj 
  constant clk_period : time := 10 ns;
begin
    i_top : reg_div port map (
    rst  => rst,
    clk  => clk,
    load => load,
    d   => d,
    q   => q
    );

  --proceso de estimulos
  p_clk : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process p_clk;
  
  p_stim : process
  begin
    rst  <= '1';
    load <= '0';
    d    <= (others => '0');
    wait for 10 ns;
    wait until rising_edge(clk);
    rst <= '0';
    wait until rising_edge(clk);
    load <= '1';
    d    <= (others => '1');
    wait until rising_edge(clk);
    d    <= "1010";
    wait for 1 sec;
    d    <= "1110";
    wait for 1 sec;
    wait until rising_edge(clk);
    d    <= "0011";
    wait for 1 sec;
    wait until rising_edge(clk);
    d    <= "1001";
    wait until rising_edge(clk);
    d    <= "1111";
    wait until rising_edge(clk);
    d    <= "0001";
    wait until rising_edge(clk);
    d    <= "1000";
    wait until rising_edge(clk);
    load <= '0';
    d    <= "0000";
    wait until rising_edge(clk);
    d    <= "0110";
    wait;
  end process p_stim;
end Behavioral;
