----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2022 10:29:50 AM
-- Design Name: 
-- Module Name: unpack_unit - Behavioral
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

entity unpack_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end unpack_unit;

architecture Behavioral of unpack_unit is
signal tmp: std_logic_vector(63 downto 0);
begin
    tmp(63 downto 48)<=op2(31 downto 16);
    tmp(47 downto 32)<=op1(31 downto 16);
    tmp(31 downto 16)<=op2(15 downto 0);
    tmp(15 downto 0)<=op1(15 downto 0);
    result<=tmp;
end Behavioral;
