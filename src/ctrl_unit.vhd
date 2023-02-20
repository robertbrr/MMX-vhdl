----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 01:41:29 PM
-- Design Name: 
-- Module Name: ctrl_unit - Behavioral
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

entity ctrl_unit is
    Port ( opcode : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           start_mul : out STD_LOGIC;
           done_mul : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR (2 downto 0);
           ctrl_add : out STD_LOGIC;
           ctrl_shift : out STD_LOGIC_VECTOR (2 downto 0);
           ctrl_cmp : out STD_LOGIC_VECTOR (1 downto 0);
           done : out STD_LOGIC;
           WE: out STD_LOGIC;
           clk : in STD_LOGIC);
end ctrl_unit;

architecture Behavioral of ctrl_unit is
signal state,nxtstate:std_logic_vector(3 downto 0):=x"0";
begin

process(clk)
begin
    if rising_edge(clk) then
        state<=nxtstate;
    end if;
end process;

process(start,opcode,done_mul,state)
begin
    start_mul<='0';sel<="000";ctrl_add<='0';we<='0';
    done<='0';ctrl_cmp<="00";ctrl_shift<="000";
    case state is
        when x"0" => --0
            done<='1';
            if start ='1' then
                nxtstate<=x"1";--1
            else
                nxtstate<=x"0";--0
            end if;
        when x"1" => --1
            if opcode = "0000" then
                nxtstate<=x"2";--2
            elsif opcode = "0001" then
                nxtstate<=x"4"; --4
            elsif opcode(3 downto 1) = "001" then
                nxtstate<=x"7"; --7
            elsif opcode = "0100" then
                nxtstate<=x"8"; --8
            elsif opcode = "0101" then
                nxtstate<=x"9"; --9
            elsif opcode = "0110" then
                nxtstate<=x"A"; --10
            elsif opcode(3 downto 2) = "10" then
                nxtstate<=x"B"; --11
            elsif opcode = "1111" then
                nxtstate<=x"C"; --12
            else 
                nxtstate<=x"0"; --0
            end if;
         when x"2" => --2
            sel<="000";we<='1';
            nxtstate<=x"3"; --3
         when x"3" => --3
            nxtstate<=x"0"; --0
         when x"4" => --4
            start_mul<='1';
            nxtstate<=x"5"; --5
         when x"5" => --5
            if done_mul ='1' then
                nxtstate<=x"6"; --6
            else
                nxtstate<=x"5"; --5
            end if;
         when x"6" => --6
            sel<="001";we<='1';
            nxtstate<=x"3"; --3
         when x"7" => --7
            sel<="010";
            we<='1';
            ctrl_add<=opcode(0);
            nxtstate<=x"3";--3
         when x"8" => --8
            sel<="011";
            we<='1';
            ctrl_shift<="011"; --word
            nxtstate<=x"3";
         when x"9" => --9
            sel<="011";
            we<='1';
            ctrl_shift<="110"; --dword
            nxtstate<=x"3"; --3
         when x"A" => --10
            sel<="011";
            we<='1';
            ctrl_shift<="000"; --qword
            nxtstate<=x"3"; --3
         when x"B" => --11
            sel<="100";
            we<='1';
            ctrl_cmp<=opcode(1 downto 0);
            nxtstate<=x"3"; --3
         when x"C"=> --12
            sel<="101";
            we<='1';
            nxtstate<=x"3"; --3
         when others=>
            nxtstate<=x"0"; --0
    end case;
end process;

end Behavioral;
