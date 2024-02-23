

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
 
entity project is
Port ( 
sw: in std_logic_vector(15 downto 0);
button1: in std_logic;--schimbare date afisor
button2: in std_logic;--load  input
button3: in std_logic;--alegere metoda
button4: in std_logic;-- start
clk: in std_logic;
an: out std_logic_vector(3 downto 0);
cat: out std_logic_vector(6 downto 0);
finishFlag: out std_logic
);
end project;

architecture Behavioral of project is

signal digit: std_logic_vector(15 downto 0);
signal rez1, rez2, rez: std_logic_vector(31 downto 0):= x"ffffeeee";
signal x, y: std_logic_vector(15 downto 0):= x"0000";
signal start, finishFlag1, finishFlag2, en1, en2, en3: std_logic:= '0';


signal count1: std_logic_vector(1 downto 0):= "00";--date iesire afisor
signal count2: std_logic:= '0';--date intrare
signal count3: std_logic:= '0';
begin 

    debounce1: entity work.debounce
    port map(
       clk => clk,
       rst => '0',
       d_in => button1,
       q_out => en1 
    );
    
    debounce2: entity work.debounce
    port map(
        clk => clk,
        rst => '0',
        d_in => button2,
        q_out => en2
    );
    
    
    debounce3: entity work.debounce
    port map(
        clk => clk,
        rst => '0',
        d_in => button3,
        q_out => en3
    );
    
    debounce4: entity work.debounce
    port map(
        clk => clk,
        rst => '0',
        d_in => button4,
        q_out => start
    );
    
    process(clk, en1)
        begin
            if(rising_edge(clk)) then
                if(en1 = '1') then
                    count1 <= count1 + '1';
                end if;
            end if;
    end process;
    
    with count1 select
        digit <= x when "00",
                 y when "01",
                 rez(15 downto 0) when "10",
                 rez(31 downto 16) when "11",
                 x"0000" when others; 
    
    process(clk, en2)
        begin 
            if(rising_edge(clk)) then
                if(en2 = '1') then
                    count2 <= count2 xor '1';
                end if;
            end if;
           
           if (count2 = '0') then
               x <= sw;
           else
               y <= sw;
           end if;            
    end process;
    
    
    process(clk, en3)
        begin
            if(rising_edge(clk)) then
                if(en3 = '1') then
                    count3 <= count3 xor '1';
                end if;
             end if;
         if(count3 = '0') then
            rez <= rez1;
            finishFlag <= finishFlag1;
         else
            rez <= rez2;
            finishFlag <= finishFlag2;
         end if;    
    end process;
    

    ssd: entity work.SSD
    port map(
    clk => clk,
    digit => digit,
    cat => cat,
    an => an
    );
    
    inm1: entity work.inmultitor
    port map(
    x => x,
    y => y,
    start => start,
    clk => clk,
    rez => rez2,
    finishFlag => finishFlag1     
    );
    
    inm2: entity work.inmultitor1
    port map(
    x => x,
    y => y,
    start => start,
    clk => clk,
    rez => rez1,
    finishFlag => finishFlag2
    ); 
    
end Behavioral;
