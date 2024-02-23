


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator_zecimal is
Port (
    x: in std_logic_vector(3 downto 0);
    y: in std_logic_vector(3 downto 0);
    tin: in std_logic;
    s: out std_logic_vector(3 downto 0); 
    tout: out std_logic
 );
end sumator_zecimal;

architecture Behavioral of sumator_zecimal is
signal t,zero, t1:std_logic;
signal sint, xint: std_logic_vector(3 downto 0);	 


begin
	sumator1: entity work.sumator_4biti
		port map(
		x => x,
		y => y, 
		tin => tin,
		s => sint,	
		tout => t 
		);
		
	xint <= '0' & t1 & t1 & '0';	
	sumator2:  entity work.sumator_4biti
		port map(
		x => xint,
		y => sint,
		tin => '0',
		s => s,
		tout => zero
		);
		
		t1 <= t or (sint(3) and sint(2)) or (sint(3) and sint(1));
		tout <= t1;

end Behavioral;
