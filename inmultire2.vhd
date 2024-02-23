library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity inmultitor is
port(
x: in std_logic_vector(15 downto 0);
y: in std_logic_vector(15 downto 0);
start: in std_logic;
clk: in std_logic;
rez: out std_logic_vector(31 downto 0);
finishFlag: out std_logic
);
end entity;							 

architecture behaviour of inmultitor is
signal regQ, regB: std_logic_vector(15 downto 0);
signal rstA, loadB, loadQ, shiftAQ, loadSum, tout: std_logic;  
signal regA, sum: std_logic_vector(19 downto 0);
 
begin	
	rez <= regA(15 downto 0) & regQ(15 downto 0);
	
	control: entity work.control
		port map(
		qLast => regQ(3 downto 0),
		startM => start,
		clk => clk,
		rstA => rstA,
		loadB => loadB,
		loadQ => loadQ,
		shiftAQ => shiftAQ,
		loadSum => loadSum,
		finishFlag => finishFlag
		); 
			
   reA: entity work.reg20 
	   port map(
	   s => sum,
	   load => loadSum,
	   si =>  "0000",
	   shift => shiftAQ,
	   rst => rstA,
	   clk => clk,
	   rez => regA
	   ); 
	   
	reQ: entity work.reg16
		port map(
		s => y,
		load => loadQ,
		si => regA(3 downto 0),
		shift => shiftAQ,
		rst => '0',
		clk => clk,
		rez => regQ
		);	 
		
	reB: entity work.reg16
		port map(
		s => x,
		load => loadB,
		si => "0000",
		shift => '0',
		rst => '0',
		clk => clk,
		rez => regB
		);
		
	alu: entity work.sumator_zecimal4_5
		port map(
		x => regB,
		y => regA,
		tin => '0',
		s => sum(19 downto 0),
		tout => tout
		);
	 		
end architecture;