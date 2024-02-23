library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity register_file is
port(
rst: in std_logic;
clk: in std_logic;
x: in std_logic_vector(19 downto 0);
w: in std_logic;
sel: in std_logic_vector(3 downto 0);
zant: out std_logic_vector(19 downto 0);
z: out std_logic_vector(19 downto 0)
);
end entity;

architecture behavioral of register_file is
	type reg_type is array(0 to 15) of std_logic_vector(19 downto 0);
	
	signal sume: reg_type :=(others => x"00000");
	
	begin
	process(clk)
	begin
	    if(rst = '1') then
	       sume <= (others => x"00000");
		elsif(rising_edge(clk)) then
			if(w = '1') then
				sume(conv_integer(sel)) <= x;
            end if;
		end if;
		zant <= sume(conv_integer(sel - 1)); 
        z <= sume(conv_integer(sel));	 
	end process;	
	
	
end architecture;