----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2022 07:28:52 PM
-- Design Name: 
-- Module Name: pmadd_test - Behavioral
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

entity pmadd_test is
end pmadd_test;

architecture Behavioral of pmadd_test is
component pmadd_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal op1,op2,result:std_logic_vector(63 downto 0);
signal clk,start,done:std_logic;

begin
c0: pmadd_unit port map(op1=>op1,op2=>op2,clk=>clk,start=>start,done=>done,result=>result);

op1<=x"7FFF7FFF80008000";
op2<=x"7FFF7FFF80008000";

--op1<=x"0011FFC6FFEB000A";
--     17| -58 |-21| 10
--op2<=x"007DFFDE004DFFCF";
--    125 |-34 | 77|-49

--result
--        4097 |     -2107
--   0000 1001 | FFFF F7C5

start <= '1', '0' after 100ns;

process
begin
    if clk='U' then 
        clk<='0'; 
    else 
        clk<=not clk;
    end if;
    wait for 50ns;
end process;

end Behavioral;
