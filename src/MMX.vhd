----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 03:42:47 PM
-- Design Name: 
-- Module Name: MMX - Behavioral
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

entity MMX is
    Port ( clk : in STD_LOGIC;
           addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           addr2 : in STD_LOGIC_VECTOR (2 downto 0);
           addr_imm : in STD_LOGIC_VECTOR (2 downto 0);
           opcode : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           op_mode : in STD_LOGIC;
           LED_done : out STD_LOGIC;
           op1_out : out STD_LOGIC_VECTOR (63 downto 0));
end MMX;

architecture Behavioral of MMX is
component ex_unit is
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
end component;
component ctrl_unit is
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
end component;
component data_memory is
    Port ( addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (63 downto 0));
end component;
component mmx_registers is
    Port ( addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           addr2 : in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           WE: in STD_LOGIC;
           data_in1 : in STD_LOGIC_VECTOR (63 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (63 downto 0);
           data_out2 : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal result,operand1,operand2,imm,operand2_mux:std_logic_vector(63 downto 0);
signal we, ctrl_add,start_mul,done_mul :std_logic;
signal ctrl_cmp: std_logic_vector(1 downto 0);
signal ctrl_shift,sel: std_logic_vector(2 downto 0);
begin

ex: ex_unit port map(op1=>operand1,op2=>operand2_mux,sel=>sel,clk=>clk,start_mul=>start_mul,
    ctrl_add=>ctrl_add,ctrl_shift=>ctrl_shift,ctrl_compare=>ctrl_cmp,done_mul=>done_mul,
    result=>result);
    
ctrl: ctrl_unit port map(opcode=>opcode,start=>start,start_mul=>start_mul, done_mul=>done_mul,
    sel=>sel,ctrl_add=>ctrl_add,ctrl_shift=>ctrl_shift, ctrl_cmp=>ctrl_cmp,
    done=>LED_done,we=>we,clk=>clk);
    
rom: data_memory port map(addr1=>addr_imm, data_out1=>imm);

reg: mmx_registers port map(addr1=>addr1, addr2=>addr2,clk=>clk,we=>we,data_in1=>result,data_out1=>operand1,
    data_out2=>operand2);
    
operand2_mux<=operand2 when op_mode='0' else imm;
op1_out<=operand1;

end Behavioral;
