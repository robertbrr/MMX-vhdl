library ieee;
use ieee.std_logic_1164.all;

entity full_adder_8b_test is
end entity; 

architecture Behavioral of full_adder_8b_test is
component full_adder_8b is
    Port ( a : in STD_LOGIC_VECTOR(7 downto 0);
           b : in STD_LOGIC_VECTOR(7 downto 0);
           cin : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(7 downto 0);
           cout : out STD_LOGIC;
           overflow: out STD_logic);
end component;
signal cin,cout,overflow:std_logic;
signal a,b,y:std_logic_vector(7 downto 0);
begin
c0: full_adder_8b port map(a=>a,b=>b,cin=>cin,cout=>cout,overflow=>overflow,y=>y);
cin<='0';
a<=x"7f";
b<=x"01";
end architecture;