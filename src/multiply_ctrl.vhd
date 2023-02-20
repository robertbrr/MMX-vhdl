----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 04:19:28 PM
-- Design Name: 
-- Module Name: multiply_ctrl - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiply_ctrl is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : in STD_LOGIC;
           p0 : in STD_LOGIC;
           write : out STD_LOGIC;
           shift : out STD_LOGIC;
           ce: out STD_LOGIC;
           init : out STD_LOGIC);
end multiply_ctrl;

architecture Behavioral of multiply_ctrl is
signal state,nxtstate: std_logic_vector (3 downto 0):=x"0";
begin
--next state--
process(clk)
begin
    if rising_edge(clk) then 
        state<=nxtstate;
    end if;
end process;
process(state,start,p0,done)
begin    
    write<='0';shift<='0';init<='0';ce<='0';
    case state is
        when x"0" =>
            if start = '1' then 
                write<='1';
                init<='1';
                nxtstate<=x"1";
            else
                nxtstate<=x"0";
            end if;
        when x"1" =>
            if p0= '0' then
                nxtstate<=x"2";
            else
                write<='1';
                nxtstate<=x"2";
            end if;
        when x"2"=>
            ce<='1';
            shift<='1';
            nxtstate<=x"3";
        when x"3" =>
            if done = '1' then
                nxtstate<=x"0";
            else
                nxtstate<=x"1";
           end if;
        when others => nxtstate<=x"0";
    end case;
end process;
 
end Behavioral;
