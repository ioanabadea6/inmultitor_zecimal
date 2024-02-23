


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity simMul is
--  Port ( );
end simMul;

architecture Behavioral of simMul is

signal x:std_logic_vector(15 downto 0);
signal y:std_logic_vector(15 downto 0);
signal start, clk, finishFlag: std_logic;

signal RezReal1 : STD_LOGIC_VECTOR(31 downto 0);
  
constant CLK_PERIOD : TIME := 10 ns;


begin
sim:entity WORK.inmultitor1 port map(
    x => x,
    y => y,
    start => start,
    clk => clk,
    rez => rezReal1,
    finishFlag => finishFlag);

gen_clk: process
 begin
 Clk <= '0';
 wait for (CLK_PERIOD/2);
 Clk <= '1';
 wait for (CLK_PERIOD/2);
 end process gen_clk;
 
    
   process
   variable RezCorect: integer;
   variable NrErori: INTEGER:=0;
   variable i,j,k:INTEGER;
    begin 
 
       for i in 1 to 3 loop     
         for j in 1 to 3 loop           
          
              X<=conv_std_logic_vector(i,16);
              Y<=conv_std_logic_vector(j,16);
              start<='1';
              wait for 10 ns;
              start<='0';
              wait for 10000 ns;
              RezCorect:=i*j;
              if(conv_integer(rezReal1)/=RezCorect) then 
                report "Rezultat gresit";
                report "Rezultat asteptat: " & INTEGER'image(RezCorect)& " X: "& INTEGER'image(conv_integer(x))& " Y: "& INTEGER'image(conv_integer(Y))& " Rezultat obtinut " & INTEGER'image(conv_integer(rezReal1));
                NrErori:=NrErori+1;
              end if;
             
          end loop;
     end loop;
     wait for 10 ns;
     
     
     
     for i in 114 to 119 loop     
         for j in 114 to 119 loop           
    
              X<=conv_std_logic_vector(i,16);
              Y<=conv_std_logic_vector(j,16);
              start<='1';
              wait for 4 ns;
              start<='0';
              wait for 30000 ns;
              RezCorect:=i*j;
              if(conv_integer(signed(rezReal1))/=RezCorect) then 
                report "Rezultat gresit";
                report "Rezultat asteptat: " & INTEGER'image(RezCorect)& " X: "& INTEGER'image(conv_integer(x))& " Y: "& INTEGER'image(conv_integer(Y))& " Rezultat obtinut " & INTEGER'image(conv_integer(rezReal1));
                NrErori:=NrErori+1;
              end if;
             
          end loop;
     end loop;
 
wait for 10 ns;
     for i in 127 to 190 loop     
         for j in 127 to 190 loop           
              X<=conv_std_logic_vector(i,16);
              Y<=conv_std_logic_vector(j,16);
              start<='1';
              wait for 10ns;
              start<='0';
              wait for 3000 ns;
              RezCorect:=i*j;
              if(conv_integer(signed(rezReal1))/=RezCorect) then 
                report "Rezultat gresit";
                report "Rezultat asteptat: " & INTEGER'image(RezCorect)& " X: "& INTEGER'image(conv_integer(x))& " Y: "& INTEGER'image(conv_integer(Y))& " Rezultat obtinut " & INTEGER'image(conv_integer(rezReal1));
                NrErori:=NrErori+1;
              end if;
          end loop;
     end loop;
    report "Nr erori: " & INTEGER'image(NrErori);
  end process;        
 


end Behavioral;
