----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2022 03:34:35 PM
-- Design Name: 
-- Module Name: unpack_test - Behavioral
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

entity unpack_test is
end unpack_test;

architecture Behavioral of unpack_test is
component unpack_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal op1,op2,result:std_logic_vector(63 downto 0);
begin
uu: unpack_unit port map (op1=>op1,op2=>op2,result=>result);
op1<=x"AAAABBBBCCCCDDDD";
op2<=x"1111222233334444";
end Behavioral;
