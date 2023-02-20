library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity shift_test is
end shift_test;

architecture Behavioral of shift_test is    
component shift_unit is
    Port ( operand : in STD_LOGIC_VECTOR (63 downto 0);
           result: out std_logic_vector(63 downto 0);
           mode : in STD_LOGIC_VECTOR (2 downto 0);
           amount:in std_logic_vector(63 downto 0));
end component;
signal amount: std_logic_vector(63 downto 0):=(others=>'0');
signal operand,result:std_logic_vector(63 downto 0);
signal mode:std_logic_vector(2 downto 0);
begin
    su: shift_unit port map(operand=>operand,result=>result,amount=>amount,mode=>mode);
    operand<=x"ABCDABCD12345678";
    
--    mode<="011"; --shift word
--    amount<=(others=>'0'), x"0000000000000008" after 50ns, 
--                           x"000000000000000A" after 100ns, 
--                           x"000000000000000F" after 150ns,
--                           x"0000000000000010" after 200ns, 
--                           x"000000000000A001" after 250ns;
--    mode<="110"; --shift dword
--    amount<=(others=>'0'), x"0000000000000010" after 50ns, 
--                           x"000000000000000A" after 100ns, 
--                           x"000000000000001F" after 150ns,
--                           x"0000000000000020" after 200ns, 
--                           x"00000000F0000001" after 250ns;
                           
    mode<="000"; --shift qword
    amount<=(others=>'0'), x"000000000000000C" after 50ns, 
                           x"000000000000000E" after 100ns, 
                           x"000000000000003F" after 150ns,
                           x"0000000000000040" after 200ns, 
                           x"0000000000C00004" after 250ns; 
end architecture;
