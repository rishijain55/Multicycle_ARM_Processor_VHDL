library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conditionchecker is
    port(
        instr: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        res: out std_logic
    );
end conditionchecker;

architecture rtl of conditionchecker is

begin
	process(instr,flags) is
    begin
    case instr(31 downto 28 ) is 
    when "0000"=>
        res<= flags(3);
    when "0001"=>
        res<= not flags(3);
    when "0010"=>
        res<= flags(2);
    when "0011"=>
        res<= not flags(2);
    when "0100"=>
        res<=  flags(1);
    when "0101"=>
        res<= not flags(1);
    when "0110"=>
        res<= flags(0);
    when "0111"=>
        res<= not flags(0);
    when "1000"=>
        res<= (not flags(3)) and flags(2) ;
    when "1001"=>
        res<= not ((not flags(3)) and flags(2));
    when "1010"=>
        res<= not (flags(1) xor flags(0));
    when "1011"=>
        res<= (flags(1) xor flags(0));
    when "1100"=>
        res<= ((not flags(3)) and (not (flags(1) xor flags(0)))) ;
    when "1101"=>
        res<= not ((not flags(3)) and (not (flags(1) xor flags(0))));
    when "1110"=>
        res<= '1';
    when others=>
    	res<='0';
    end case;
	end process;
end rtl;


