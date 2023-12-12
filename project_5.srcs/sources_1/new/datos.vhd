----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 20:05:27
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
        rst             : in  std_logic;   
        clk             : in  std_logic;
        bram_en: in std_logic;
        count1_en: in std_logic;
        count2_en: in std_logic;
        val1: out STD_LOGIC_VECTOR(3 DOWNTO 0);
        val2: out STD_LOGIC_VECTOR(3 DOWNTO 0);
        z: out STD_LOGIC
  );
end datos;

architecture Behavioral of datos is
    component blk_mem_gen_0 IS
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
    end component blk_mem_gen_0;
    
    component blk_mem_gen_2 IS
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
    end component blk_mem_gen_2;
    component counter is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               enable: in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (3 downto 0));
    end component counter;
    
signal q1, q2: STD_LOGIC_VECTOR (3 downto 0);
signal val1_aux, val2_aux: STD_LOGIC_VECTOR (3 downto 0);
begin
    i_mem_1: blk_mem_gen_0
    port map (
        clka => clk,
        ena => bram_en,
        wea => "0",
        addra => q1,
        dina => "0000",
        douta => val1_aux
    );
    
    i_mem_2: blk_mem_gen_2
    port map (
        clka => clk,
        ena => bram_en,
        wea => "0",
        addra => q2,
        dina => "0000",
        douta => val2_aux
    );
    
    i_counter1: counter
    port map (
        clk => clk,
        rst => rst,
        enable => count1_en,
        q => q1
    );
    
    i_counter2: counter
    port map (
        clk => clk,
        rst => rst,
        enable => count2_en,
        q => q2
    );
    
    p_z: process(val1_aux, val2_aux)
    begin 
        val1 <= val1_aux;
        val2 <= val2_aux;
        if unsigned(val1_aux) = unsigned(val2_aux) then
            z <= '1';
        else z <= '0';
        end if;
    end process;
end Behavioral;
