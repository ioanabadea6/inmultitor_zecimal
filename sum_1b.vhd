

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator_1bit is 
Port ( 
x: in std_logic;
y: in std_logic;
tin: in std_logic;
s: out std_logic;
g: out std_logic;
p: out std_logic
);
end sumator_1bit;

architecture Behavioral of sumator_1bit is

begin
    s <= x xor y xor tin;
    g <= x and y;
    p <= x or y;

end Behavioral;
