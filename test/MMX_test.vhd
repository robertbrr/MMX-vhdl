----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 04:09:22 PM
-- Design Name: 
-- Module Name: MMX_test - Behavioral
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

entity MMX_test is
end MMX_test;

architecture Behavioral of MMX_test is
component MMX is
    Port ( clk : in STD_LOGIC;
           addr1 : in STD_LOGIC_VECTOR (2 downto 0);
           addr2 : in STD_LOGIC_VECTOR (2 downto 0);
           addr_imm : in STD_LOGIC_VECTOR (2 downto 0);
           opcode : in STD_LOGIC_VECTOR (3 downto 0);
           start : in STD_LOGIC;
           op_mode : in STD_LOGIC;
           LED_done : out STD_LOGIC;
           op1_out : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal clk,start,op_mode,led_done:std_logic;
signal addr1,addr2,addr_imm:std_logic_vector(2 downto 0);
signal opcode:std_logic_vector(3 downto 0);
signal op1:std_logic_vector(63 downto 0);
begin
    C0: mmx port map(clk=>clk,addr1=>addr1,addr2=>addr2,addr_imm=>addr_imm,opcode=>opcode,
        start=>start,op_mode=>op_mode,led_done=>led_done,op1_out=>op1);
        
    process
    begin
        if clk='U' then 
            clk<='0';
        else 
            clk<=not clk;
        end if;
        wait for 50ns;
    end process;
    
    --paddsb reg[5], mem[5]
--    opcode<="0010";
--    op_mode<='1';
--    addr1<="101";
--    addr2<="000";
--    addr_imm<="101";
--    start<='1', '0' after 100ns;
    
    --paddsw reg[6], mem[6]
--    opcode<="0011";
--    op_mode<='1';
--    addr1<="110";
--    addr2<="000";
--    addr_imm<="110";
--    start<='1', '0' after 100ns;

    --pmadd reg[3], mem[3]
    opcode<="0001";             
    op_mode<='1';                   
    addr1<="011";              
    addr2<="000";               
    addr_imm<="011";            
    start<='1', '0' after 100ns;
    
    --pcmpeq reg[4], mem[4]      
--    opcode<="1010";             
--    op_mode<='1';               
--    addr1<="100";               
--    addr2<="000";               
--    addr_imm<="100";            
--    start<='1', '0' after 100ns;

    --pandn reg[0], reg[1]       
--    opcode<="0000";                 
--    op_mode<='0';                   
--    addr1<="000";          
--    addr2<="001";               
--    addr_imm<="100";            
--    start<='1', '0' after 100ns;


    --psrlq reg[1],mem[1]
    --psrld reg[1], mem[1]
    --psrlw reg[1], mem[1]
    --psrlw reg[1], reg[1]      
--    opcode<="0110", "0101" after 400ns, "0100" after 800ns;             
--    op_mode<='1', '0' after 1200 ns;               
--    addr1<="001";               
--    addr2<="001";               
--    addr_imm<="001";            
--    start<='1', '0' after 100ns,'1' after 400ns, '0' after 500ns, '1' after 800ns, '0' after 900ns, '1' after 1200ns, '0' after 1300ns;

    --unpack reg[2], mem[2]               
--    opcode<="1111";                    
--    op_mode<='1';                      
--    addr1<="010";                      
--    addr2<="000";                      
--    addr_imm<="010";                   
--    start<='1', '0' after 100ns;           
    
    --paddsb reg[2], reg[2]       
--    opcode<="0010";               
--    op_mode<='0';                 
--    addr1<="010";                 
--    addr2<="010";                 
--    addr_imm<="000";              
--    start<='1', '0' after 100ns;  

end Behavioral;