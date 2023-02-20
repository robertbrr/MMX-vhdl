----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 09:32:28 PM
-- Design Name: 
-- Module Name: mmx_registers - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mmx_registers is
    Port ( addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           addr2 : in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           WE: in STD_LOGIC;
           data_in1 : in STD_LOGIC_VECTOR (63 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (63 downto 0);
           data_out2 : out STD_LOGIC_VECTOR (63 downto 0));
end mmx_registers;

architecture Behavioral of mmx_registers is
type MMX_type is array (0 to 7) of STD_LOGIC_VECTOR(63 downto 0);
signal MMX_reg: MMX_type:=(
x"ABCD1234DCBA5678",
x"12345678ABCDEF00",
x"1111222233334444",
x"0011FFC6FFEB000A",
x"AABBCCDD12345678",
x"7FFE12E9142864DF",
x"7FFF8000FEEF02FD",
x"7FFF7FFF80008000");
begin

process(clk)
begin
    if rising_edge(clk) then
        if WE = '1' then
            MMX_reg(conv_integer(addr1))<=data_in1;
        end if;
    end if;       
end process;

data_out1<=MMX_reg(conv_integer(addr1));
data_out2<=MMX_reg(conv_integer(addr2));

end Behavioral;
