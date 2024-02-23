


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity debounce is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           D_in : in STD_LOGIC;
           Q_out : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is


signal Q1, Q2, Q3 : std_logic;
signal nr:std_logic_vector(15 downto 0):=x"0000";


begin  
	q_out<=q2 and not q3;
	process(clk)
	begin
		if(rising_edge(clk))then
		nr<=nr+'1';
		end if;
	end process;
	
	process(clk)
	begin 
	   if(rising_edge(clk))then
	   if(nr=x"ffff")then
		  q1<=d_in;
	   end if; 
	   end if;
	end process;  
	
	 process(clk)
	 	begin
	 	if(rising_edge(clk))then
			q2<=q1;	   	 
			q3<=q2;
		end if;
	 end process;
			
end Behavioral;
