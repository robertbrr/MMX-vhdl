----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 04:30:37 PM
-- Design Name: 
-- Module Name: multiplier16b - Behavioral
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

entity multiplier16b is
    Port ( multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           start: in STD_LOGIC;
           product : out STD_LOGIC_VECTOR (31 downto 0);
           done_mul : out STD_LOGIC);
end multiplier16b;

 architecture Behavioral of multiplier16b is
component multiply_ctrl is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : in STD_LOGIC;
           p0 : in STD_LOGIC;
           write : out STD_LOGIC;
           shift : out STD_LOGIC;
           ce: out STD_LOGIC;
           init : out STD_LOGIC);
end component;

component multiply_ex is
    Port ( init : in STD_LOGIC;
           multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           write : in STD_LOGIC;
           multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           shift : in STD_LOGIC;
           ce: in STD_LOGIC;
           clk: in STD_LOGIC;
           product : out STD_LOGIC_VECTOR (31 downto 0);
           done:out std_logic);
end component;

component get_compl is
    Generic(n: natural);
    Port(x: in STD_LOGIC_VECTOR(n-1 downto 0);
    s: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

signal init,write,shift,done_s,ce: std_logic;
signal product_s,product_compl: std_logic_vector(31 downto 0);
signal multiplicand_s,multiplier_s,multiplicand_compl,multiplier_compl:std_logic_vector(15 downto 0);
begin

compl0: get_compl generic map (n=>16) port map(x=>multiplicand,s=>multiplicand_compl);
compl1: get_compl generic map (n=>16) port map(x=>multiplier,s=>multiplier_compl);
compl2: get_compl generic map (n=>32) port map(x=>product_s,s=>product_compl);                   

multiplicand_s<=multiplicand when multiplicand(15) ='0' else multiplicand_compl;
multiplier_s<=multiplier when multiplier(15) ='0' else multiplier_compl;
product<=product_compl when (multiplicand(15) xor multiplier(15)) ='1' else product_s;

ue: multiply_ex port map(init=>init, multiplicand=>multiplicand_s, multiplier=>multiplier_s,ce=>ce,write=>write,shift=>shift,clk=>clk,product=>product_s,done=>done_s);
uc: multiply_ctrl port map(clk=>clk,start=>start,done=>done_s,p0=>product_s(0),write=>write,ce=>ce,shift=>shift,init=>init);
done_mul<=done_s;

end Behavioral;
