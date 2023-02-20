----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2022 03:28:43 PM
-- Design Name: 
-- Module Name: get_compl - Behavioral
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

entity get_compl is
    Generic(n: natural);
    Port(x: in STD_LOGIC_VECTOR(n-1 downto 0);
    s: out STD_LOGIC_VECTOR(n-1 downto 0));
end get_compl;

architecture Behavioral of get_compl is
component full_adder_nb is
    Generic(n:natural);
    Port (a,b:in std_logic_vector(n-1 downto 0);
        cin:in std_logic;
        y: out std_logic_vector(n-1 downto 0);
        cout: out std_logic );
end component;
signal aux,negX: std_logic_vector(n-1 downto 0);
begin
    negX<=not x;
    aux(n-1 downto 0)<=(others=>'0');
    adder:full_adder_nb generic map(n=>n)
        port map(cin=>'1', cout=>open,a=>negX,b=>aux,y=>s);
end Behavioral;
