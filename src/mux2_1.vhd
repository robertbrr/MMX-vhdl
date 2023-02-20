library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
    port(x0,x1,s:in std_logic;
        y:out std_logic);
end entity;

architecture Behavioral of mux2_1 is   

begin
    y<=x0 when s='0' else x1;
end architecture;
