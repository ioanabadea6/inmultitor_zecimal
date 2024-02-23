library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control2 is
port(
qLast: in std_logic_vector(15 downto 0);
startM: in std_logic;
clk: in std_logic;
rstA: out std_logic;
loadB: out std_logic;
loadQ: out std_logic;
shiftAQ: out std_logic;
loadSum: out std_logic;
finishFlag: out std_logic;
sel: out std_logic_vector(3 downto 0);
writeReg: out std_logic;
rstSum: out std_logic
);
end entity;

architecture behaviour of control2 is

type tip_stare is (idle, start, loadReg, loadLast, sum, testN, shift, finish);                                               
signal stare: tip_stare := idle;
signal n:integer;
signal qL: std_logic_vector(3 downto 0);
signaL qLast1: std_logic_vector(15 downto 0);
signal count: std_logic_vector(3 downto 0):= "0001";

begin 
  
	proc2:process(clk)
	begin	
		if(rising_edge(clk)) then
		case stare is	
			when idle => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0'; finishFlag<= '1'; 
			when start => rstA <= '1'; loadB <= '1'; loadQ <= '1'; shiftAQ <= '0'; loadSum <= '0'; finishFlag <= '0'; n <= 4;  qLast1 <= qLast;  count <= "0001"; rstSum <= '0';		
			when loadReg => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0'; count <= count + 1; writeReg <= '1';
			when loadLast => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ <= '0'; loadSum <= '0'; qL <= qLast1(3 downto 0);	 writeReg <= '0';
			when sum => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '0'; loadSum <= '1'; count <= ql;
			when testN => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '0'; loadSum <= '0';
			when shift => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '1'; loadSum <= '0';  n <= n - 1; qLast1 <= "0000" & qLast1(15 downto 4);
			when finish => rstA <= '0'; loadB <= '0'; loadQ <= '0'; shiftAQ<= '1'; loadSum <= '0';  finishFlag <= '1';
		end case; 
		 sel <= count;
		end if;
	end process;
	
   	proc1: process(clk)
	begin	 
		if(rising_edge(clk)) then
			case stare is
				when idle => if (startM = '1') then
							stare <= start;
							end if;
				when start => stare <= loadReg; 
				when loadReg => if(count = "1001")then
									stare <= loadLast;
								else
									stare <= loadReg;
								end if;								
				when loadLast => stare <= sum;
				when sum =>  stare <= testN;
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