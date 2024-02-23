library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity inmultitor1 is
port(
x: in std_logic_vector(15 downto 0);
y: in std_logic_vector(15 downto 0);
start: in std_logic;
clk: in std_logic;
rez: out std_logic_vector(31 downto 0);
finishFlag: out std_logic
);
end entity;

architecture behaviour of inmultitor1 is 
	signal tout, tout1: std_logic;
    signal regQ: std_logic_vector(15 downto 0);
    signal regA: std_logic_vector(19 downto 0);
	
	signal sel: std_logic_vector(3 downto 0);
	signal savedSum, savedAntSum: std_logic_vector(19 downto 0);
    signal loadSum, shiftAQ, rstA, loadB, loadQ, writeReg, rstSum: std_logic;
	signal sum, sum1: std_logic_vector(19 downto 0);
	
begin	 
	rez <= regA(15 downto 0) & regQ(15 downto 0);
	
	sum_register: entity work.sumator_zecimal4_5
	port map(
		x => x,
		y => savedAntSum,
		tin => '0',
		s => sum1,
		tout => tout
		);
		
	reg_file: entity work.register_file 
	port map(
	   rst => rstSum,
	   clk => clk,
	   x => sum1,
	   w => writeReg,
	   sel => sel,
	   zant => savedAntSum,
	   z => savedSum
	);
	 
	control: entity work.control2
		port map(
		qLast => y,
		startM => start,
		clk => clk,
		rstA => rstA,
		loadB => loadB,
		loadQ => loadQ,
		shiftAQ => shiftAQ,
		loadSum => loadSum,
		finishFlag => finishFlag,
		writeReg => writeReg,
		sel => sel,
		rstSum => rstSum
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
	 	
	alu: entity work.sumator_zecimal_5
		port map(
		x => savedSum,
		y => regA,
		tin => '0',
		s => sum(19 downto 0),
		tout => tout1
		);

end architecture;