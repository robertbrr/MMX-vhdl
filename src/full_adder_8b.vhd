----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 09:57:07 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder_8b is
    Port ( a : in STD_LOGIC_VECTOR(7 downto 0);
           b : in STD_LOGIC_VECTOR(7 downto 0);
           cin : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(7 downto 0);
           cout : out STD_LOGIC;
           overflow: out STD_logic);
end full_adder_8b;

architecture Behavioral of full_adder_8b is

component full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           y : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;
signal q0,q1,q2,q3,q4,q5,q6,q7 : std_logic;
begin
    C0: full_adder port map (a=>a(0),b=>b(0),cin=>cin,cout=>q0, y=>y(0));
    C1: full_adder port map (a=>a(1),b=>b(1),cin=>q0, cout=>q1, y=>y(1));
    C2: full_adder port map (a=>a(2),b=>b(2),cin=>q1, cout=>q2, y=>y(2));
    C3: full_adder port map (a=>a(3),b=>b(3),cin=>q2, cout=>q3, y=>y(3));
    C4: full_adder port map (a=>a(4),b=>b(4),cin=>q3, cout=>q4, y=>y(4));
    C5: full_adder port map (a=>a(5),b=>b(5),cin=>q4, cout=>q5, y=>y(5));
    C6: full_adder port map (a=>a(6),b=>b(6),cin=>q5, cout=>q6, y=>y(6));
    C7: full_adder port map (a=>a(7),b=>b(7),cin=>q6, cout=>q7, y=>y(7));  
    overflow<=q7 xor q6;
    cout<=q7;
end Behavioral;


