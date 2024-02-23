library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity sumator_zecimal_5 is
port(
x: in std_logic_vector(19 downto 0);
y: in std_logic_vector(19 downto 0);
tin: in std_logic;
s: out std_logic_vector(19 downto 0);
tout: out std_logic
);
end sumator_zecimal_5;

architecture behaviour of sumator_zecimal_5 is

	signal t1, t2, t3, t4: std_logic;
begin
	s0: entity work.sumator_zecimal
		port map(
		x => x(3 downto 0),
		y => y(3 downto 0),
		tin => tin,
		s => s(3 downto 0),
		tout => t1
		);
		
	s1: entity work.sumator_zecimal
		port map(
		x => x(7 downto 4),
		y => y(7 downto 4),
		tin => t1,
		s => s(7 downto 4),
		tout => t2
		);	
	s2: entity work.sumator_zecimal
		port map(
		x => x(11 downto 8),
		y => y(11 downto 8),
		tin => t2,
		s => s(11 downto 8),
		tout => t3
		);
	s3: entity work.sumator_zecimal
		port map(
		x => x(15 downto 12),
		y => y(15 downto 12),
		tin => t3,
		s => s(15 downto 12),
		tout => t4
		);	
		
	s4: entity work.sumator_zecimal
		port map(
		x => x(19 downto 16),
		y => y(19 downto 16),
		tin => t4,
		s => s(19 downto 16),
		tout => tout
		);
		
end architecture;