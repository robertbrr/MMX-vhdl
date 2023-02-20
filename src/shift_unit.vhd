----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2022 11:20:12 AM
-- Design Name: 
-- Module Name: shifter64 - Behavioral
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

entity shift_unit is
    Port ( operand : in STD_LOGIC_VECTOR (63 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0);
           mode : in STD_LOGIC_VECTOR (2 downto 0);
           amount:in std_logic_vector(63 downto 0));
end shift_unit;

architecture Behavioral of shift_unit is
component mux2_1 is
    port(x0,x1,s:in std_logic;
        y:out std_logic);
end component;

signal qw0,qw1,qw2,qw3,qw4,qw5:std_logic_vector(63 downto 0);

signal aux_level_0: std_logic_vector(2 downto 0);
signal aux_level_1: std_logic_vector(5 downto 0);
signal aux_level_2: std_logic_vector(11 downto 0);
signal aux_level_3: std_logic_vector(23 downto 0);
signal aux_level_4: std_logic_vector(15 downto 0);

signal sel: std_logic_vector(5 downto 0);

signal amount63_5,amount63_4:std_logic;
signal amount63_6: std_logic:='0';

begin
    sel<=amount(5 downto 0);
    
    --LEVEL ZERO--
    mux_0_63: mux2_1 port map(x1=>'0', x0=>operand(63),s=>sel(0),y=>qw0(63));
    mux_0_00: for i in 62 downto 48 generate
        lvl_0: mux2_1 port map(x1=>operand(i+1),x0=>operand(i),s=>sel(0),y=>qw0(i));
        end generate;
    mux_0_01: for i in 46 downto 32 generate
        lvl_0: mux2_1 port map(x1=>operand(i+1),x0=>operand(i),s=>sel(0),y=>qw0(i));
        end generate;
    mux_0_02: for i in 30 downto 16 generate
        lvl_0: mux2_1 port map(x1=>operand(i+1),x0=>operand(i),s=>sel(0),y=>qw0(i));
        end generate;
    mux_0_03: for i in 14 downto 0 generate
        lvl_0: mux2_1 port map(x1=>operand(i+1),x0=>operand(i),s=>sel(0),y=>qw0(i));
        end generate;
    
    aux_level_0(2) <= operand(48) when mode(0) = '0' else '0';
    aux_level_0(1) <= operand(32) when mode(1) = '0' else '0';
    aux_level_0(0) <= operand(16) when mode(0) = '0' else '0'; 
    
    mux_047: mux2_1 port map(x1=>aux_level_0(2),x0=>operand(47),s=>sel(0),y=>qw0(47));
    mux_031: mux2_1 port map(x1=>aux_level_0(1),x0=>operand(31),s=>sel(0),y=>qw0(31));
    mux_015: mux2_1 port map(x1=>aux_level_0(0),x0=>operand(15),s=>sel(0),y=>qw0(15));
    
    --LEVEL ONE--
    mux_1_63_62:for i in 63 downto 62 generate
        lvl_1_0: mux2_1 port map(x1=>'0',x0=>qw0(i),s=>sel(1),y=>qw1(i));
        end generate;
    mux_1_00: for i in 61 downto 48 generate
        lvl_1_1: mux2_1 port map(x1=>qw0(i+2),x0=>qw0(i),s=>sel(1),y=>qw1(i));
        end generate;
    mux_1_01: for i in 45 downto 32 generate
        lvl_1_1: mux2_1 port map(x1=>qw0(i+2),x0=>qw0(i),s=>sel(1),y=>qw1(i));
        end generate;
    mux_1_02: for i in 29 downto 16 generate
        lvl_1_1: mux2_1 port map(x1=>qw0(i+2),x0=>qw0(i),s=>sel(1),y=>qw1(i));
        end generate;
    mux_1_03: for i in 13 downto 0 generate
        lvl_1_1: mux2_1 port map(x1=>qw0(i+2),x0=>qw0(i),s=>sel(1),y=>qw1(i));
        end generate;
    
    aux_level_1(5)<=qw0(49) when mode(0) = '0' else '0';
    aux_level_1(4)<=qw0(48) when mode(0) = '0' else '0';
    
    aux_level_1(3)<=qw0(33) when mode(1) = '0' else '0';
    aux_level_1(2)<=qw0(32) when mode(1) = '0' else '0';
    
    aux_level_1(1)<=qw0(17) when mode(0) = '0' else '0';
    aux_level_1(0)<=qw0(16) when mode(0) = '0' else '0';
    
    mux_1_47: mux2_1 port map(x1=>aux_level_1(5),x0=>qw0(47),s=>sel(1),y=>qw1(47));
    mux_1_46: mux2_1 port map(x1=>aux_level_1(4),x0=>qw0(46),s=>sel(1),y=>qw1(46));
    mux_1_31: mux2_1 port map(x1=>aux_level_1(3),x0=>qw0(31),s=>sel(1),y=>qw1(31));
    mux_1_30: mux2_1 port map(x1=>aux_level_1(2),x0=>qw0(30),s=>sel(1),y=>qw1(30));
    mux_1_15: mux2_1 port map(x1=>aux_level_1(1),x0=>qw0(15),s=>sel(1),y=>qw1(15));
    mux_1_14: mux2_1 port map(x1=>aux_level_1(0),x0=>qw0(14),s=>sel(1),y=>qw1(14));
    
    
    --LEVEL TWO--
    mux_2_63_60:for i in 63 downto 60 generate
        lvl_2_0: mux2_1 port map(x1=>'0',x0=>qw1(i),s=>sel(2),y=>qw2(i));
        end generate;
    mux_2_00: for i in 59 downto 48 generate
        lvl_2_1: mux2_1 port map(x1=>qw1(i+4),x0=>qw1(i),s=>sel(2),y=>qw2(i));
        end generate;
    mux_2_01: for i in 43 downto 32 generate
        lvl_2_1: mux2_1 port map(x1=>qw1(i+4),x0=>qw1(i),s=>sel(2),y=>qw2(i));
        end generate;
   mux_2_02: for i in 27 downto 16 generate
        lvl_2_1: mux2_1 port map(x1=>qw1(i+4),x0=>qw1(i),s=>sel(2),y=>qw2(i));
        end generate;
   mux_2_03: for i in 11 downto 0 generate
        lvl_2_1: mux2_1 port map(x1=>qw1(i+4),x0=>qw1(i),s=>sel(2),y=>qw2(i));
        end generate;
   
    aux_level_2(11)<=qw1(51) when mode(0)='0' else '0';
    aux_level_2(10)<=qw1(50) when mode(0)='0' else '0';
    aux_level_2(9)<= qw1(49) when mode(0)='0' else '0';
    aux_level_2(8)<= qw1(48) when mode(0)='0' else '0';
    
    aux_level_2(7)<=qw1(35) when mode(1)='0' else '0';
    aux_level_2(6)<=qw1(34) when mode(1)='0' else '0';
    aux_level_2(5)<=qw1(33) when mode(1)='0' else '0';
    aux_level_2(4)<=qw1(32) when mode(1)='0' else '0';
    
    aux_level_2(3)<=qw1(19) when mode(0)='0' else '0';
    aux_level_2(2)<=qw1(18) when mode(0)='0' else '0';
    aux_level_2(1)<=qw1(17) when mode(0)='0' else '0';
    aux_level_2(0)<=qw1(16) when mode(0)='0' else '0';
    
    mux_2_47: mux2_1 port map(x1=>aux_level_2(11),x0=>qw1(47),s=>sel(2),y=>qw2(47));
    mux_2_46: mux2_1 port map(x1=>aux_level_2(10),x0=>qw1(46),s=>sel(2),y=>qw2(46));
    mux_2_45: mux2_1 port map(x1=>aux_level_2(9), x0=>qw1(45),s=>sel(2),y=>qw2(45));
    mux_2_44: mux2_1 port map(x1=>aux_level_2(8), x0=>qw1(44),s=>sel(2),y=>qw2(44));
   
    mux_2_31: mux2_1 port map(x1=>aux_level_2(7), x0=>qw1(31),s=>sel(2),y=>qw2(31));
    mux_2_30: mux2_1 port map(x1=>aux_level_2(6), x0=>qw1(30),s=>sel(2),y=>qw2(30));
    mux_2_29: mux2_1 port map(x1=>aux_level_2(5), x0=>qw1(29),s=>sel(2),y=>qw2(29));
    mux_2_28: mux2_1 port map(x1=>aux_level_2(4), x0=>qw1(28),s=>sel(2),y=>qw2(28));
   
    mux_2_15: mux2_1 port map(x1=>aux_level_2(3), x0=>qw1(15),s=>sel(2),y=>qw2(15));
    mux_2_14: mux2_1 port map(x1=>aux_level_2(2), x0=>qw1(14),s=>sel(2),y=>qw2(14));
    mux_2_13: mux2_1 port map(x1=>aux_level_2(1), x0=>qw1(13),s=>sel(2),y=>qw2(13));
    mux_2_12: mux2_1 port map(x1=>aux_level_2(0), x0=>qw1(12),s=>sel(2),y=>qw2(12));
    
    --LEVEL THREE--
    mux_3_63_56:for i in 63 downto 56 generate
        lvl_3_0: mux2_1 port map(x1=>'0',x0=>qw2(i),s=>sel(3),y=>qw3(i));
    end generate;
    mux_3_00: for i in 55 downto 48 generate
        lvl_3_1: mux2_1 port map(x1=>qw2(i+8),x0=>qw2(i),s=>sel(3),y=>qw3(i));
    end generate;
    mux_3_01: for i in 39 downto 32 generate
        lvl_3_1: mux2_1 port map(x1=>qw2(i+8),x0=>qw2(i),s=>sel(3),y=>qw3(i));
    end generate;
    mux_3_02: for i in 23 downto 16 generate
        lvl_3_1: mux2_1 port map(x1=>qw2(i+8),x0=>qw2(i),s=>sel(3),y=>qw3(i));
    end generate;
    mux_3_03: for i in 7 downto 0 generate
        lvl_3_1: mux2_1 port map(x1=>qw2(i+8),x0=>qw2(i),s=>sel(3),y=>qw3(i));
    end generate;
    
    aux_level_3(23)<=qw2(55) when mode(0) = '0' else '0';
    aux_level_3(22)<=qw2(54) when mode(0) = '0' else '0';
    aux_level_3(21)<=qw2(53) when mode(0) = '0' else '0';
    aux_level_3(20)<=qw2(52) when mode(0) = '0' else '0';
    aux_level_3(19)<=qw2(51) when mode(0) = '0' else '0';
    aux_level_3(18)<=qw2(50) when mode(0) = '0' else '0';
    aux_level_3(17)<=qw2(49) when mode(0) = '0' else '0';
    aux_level_3(16)<=qw2(48) when mode(0) = '0' else '0';
    
    aux_level_3(15)<=qw2(39) when mode(1) = '0' else '0';
    aux_level_3(14)<=qw2(38) when mode(1) = '0' else '0';
    aux_level_3(13)<=qw2(37) when mode(1) = '0' else '0';
    aux_level_3(12)<=qw2(36) when mode(1) = '0' else '0';
    aux_level_3(11)<=qw2(35) when mode(1) = '0' else '0';
    aux_level_3(10)<=qw2(34) when mode(1) = '0' else '0';
    aux_level_3(9) <=qw2(33) when mode(1) = '0' else '0';
    aux_level_3(8) <=qw2(32) when mode(1) = '0' else '0';
    
    aux_level_3(7)<=qw2(23) when mode(0) = '0' else '0';
    aux_level_3(6)<=qw2(22) when mode(0) = '0' else '0';
    aux_level_3(5)<=qw2(21) when mode(0) = '0' else '0';
    aux_level_3(4)<=qw2(20) when mode(0) = '0' else '0';
    aux_level_3(3)<=qw2(19) when mode(0) = '0' else '0';
    aux_level_3(2)<=qw2(18) when mode(0) = '0' else '0';
    aux_level_3(1)<=qw2(17) when mode(0) = '0' else '0';
    aux_level_3(0)<=qw2(16) when mode(0) = '0' else '0';   
    
    mux_3_47: mux2_1 port map(x1=>aux_level_3(23),x0=>qw2(47),s=>sel(3),y=>qw3(47));
    mux_3_46: mux2_1 port map(x1=>aux_level_3(22),x0=>qw2(46),s=>sel(3),y=>qw3(46));
    mux_3_45: mux2_1 port map(x1=>aux_level_3(21),x0=>qw2(45),s=>sel(3),y=>qw3(45));
    mux_3_44: mux2_1 port map(x1=>aux_level_3(20),x0=>qw2(44),s=>sel(3),y=>qw3(44));
    mux_3_43: mux2_1 port map(x1=>aux_level_3(19),x0=>qw2(43),s=>sel(3),y=>qw3(43));
    mux_3_42: mux2_1 port map(x1=>aux_level_3(18),x0=>qw2(42),s=>sel(3),y=>qw3(42));
    mux_3_41: mux2_1 port map(x1=>aux_level_3(17),x0=>qw2(41),s=>sel(3),y=>qw3(41));
    mux_3_40: mux2_1 port map(x1=>aux_level_3(16),x0=>qw2(40),s=>sel(3),y=>qw3(40));
                                                                      
    mux_3_31: mux2_1 port map(x1=>aux_level_3(15),x0=>qw2(31),s=>sel(3),y=>qw3(31));
    mux_3_30: mux2_1 port map(x1=>aux_level_3(14),x0=>qw2(30),s=>sel(3),y=>qw3(30));
    mux_3_29: mux2_1 port map(x1=>aux_level_3(13),x0=>qw2(29),s=>sel(3),y=>qw3(29));
    mux_3_28: mux2_1 port map(x1=>aux_level_3(12),x0=>qw2(28),s=>sel(3),y=>qw3(28));
    mux_3_27: mux2_1 port map(x1=>aux_level_3(11),x0=>qw2(27),s=>sel(3),y=>qw3(27));
    mux_3_26: mux2_1 port map(x1=>aux_level_3(10),x0=>qw2(26),s=>sel(3),y=>qw3(26));
    mux_3_25: mux2_1 port map(x1=>aux_level_3(9),x0=> qw2(25),s=>sel(3),y=>qw3(25));
    mux_3_24: mux2_1 port map(x1=>aux_level_3(8),x0=> qw2(24),s=>sel(3),y=>qw3(24));
                                                                    
    mux_3_15: mux2_1 port map(x1=>aux_level_3(7),x0=>qw2(15),s=>sel(3),y=>qw3(15));
    mux_3_14: mux2_1 port map(x1=>aux_level_3(6),x0=>qw2(14),s=>sel(3),y=>qw3(14));
    mux_3_13: mux2_1 port map(x1=>aux_level_3(5),x0=>qw2(13),s=>sel(3),y=>qw3(13));
    mux_3_12: mux2_1 port map(x1=>aux_level_3(4),x0=>qw2(12),s=>sel(3),y=>qw3(12));
    mux_3_11: mux2_1 port map(x1=>aux_level_3(3),x0=>qw2(11),s=>sel(3),y=>qw3(11));
    mux_3_10: mux2_1 port map(x1=>aux_level_3(2),x0=>qw2(10),s=>sel(3),y=>qw3(10));
    mux_3_09: mux2_1 port map(x1=>aux_level_3(1),x0=>qw2(9),s=>sel(3),y=>qw3(9));
    mux_3_08: mux2_1 port map(x1=>aux_level_3(0),x0=>qw2(8),s=>sel(3),y=>qw3(8));
    
    --LEVEL FOUR--
    mux_4_63_48:for i in 63 downto 48 generate
        lvl_4_0: mux2_1 port map(x1=>'0',x0=>qw3(i),s=>sel(4),y=>qw4(i));
    end generate;
    mux_4_02: for i in 47 downto 32 generate
        lvl_4_1: mux2_1 port map(x1=>qw3(i+16),x0=>qw3(i),s=>sel(4),y=>qw4(i));
    end generate;
     mux_4_01: for i in 15 downto 0 generate
        lvl_4_1: mux2_1 port map(x1=>qw3(i+16),x0=>qw3(i),s=>sel(4),y=>qw4(i));
    end generate;  
    
    aux_level_4(15)<=qw3(47) when mode(2) = '0' else '0';
    aux_level_4(14)<=qw3(46) when mode(2) = '0' else '0';
    aux_level_4(13)<=qw3(45) when mode(2) = '0' else '0';
    aux_level_4(12)<=qw3(44) when mode(2) = '0' else '0';
    aux_level_4(11)<=qw3(43) when mode(2) = '0' else '0';
    aux_level_4(10)<=qw3(42) when mode(2) = '0' else '0';
    aux_level_4(9) <=qw3(41) when mode(2) = '0' else '0';
    aux_level_4(8) <=qw3(40) when mode(2) = '0' else '0';
    aux_level_4(7) <=qw3(39) when mode(2) = '0' else '0';
    aux_level_4(6) <=qw3(38) when mode(2) = '0' else '0';
    aux_level_4(5) <=qw3(37) when mode(2) = '0' else '0';
    aux_level_4(4) <=qw3(36) when mode(2) = '0' else '0';
    aux_level_4(3) <=qw3(35) when mode(2) = '0' else '0';
    aux_level_4(2) <=qw3(34) when mode(2) = '0' else '0';
    aux_level_4(1) <=qw3(33) when mode(2) = '0' else '0';
    aux_level_4(0) <=qw3(32) when mode(2) = '0' else '0';
        
    mux_4_31: mux2_1 port map(x1=>aux_level_4(15), x0=>qw3(31),s=>sel(4),y=>qw4(31));
    mux_4_30: mux2_1 port map(x1=>aux_level_4(14), x0=>qw3(30),s=>sel(4),y=>qw4(30));
    mux_4_29: mux2_1 port map(x1=>aux_level_4(13), x0=>qw3(29),s=>sel(4),y=>qw4(29));
    mux_4_28: mux2_1 port map(x1=>aux_level_4(12), x0=>qw3(28),s=>sel(4),y=>qw4(28));
    mux_4_27: mux2_1 port map(x1=>aux_level_4(11), x0=>qw3(27),s=>sel(4),y=>qw4(27));
    mux_4_26: mux2_1 port map(x1=>aux_level_4(10), x0=>qw3(26),s=>sel(4),y=>qw4(26));
    mux_4_25: mux2_1 port map(x1=>aux_level_4(9),  x0=>qw3(25),s=>sel(4),y=>qw4(25));
    mux_4_24: mux2_1 port map(x1=>aux_level_4(8),  x0=>qw3(24),s=>sel(4),y=>qw4(24));
    mux_4_23: mux2_1 port map(x1=>aux_level_4(7),  x0=>qw3(23),s=>sel(4),y=>qw4(23));
    mux_4_22: mux2_1 port map(x1=>aux_level_4(6),  x0=>qw3(22),s=>sel(4),y=>qw4(22));
    mux_4_21: mux2_1 port map(x1=>aux_level_4(5),  x0=>qw3(21),s=>sel(4),y=>qw4(21));
    mux_4_20: mux2_1 port map(x1=>aux_level_4(4),  x0=>qw3(20),s=>sel(4),y=>qw4(20));
    mux_4_19: mux2_1 port map(x1=>aux_level_4(3),  x0=>qw3(19),s=>sel(4),y=>qw4(19));
    mux_4_18: mux2_1 port map(x1=>aux_level_4(2),  x0=>qw3(18),s=>sel(4),y=>qw4(18));
    mux_4_17: mux2_1 port map(x1=>aux_level_4(1),  x0=>qw3(17),s=>sel(4),y=>qw4(17));
    mux_4_16: mux2_1 port map(x1=>aux_level_4(0),  x0=>qw3(16),s=>sel(4),y=>qw4(16));
       
    --LEVEL FIVE--
    mux_5_63_32:for i in 63 downto 32 generate
        lvl_5_0: mux2_1 port map(x1=>'0',x0=>qw4(i),s=>sel(5),y=>qw5(i));
    end generate;
    mux_5: for i in 31 downto 0 generate
        lvl_5_1: mux2_1 port map(x1=>qw4(i+32),x0=>qw4(i),s=>sel(5),y=>qw5(i));
    end generate;     
    
    --ALL LEVELS DONE--
        
    --mode = 000 shift qword
    --mode = 011 shift word
    --mode = 110 shift dword
      
    amount63_6<='0' when (amount(63 downto 6) = "0000000000000000000000000000000000000000000000000000000000") else '1';
    amount63_5<=amount63_6 or amount(5);
    amount63_4<=amount63_5 or amount(4);
    
    result <= (others=>'0') when 
        (amount63_6 or (amount63_5 and mode(2) and mode(1) and (not mode(0)))
        or (amount63_4 and (not mode(2) and mode(1) and mode(0)))) ='1' 
        else qw5;
                                      
end Behavioral;
