----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 07:18:06 PM
-- Design Name: 
-- Module Name: counter5b - Behavioral
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
use ieee.std_logic_unsigned.all;

entity counter5b is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (4 downto 0));
end counter5b;

architecture Behavioral of counter5b is
signal cnt: std_logic_vector(4 downto 0):="00000";
begin
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            cnt<="00000";
        elsif ce ='1' then 
            cnt<=cnt+1;
        end if;
    end if;
end process;
q<=cnt;
end Behavioral;
