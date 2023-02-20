----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 09:46:55 PM
-- Design Name: 
-- Module Name: ex_unit - Behavioral
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

entity ex_unit is
    Port ( Op1 : in STD_LOGIC_VECTOR (63 downto 0);
           Op2 : in STD_LOGIC_VECTOR (63 downto 0);
           SEL: in STD_LOGIC_VECTOR (2 downto 0);
           clk: in STD_LOGIC;
           start_mul: in STD_LOGIC;
           ctrl_add: in std_logic;
           ctrl_shift: in std_logic_vector(2 downto 0);
           ctrl_compare: in std_logic_vector(1 downto 0);
           done_mul : out std_logic;
           Result : out STD_LOGIC_VECTOR (63 downto 0));
end ex_unit;

architecture Behavioral of ex_unit is
component andn_gate is
    Port (a, b : in std_logic_vector(63 downto 0);
    y: out std_logic_vector(63 downto 0));
end component;
component shift_unit is
    Port ( operand : in STD_LOGIC_VECTOR (63 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0);
           mode : in STD_LOGIC_VECTOR (2 downto 0);
           amount:in std_logic_vector(63 downto 0));
end component;
component add_unit is
    Port ( Op1 : in STD_LOGIC_VECTOR (63 downto 0);
           Op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_add : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
component compare_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_compare:in std_logic_vector(1 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
component pmadd_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
component unpack_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal result_andn,result_shift,result_add,result_compare,result_unpack,result_pmadd: std_logic_vector(63 downto 0);
begin
    C0: andn_gate port map(a=>Op1, b=>Op2, y=>result_andn);
    C1: add_unit port map(op1=>op1,op2=>op2,ctrl_add=>ctrl_add,result=>result_add);
    C2: shift_unit port map(operand=>op1,amount=>op2,result=>result_shift,mode=>ctrl_shift);
    C3: compare_unit port map(op1=>op1,op2=>op2,ctrl_compare=>ctrl_compare,result=>result_compare);
    C4: pmadd_unit port map(op1=>op1,op2=>op2,start=>start_mul,done=>done_mul,clk=>clk,result=>result_pmadd);
    C5: unpack_unit port map(op1=>op1,op2=>op2,result=>result_unpack);
   
  --mux to select result with ctrl
   with sel select
       result<=result_andn when "000",
       result_pmadd when "001",
       result_add when "010",
       result_shift when "011",
       result_compare when "100",
       result_unpack when others;
      
end Behavioral;



