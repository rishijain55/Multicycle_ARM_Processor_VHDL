
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataMem is
  port(
    dataout  : out std_logic_vector(31 downto 0);
    datainput       : in  std_logic_vector(31 downto 0);
    we1,we2,we3,we4 : in  std_logic;
    readadd    : in  std_logic_vector(6 downto 0);
    modeflag : in std_logic;
    clk    : in  std_logic
    );
end dataMem;

architecture rtl of dataMem is
  type Memory is array(0 to 127) of std_logic_vector(31 downto 0);
  signal registers : Memory:=(0 => X"EA000006",2 => X"EA00000C",8 => X"E3A0EC01",9 => X"E6000011",16 => X"E3A0000C",17 => X"E5900000",18 => X"E6000011",64=>X"E3A00002",65=>X"E3A01001",66=>X"E1500001",67=>X"03A03007",68=>X"C0803001",69=>X"00433002",70=>X"00030291",71=>X"EF000000",others => X"00000000");
  begin

    dataout <= registers(to_integer(unsigned(readadd))) when (modeflag ='1' or readadd(6)='1') else X"00000000";
  process (clk) is
  begin
    if rising_edge(clk) then
      if we4 = '1' and (modeflag ='1' or readadd(6)='1') then
        registers(to_integer(unsigned(readadd)))(7 downto 0) <= datainput(7 downto 0);
      end if;
      if we3 = '1' and (modeflag ='1' or readadd(6)='1') then
        registers(to_integer(unsigned(readadd)))(15 downto 8) <= datainput(15 downto 8);
      end if;
      if we2 = '1' and (modeflag ='1' or readadd(6)='1') then
        registers(to_integer(unsigned(readadd)))(23 downto 16) <= datainput(23 downto 16);
      end if;
      if we1 = '1' and (modeflag ='1' or readadd(6)='1') then
        registers(to_integer(unsigned(readadd)))(31 downto 24) <= datainput(31 downto 24);
      end if;
    end if;
  end process;
end rtl;
