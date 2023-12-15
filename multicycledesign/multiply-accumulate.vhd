library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiply_accumulate is
  port(
        ml1,ml2: in std_logic_vector(31 downto 0);
        acc: in std_logic_vector(63 downto 0);
        instruction: in std_logic_vector(31 downto 0);
        mlout: out std_logic_vector(63 downto 0)
    );
end multiply_accumulate;

architecture rtl of multiply_accumulate is
signal p_s: signed(65 downto 0);
signal x1,x2 : std_logic;
begin
    x1<=ml1(31) and instruction(22);
    x2<=ml2(31) and instruction(22);
    p_s<= signed(x1&ml1)*signed(x2&ml2);
    mlout<= std_logic_vector(p_s(63 downto 0) + signed(acc)) when instruction(21)='1' else std_logic_vector(p_s(63 downto 0)) ;

end rtl;
