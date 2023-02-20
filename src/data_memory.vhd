----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 09:25:37 PM
-- Design Name: 
-- Module Name: data_memory - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity data_memory is
    Port ( addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (63 downto 0));
end data_memory;

architecture Behavioral of data_memory is
type ROM_type is array (0 to 7) of std_logic_vector(63 downto 0);
signal ROM : ROM_type := (
x"FF00FF0000FF00FF",
x"0000000000000004",
x"CCCCDDDDEEEEFFFF",
x"007DFFDE004DFFCF",
x"AADDCCDD12345678",
x"0180789532C9DADF",
x"0002FFFF019000EB",
x"7FFF7FFF80008000");
begin
    data_out1<=ROM(conv_integer(addr1));
end Behavioral;
