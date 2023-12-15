-- Testbench for Processor
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.MyTypes.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component processor is
    port(clk,reset: in std_logic;
        datain: in std_logic_vector(8 downto 0)
    );
end component;

signal clk,reset: std_logic:='0';
signal datain: std_logic_vector(8 downto 0);
begin

  -- Connect DUT
  DUT: processor port map(clk,reset,datain);

  process
  begin
    datain<="100000101";
    reset<='0';
  for i in 0 to 39 loop
  wait for 1 ns;
  clk <= not clk;
  wait for 1 ns;
  clk <= not clk;
  end loop;
  reset<='1';
  clk<='0';
  wait for 1 ns;
  clk<='1';
  wait for 1 ns;
  clk<='0';
  reset<='0';
  wait for 1 ns;
  clk<='1';
  wait for 1 ns;
  for i in 0 to 49 loop
  wait for 1 ns;
  clk <= not clk;
  wait for 1 ns;
  clk <= not clk;
  end loop;
    wait;
  end process;
end tb;