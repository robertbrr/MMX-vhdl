library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity debouncer is
    Port ( clk : in STD_LOGIC;
           bttn_in : in STD_LOGIC;
           bttn_out : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
signal count_int:std_logic_vector(31 downto 0):=(others=>'0');
signal Q1: std_logic;
signal Q2: std_logic;
signal Q3: std_logic;
begin
bttn_out<=Q2 and (not Q3);
process(clk)
begin
    if rising_edge(clk) then
        count_int<=count_int+1;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if count_int(15 downto 0) = x"FFFF" then
            Q1<=bttn_in;
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        Q2<=Q1;
        Q3<=Q2;
    end if;
end process;

end Behavioral;
