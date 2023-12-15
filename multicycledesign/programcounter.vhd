library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity programcounter is
    port(
      inputcount: std_logic_vector(31 downto 0);
       PW,clk : in std_logic;
      outputcount : out std_logic_vector(31 downto 0)
    );
end programcounter;

architecture rtl of programcounter is

signal programregister: std_logic_vector(31 downto 0):= X"00000100" ;
begin
  outputcount<=programregister;
    process(clk) is
        begin
            if(rising_edge(clk)) and (PW='1') then
              programregister<= inputcount;
            end if;
    end process;
end rtl;