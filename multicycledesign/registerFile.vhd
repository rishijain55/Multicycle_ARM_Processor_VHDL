library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerFile is
  port(
    dataout1,dataout2  : out std_logic_vector(31 downto 0);
    datainput       : in  std_logic_vector(31 downto 0);
    writeEnable : in  std_logic;
    reg1Sel,reg2sel,writeadd     : in  std_logic_vector(3 downto 0);
    clk         : in  std_logic
    );
end registerFile;


architecture rtl of registerFile is
  type registerFile is array(0 to 15) of std_logic_vector(31 downto 0);
  signal registers : registerFile:=(others=>(others=>'0'));
begin
    dataout1 <= registers(to_integer(unsigned(reg1Sel)));
    dataout2 <= registers(to_integer(unsigned(reg2Sel)));
  process (clk) is
  begin
    if rising_edge(clk) then
      if writeEnable = '1' then
        registers(to_integer(unsigned(writeadd))) <= datainput;
      end if;
    end if;
  end process;
end rtl;