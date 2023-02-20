----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2022 07:07:39 PM
-- Design Name: 
-- Module Name: pmadd_unit - Behavioral
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

entity pmadd_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end pmadd_unit;

architecture Behavioral of pmadd_unit is
component multiplier16b is
    Port ( multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           start: in STD_LOGIC;
           product : out STD_LOGIC_VECTOR (31 downto 0);
           done_mul : out STD_LOGIC);
end component;
component full_adder_nb is
    Generic(n:natural);
    Port (a,b:in std_logic_vector(n-1 downto 0);
        cin:in std_logic;
        y: out std_logic_vector(n-1 downto 0);
        cout: out std_logic );
end component;

signal partial3, partial2,partial1,partial0:std_logic_vector(31 downto 0);
signal done3,done2,done1,done0:std_logic;
begin
c3: multiplier16b port map(clk=>clk,start=>start,multiplier=>op1(63 downto 48),
    multiplicand=>op2(63 downto 48),product=>partial3,done_mul=>done3);
c2: multiplier16b port map(clk=>clk,start=>start,multiplier=>op1(47 downto 32),
    multiplicand=>op2(47 downto 32),product=>partial2,done_mul=>done2);
c1: multiplier16b port map(clk=>clk,start=>start,multiplier=>op1(31 downto 16),
    multiplicand=>op2(31 downto 16),product=>partial1,done_mul=>done1);
c0: multiplier16b port map(clk=>clk,start=>start,multiplier=>op1(15 downto 0),
    multiplicand=>op2(15 downto 0),product=>partial0,done_mul=>done0);
    
s1: full_adder_nb generic map(n=>32)
                  port map(a=>partial3,b=>partial2,cin=>'0',cout=>open, y=>result(63 downto 32));
s0: full_adder_nb generic map(n=>32)
                  port map(a=>partial1,b=>partial0,cin=>'0',cout=>open, y=>result(31 downto 0));              
done<=done3 and done2 and done1 and done0;
end Behavioral;
