

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator_4biti is
Port (
    x: in std_logic_vector(3 downto 0);
    y: in std_logic_vector(3 downto 0);
    tin: in std_logic;  
    s: out std_logic_vector(3 downto 0);
    tout: out std_logic
);
end sumator_4biti;

architecture Behavioral of sumator_4biti is
    signal g, p, t: std_logic_vector(3 downto 0);
begin
    s0: entity work.sumator_1bit
        port map(
           x => x(0),
           y => y(0),        
           tin => t(0),
           s => s(0),
           g => g(0),
           p => p(0)
        );
        
    s1: entity work.sumator_1bit
    port map(
        x => x(1),
        y => y(1),
        tin => t(1),
        s => s(1),
        g => g(1),
        p => p(1)
    );
    s2: entity work.sumator_1bit
    port map(
        x => x(2),
        y => y(2),
        tin => t(2),
        s => s(2),
        g => g(2),
        p => p(2) 
    );
    
    s3: entity work.sumator_1bit
    port map(
        x => x(3),
        y => y(3),
        tin => t(3),
        s => s(3),
        g => g(3),
        p => p(3)
    );
    
     
    t(0) <= tin;
    t(1) <= g(0) or (p(0) and t(0));
    t(2) <= g(1) or (p(1) and t(1));
    t(3) <= g(2) or (p(2) and t(2));
	tout <= g(3) or (p(3) and t(3));

end Behavioral;
