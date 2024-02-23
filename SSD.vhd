library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity SSD is
    Port ( clk : in STD_LOGIC;
           digit: in STD_LOGIC_VECTOR(15 downto 0);
           cat : out STD_LOGIC_VECTOR  (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end SSD;

architecture Behavioral of SSD is 

signal temp: std_logic_vector(15 downto 0):="0000000000000000";
signal mux1: std_logic_vector(3 downto 0);

begin 
process(clk)
begin 

if(rising_edge(clk)) then 
temp <= temp+1;
end if;
end process;

process(temp,digit)
begin 

case temp(15 downto 14) is 
when "00"=> mux1 <=digit(3 downto 0);
when "01"=> mux1 <=digit(7 downto 4);
when "10"=> mux1 <=digit(11 downto 8);
when "11"=> mux1 <=digit(15 downto 12);
when others => 
end case;
end process; 

process(temp)
begin 

case temp(15 downto 14) is 
when "00"=> an<="1110";
when "01"=> an<="1101";
when "10"=> an<="1011";
when "11"=> an<="0111";
when others =>
end case;
end process; 

 with mux1 select
  cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0

end Behavioral;
