----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2022 09:23:14 PM
-- Design Name: 
-- Module Name: MMX_FPGA - Behavioral
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

entity MMX_FPGA is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           BTNC : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0));
end MMX_FPGA;

architecture Behavioral of MMX_FPGA is
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
component display_7seg is
      port(cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0));
end component;
component debouncer is
    Port ( clk : in STD_LOGIC;
           bttn_in : in STD_LOGIC;
           bttn_out : out STD_LOGIC);
end component;

signal btnc_deb:std_logic;
signal op1: std_logic_vector(63 downto 0);
signal out_mux: std_logic_vector(15 downto 0);
begin
mmx_comp: mmx port map(clk=>clk, addr2=>sw(11 downto 9), addr1=>sw(8 downto 6), 
          addr_imm => sw(15 downto 13), opcode=>sw(5 downto 2), start=>btnc_deb,
          op_mode => sw(12), LED_done =>open, op1_out=>op1);
ssd: display_7seg port map(clk=>clk, cat=>cat, an=>an, digit0=>out_mux(3 downto 0),
     digit1=>out_mux(7 downto 4), digit2=>out_mux(11 downto 8), digit3=>out_mux(15 downto 12));
     
deb: debouncer port map(bttn_in=>BTNC, bttn_out=>btnc_deb,clk=>clk);

with sw(1 downto 0) select out_mux<=op1(15 downto 0) when "00",
                                    op1(31 downto 16) when "01",
                                    op1(47 downto 32) when "10",
                                    op1(63 downto 48) when others;
LED<=sw;
end Behavioral;
