----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2022 03:55:25 PM
-- Design Name: 
-- Module Name: andn_test - Behavioral
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

entity andn_test is
end andn_test;

architecture Behavioral of andn_test is
component andn_gate is
    Port (a, b : in std_logic_vector(63 downto 0);
    y: out std_logic_vector(63 downto 0));
end component;
signal op1,op2,result: std_logic_vector(63 downto 0);
begin
andn: andn_gate port map(a=>op1,b=>op2,y=>result);
op1<=x"ABCDEF0123456789",x"FFFFFFFFFFFFFFFF" after 50 ns;
op2<=x"8888777766665555",x"0F0F0F0F0F0F0F0F0" after 50 ns;
end Behavioral;
