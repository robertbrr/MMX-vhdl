----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 07:29:07 PM
-- Design Name: 
-- Module Name: shift_reg32b - Behavioral
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

entity shift_reg32b is
    Port ( clk : in STD_LOGIC;
           shift : in STD_LOGIC;
           load : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (31 downto 0);
           q : out STD_LOGIC_VECTOR (31 downto 0));
end shift_reg32b;

architecture Behavioral of shift_reg32b is
signal reg_data:std_logic_vector(31 downto 0);
begin
process(clk)
begin
    if rising_edge(clk) then
        if load = '1' then
            reg_data<=d;
        elsif shift = '1' then
            reg_data<='0' & reg_data(31 downto 1);
        end if;
    end if;
end process;
q<=reg_data;
end Behavioral;
