----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2022 07:17:09 PM
-- Design Name: 
-- Module Name: full_adder_nb - Behavioral
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

entity full_adder_nb is
    Generic(n:natural);
    Port (a,b:in std_logic_vector(n-1 downto 0);
        cin:in std_logic;
        y: out std_logic_vector(n-1 downto 0);
        cout: out std_logic );
end full_adder_nb;

architecture Behavioral of full_adder_nb is
component full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           y : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;
signal q : std_logic_vector(n downto 0);
begin
    generate_adders: for i in 0 to n-1 generate
        adder:full_adder port map (a=>a(i),b=>b(i),cin=>q(i),cout=>q(i+1), y=>y(i));
    end generate;
    q(0)<=cin;
    cout<=q(n);
end Behavioral;



