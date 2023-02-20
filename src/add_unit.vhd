----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 10:35:39 PM
-- Design Name: 
-- Module Name: add_unit - Behavioral
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

entity add_unit is
    Port ( Op1 : in STD_LOGIC_VECTOR (63 downto 0);
           Op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_add : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (63 downto 0));
end add_unit;

architecture Behavioral of add_unit is

component full_adder_8b is
    Port ( a : in STD_LOGIC_VECTOR(7 downto 0);
           b : in STD_LOGIC_VECTOR(7 downto 0);
           cin : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(7 downto 0);
           cout : out STD_LOGIC;
           overflow: out STD_LOGIC);
end component;

signal q0,q1,q2,q3,q4,q5,q6,q7:std_logic;
signal of0,of1,of2,of3,of4,of5,of6,of7:std_logic;
signal y0,y1,y2,y3,y4,y5,y6,y7:std_logic_vector(7 downto 0);
signal y0_s,y1_s,y2_s,y3_s,y4_s,y5_s,y6_s,y7_s:std_logic_vector(7 downto 0);
signal y1y0, y3y2, y5y4, y7y6:std_logic_vector(15 downto 0);
signal link0, link1, link2, link3:std_logic;
signal limit0b,limit1b,limit2b,limit3b,limit4b,limit5b,limit6b,limit7b:std_logic_vector(7 downto 0);
signal limit0w,limit1w,limit2w,limit3w:std_logic_vector(15 downto 0);
begin
    
    link0<=q0 and ctrl_add;
    link1<=q2 and ctrl_add;
    link2<=q4 and ctrl_add;
    link3<=q6 and ctrl_add;
    
    C0: full_adder_8b port map (a=>op1(7 downto 0), b=>op2(7 downto 0),cin=>'0',cout=>q0,y=>y0,overflow=>of0);
    C1: full_adder_8b port map (a=>op1(15 downto 8), b=>op2(15 downto 8),cin=>link0,cout=>q1,y=>y1,overflow=>of1);
    
    C2: full_adder_8b port map (a=>op1(23 downto 16), b=>op2(23 downto 16),cin=>'0',cout=>q2,y=>y2,overflow=>of2);
    C3: full_adder_8b port map (a=>op1(31 downto 24), b=>op2(31 downto 24),cin=>link1,cout=>q3,y=>y3,overflow=>of3);
    
    C4: full_adder_8b port map (a=>op1(39 downto 32), b=>op2(39 downto 32),cin=>'0',cout=>q4,y=>y4,overflow=>of4);
    C5: full_adder_8b port map (a=>op1(47 downto 40), b=>op2(47 downto 40),cin=>link2,cout=>q5,y=>y5,overflow=>of5); 
    
    C6: full_adder_8b port map (a=>op1(55 downto 48), b=>op2(55 downto 48),cin=>'0',cout=>q6,y=>y6,overflow=>of6);
    C7: full_adder_8b port map (a=>op1(63 downto 56), b=>op2(63 downto 56),cin=>link3,cout=>q7,y=>y7,overflow=>of7); 
    
    limit0b<=x"80" when y0(7)='0' else x"7F";
    limit1b<=x"80" when y1(7)='0' else x"7F";
    limit2b<=x"80" when y2(7)='0' else x"7F";
    limit3b<=x"80" when y3(7)='0' else x"7F";
    limit4b<=x"80" when y4(7)='0' else x"7F";
    limit5b<=x"80" when y5(7)='0' else x"7F";
    limit6b<=x"80" when y6(7)='0' else x"7F";
    limit7b<=x"80" when y7(7)='0' else x"7F";
    
    y0_s<=y0 when (of0 and (not ctrl_add))='0' else limit0b;
    y1_s<=y1 when (of1 and (not ctrl_add))='0' else limit1b;
    y2_s<=y2 when (of2 and (not ctrl_add))='0' else limit2b;
    y3_s<=y3 when (of3 and (not ctrl_add))='0' else limit3b;
    y4_s<=y4 when (of4 and (not ctrl_add))='0' else limit4b;
    y5_s<=y5 when (of5 and (not ctrl_add))='0' else limit5b;
    y6_s<=y6 when (of6 and (not ctrl_add))='0' else limit6b;
    y7_s<=y7 when (of7 and (not ctrl_add))='0' else limit7b;
    
    
    limit0w<=x"8000" when y1_S(7) = '0' else x"7FFF";
    limit1w<=x"8000" when y3_s(7) = '0' else x"7FFF";
    limit2w<=x"8000" when y5_s(7) = '0' else x"7FFF";
    limit3w<=x"8000" when y7_s(7) = '0' else x"7FFF";
    
    y1y0<= (y1_s & y0_s) when (of1 and ctrl_add) = '0' else limit0w;
    y3y2<= (y3_s & y2_s) when (of3 and ctrl_add) = '0' else limit1w;
    y5y4<= (y5_s & y4_s) when (of5 and ctrl_add) = '0' else limit2w;
    y7y6<= (y7_s & y6_s) when (of7 and ctrl_add) = '0' else limit3w;
    
    result<=(y7y6 & y5y4 & y3y2 & y1y0);
    
end Behavioral;
