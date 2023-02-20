----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 11:10:36 PM
-- Design Name: 
-- Module Name: add_unit_test - Behavioral
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

entity add_test is
end add_test;

architecture Behavioral of add_test is
component add_unit is
    Port ( Op1 : in STD_LOGIC_VECTOR (63 downto 0);
           Op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_add : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal op1,op2,result: std_logic_vector(63 downto 0);
signal ctrl_add:std_logic;
begin
 C0: add_unit port map(op1=>op1, op2=>op2, ctrl_add=>ctrl_add,result=>result);
 op1<=x"7F" & x"FE" & x"12" & x"E9" & x"14" & x"28" & x"64" & x"DF", x"7FFF" & x"8000" & x"FEEF" & x"02FD" after 100ns;
 --  | 127  |   -2  |   18  |  -23  |   20  |   40  |  100  | -33  ||| 32767 | -32678  |  -273   |  765   |
 op2<=x"01" & x"80" & x"78" & x"95" & x"32" & x"C9" & x"DA" & x"DF", x"0002" & x"FFFF" & x"0190" & x"00EB" after 100ns;
 --  |   1  | -128  |  120  | -107  |   50  |  -55  |  -38  | -33  |||    2  |     -1  |   400   |  235   |
 
 -- expecting:
 --  | 127  | -128  |  127  | -128  |   70  |  -15  |   62  | -66  ||| 32767 | -32678  |   127   |  1000  |
 --  |  7F  |   80  |   7F  |   80  |   46  |   F1  |   3E  |  BE  |||  7FFF |   8000  |  007F   |  03E8  |
 ctrl_add<='0', '1' after 100ns;

end Behavioral;
