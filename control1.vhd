 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
port(
qLast: in std_logic_vector(3 downto 0);
startM: in std_logic;
clk: in std_logic;
rstA: out std_logic;
loadB: out std_logic;
loadQ: out std_logic;
shiftAQ: out std_logic;
loadSum: out std_logic;
finishFlag: out std_logic
);
end entity;


architecture behaviour of control is

type tip_stare is (idle, start, loadLast, testLast, decrementLast, testN, shift, finish);
signal stare: tip_stare := idle;
signal n:integer;
signal qL: std_logic_vector(3 downto 0);
begin 
		proc2:process(stare, qLast)
	
	begin	  
		case stare is	
			when idle => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0'; finishFlag<= '1';
			when start => rstA <= '1'; loadB <= '1'; loadQ <= '1'; shiftAQ <= '0'; loadSum <= '0'; finishFlag <= '0'; n <= 3; 
			when loadLast => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0'; qL <= qLast;
			when testLast => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0';
			when decrementLast => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '0'; loadSum <= '1';  qL <= qL - 1;
			when testN => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '0'; loadSum <= '0';
			when shift => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '1'; loadSum <= '0';  n <= n - 1;
			when finish => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '1'; loadSum <= '0';  finishFlag <= '1';
		end case;
	end process;
	
   	proc1: process(clk, qLast)
	begin	 
		if(rising_edge(clk)) then
			case stare is
				when idle => if (startM = '1') then
							stare <= start;
						end if;
				when start => stare <= loadLast; 
				when loadLast => stare <= testLast;
				when testLast => 
								if(qL = "0000") then
									stare <= testN;
								else
									stare <= decrementLast;
								end if;	
				when decrementLast => stare <= testLast;
				when testN => if (n = 0) then 
							  stare <= finish;
							  else
							  stare <= shift;
							  end if;		 
				when shift => stare <= loadLast; 
				when finish => stare <= idle;
			end case;  
		
		end if;	   
	end process;	  
	   
	   


end architecture;