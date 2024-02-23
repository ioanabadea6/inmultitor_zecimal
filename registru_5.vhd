library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity reg20 is
port(
s: in std_logic_vector(19 downto 0);
load: in std_logic;
si: in std_logic_vector(3 downto 0);   
shift: in std_logic;
rst: in std_logic;
clk: in std_logic;
rez: out std_logic_vector(19 downto 0)
);									   
end entity;


architecture behavour of reg20 is
	 signal content: std_logic_vector(19 downto 0);

begin
	process(clk, rst)
	begin		 
		if(rst = '1') then
			  content <= x"00000";
		else
			if(rising_edge(clk)) then
				if(shift = '1') then
					content(3 downto 0) <= content(7 downto 4);
					content(7 downto 4) <= content(11 downto 8);
					content(11 downto 7) <= content(15 downto 11);
					content(15 downto 12)<= content(19 downto 16);		
					content(19 downto 16) <= si;
				elsif(load = '1') then
					content <= s;
				end if;		
			end if;	   
		end if;
		rez <= content;
	end process;   

end architecture;