----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2022 06:07:46 PM
-- Design Name: 
-- Module Name: compare_unit - Behavioral
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

entity compare_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_compare:in std_logic_vector(1 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end compare_unit;

architecture Behavioral of compare_unit is
type byte_array_8 is array (0 to 7) of std_logic_vector(7 downto 0);
signal byte_xor: byte_array_8;
signal aux_lvl_0,aux_lvl_1,aux_lvl_2:std_logic_vector(63 downto 0);
signal byte_equal_bool: std_logic_vector(7 downto 0);

begin
   loop1: for i in 7 downto 0 generate
         byte_xor(i)<=op1((i+1)*8-1 downto i*8) xor op2((i+1)*8-1 downto i*8);
   end generate; 
   loop2_1: for i in 7 downto 0 generate
         byte_equal_bool(i)<=not(byte_xor(i)(7) or byte_xor(i)(6) or byte_xor(i)(5) or
                             byte_xor(i)(4) or byte_xor(i)(3) or byte_xor(i)(2) or
                             byte_xor(i)(1) or byte_xor(i)(0));         
   end generate;
   
   --LEVEL ZERO--
   loop3:for i in 7 downto 0 generate
        aux_lvl_0((i+1)*8-1 downto i*8)<=x"11" when (byte_equal_bool(i) = '1') else x"00";
   end generate;
   
  --LEVEL TWO-- 
  aux_lvl_1(63 downto 48)<= aux_lvl_0(63 downto 48) when ((byte_equal_bool(6) and byte_equal_bool(7)) or ((not ctrl_compare(1)) and (not ctrl_compare(0))))='1' else x"0000"; 
  aux_lvl_1(47 downto 32)<= aux_lvl_0(47 downto 32) when ((byte_equal_bool(4) and byte_equal_bool(5)) or ((not ctrl_compare(1)) and (not ctrl_compare(0))))='1' else x"0000"; 
  aux_lvl_1(31 downto 16)<= aux_lvl_0(31 downto 16) when ((byte_equal_bool(2) and byte_equal_bool(3)) or ((not ctrl_compare(1)) and (not ctrl_compare(0))))='1' else x"0000"; 
  aux_lvl_1(15 downto 0) <= aux_lvl_0(15 downto 0)  when ((byte_equal_bool(0) and byte_equal_bool(1)) or ((not ctrl_compare(1)) and (not ctrl_compare(0))))='1' else x"0000"; 
 
  --LEVEL THREE--
  aux_lvl_2(31 downto  0)<=aux_lvl_1(31 downto 0) when ((byte_equal_bool(0) and byte_equal_bool(1) and byte_equal_bool(2) and byte_equal_bool(3)) or (not ctrl_compare(1))) = '1' else x"00000000";
  aux_lvl_2(63 downto 32)<=aux_lvl_1(63 downto 32) when ((byte_equal_bool(4) and byte_equal_bool(5) and byte_equal_bool(6) and byte_equal_bool(7)) or (not ctrl_compare(1))) = '1' else x"00000000";
  
  result<=aux_lvl_2;                                   
end Behavioral;


