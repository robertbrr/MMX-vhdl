library IEEE;
use ieee.std_logic_1164.all;

entity andn_gate is
    Port (a, b : in std_logic_vector(63 downto 0);
    y: out std_logic_vector(63 downto 0));
end entity;

architecture Behavioral of andn_gate is
begin
    y<=a and (not b);
end architecture;