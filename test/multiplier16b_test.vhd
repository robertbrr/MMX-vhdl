----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 04:39:20 PM
-- Design Name: 
-- Module Name: multiplier16b_test - Behavioral
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

entity multiplier16b_test is
end multiplier16b_test;

architecture Behavioral of multiplier16b_test is
component multiplier16b is
    Port ( multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           start: in STD_LOGIC;
           product : out STD_LOGIC_VECTOR (31 downto 0);
           done_mul : out STD_LOGIC);
end component;
signal multiplier,multiplicand:std_logic_vector(15 downto 0);
signal clk,start,done_mul:std_logic;
signal product:std_logic_vector(31 downto 0);
begin
process
begin
    if clk='U' then clk<='0';
    else clk<=not clk;
    end if;
wait for 50ns;
end process;
start<='1', '0' after 100ns;
multiplier <= x"FFF1";
multiplicand<=x"0CBA";

mul: multiplier16b port map(multiplier=>multiplier, start=>start,multiplicand=>multiplicand,clk=>clk,product=>product,done_mul=>done_mul);

end Behavioral;
