----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 04:02:38 PM
-- Design Name: 
-- Module Name: multiply_ex - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiply_ex is
    Port ( init : in STD_LOGIC;
           multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           write : in STD_LOGIC;
           multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           shift : in STD_LOGIC;
           ce: in STD_LOGIC;
           clk: in STD_LOGIC;
           product : out STD_LOGIC_VECTOR (31 downto 0);
           done:out std_logic);
end multiply_ex;



architecture Behavioral of multiply_ex is
component full_adder_nb is
    Generic(n:natural);
    Port (a,b:in std_logic_vector(n-1 downto 0);
        cin:in std_logic;
        y: out std_logic_vector(n-1 downto 0);
        cout: out std_logic );
end component;
component counter5b is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (4 downto 0));
end component;
component shift_reg32b is
    Port ( clk : in STD_LOGIC;
           shift : in STD_LOGIC;
           load : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (31 downto 0);
           q : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal prod_reg, d_reg:std_logic_vector(31 downto 0);
signal alu_out:std_logic_vector(15 downto 0);
signal cnt:std_logic_vector(4 downto 0);
begin

adder: full_adder_nb generic map (n=>16)
                     port map(a=>multiplicand, b=>prod_reg(31 downto 16), cin=>'0',y=>alu_out, cout=>open);
                     
cntr: counter5b port map(rst=>init, clk=>clk, ce=>ce, q=>cnt);

shift_reg: shift_reg32b port map(clk=>clk,shift=>shift,load=>write,d=>d_reg, q=>prod_reg);

d_reg<= (x"0000" & multiplier) when init = '1' else (alu_out & prod_reg(15 downto 0));

done<=cnt(4);
product<=prod_reg;
end Behavioral;
