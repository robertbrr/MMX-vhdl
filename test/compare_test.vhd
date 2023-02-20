library ieee;
use ieee.std_logic_1164.all;

entity compare_test is
end entity;

architecture Behavioral of compare_test is
component compare_unit is
    Port ( op1 : in STD_LOGIC_VECTOR (63 downto 0);
           op2 : in STD_LOGIC_VECTOR (63 downto 0);
           ctrl_compare:in std_logic_vector(1 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal op1,op2,result:std_logic_vector(63 downto 0);
signal ctrl_compare: std_logic_vector(1 downto 0);
begin
    c0: compare_unit port map(op1=>op1,op2=>op2,ctrl_compare=>ctrl_compare,result=>result);
    op1<=x"AABBCCDD11223344";
    op2<=x"AABBCCDD11553344";
    ctrl_compare<="00", "01" after 100ns, "10" after 200ns;
end architecture;