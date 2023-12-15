
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MyTypes.all;

entity PMconnect is
  port(
        Rout,Mout,Instruction : in std_logic_vector(31 downto 0);
        Adr10: in std_logic_vector(1 downto 0);
        MWset: in std_logic_vector(3 downto 0);
        ins_class : in instr_class_type;
        load_store : in load_store_type;
        Rin,Min : out std_logic_vector(31 downto 0);
        MW : out std_logic_vector(3 downto 0)
    );
end PMconnect;

architecture rtl of PMconnect is
begin
    process(Mout,Instruction,Adr10,MWset,ins_class,load_store) is
    begin
    if(ins_class =DT and load_store=load and Instruction(22)='1') then
        Rin(31 downto 8) <= X"000000";
                if(Adr10 ="00") then
                    Rin(7 downto 0)<= Mout(7 downto 0);
                elsif(Adr10 ="01") then
                    Rin(7 downto 0)<= Mout(15 downto 8);
                elsif(Adr10 ="10") then
                    Rin(7 downto 0)<= Mout(23 downto 16);
                else
                    Rin(7 downto 0)<= Mout(31 downto 24);
                end if;
    elsif(ins_class = DP and load_store = load and Instruction(4)='1' and Instruction(7)='1') then
        case Instruction(6 downto 5) is
            when "01" =>
                Rin(31 downto 16)<= X"0000";
                if(Adr10 ="00") then
                    Rin(15 downto 0)<=Mout(15 downto 0);
                elsif(Adr10 ="10") then
                    Rin(15 downto 0)<=Mout(31 downto 16);
                else 
                    Rin(15 downto 0)<=Mout(15 downto 0);
                end if;
            when "11" =>
                if(Adr10 ="00") then
                    Rin(31 downto 16) <= (others=>Mout(15));
                    Rin(15 downto 0)<=Mout(15 downto 0);
                elsif(Adr10 ="10") then
                    Rin(31 downto 16) <= (others=>Mout(31));
                    Rin(15 downto 0)<=Mout(31 downto 16);
                else 
                    Rin(31 downto 16) <= (others=>'0');
                    Rin(15 downto 0)<=Mout(15 downto 0);
                end if;
            when "10" =>
                if(Adr10 ="00") then
                    Rin(31 downto 8) <= (others=>Mout(7));
                    Rin(7 downto 0)<= Mout(7 downto 0);
                elsif(Adr10 ="01") then
                    Rin(31 downto 8) <= (others=>Mout(15));
                    Rin(7 downto 0)<= Mout(15 downto 8);
                elsif(Adr10 ="10") then
                    Rin(31 downto 8) <= (others=>Mout(23));
                    Rin(7 downto 0)<= Mout(23 downto 16);
                else
                    Rin(31 downto 8) <= (others=>Mout(31));
                    Rin(7 downto 0)<= Mout(31 downto 24);
                end if;
            when others =>
                Rin<= Mout;
            end case;
    else 
        Rin<= Mout;
    end if;

    end process;
    process(Rout,Instruction,Adr10,MWset,ins_class,load_store) is
    begin
    if(ins_class =DT and load_store=store and Instruction(22)='1' and MWset = "1111") then
        Min(31 downto 24 )<= Rout(7 downto 0);
        Min(23 downto 16 )<= Rout(7 downto 0);
        Min(15 downto 8 )<= Rout(7 downto 0);
        Min(7 downto 0 )<= Rout(7 downto 0);
            if(Adr10 ="00") then
                MW <="0001";
            elsif(Adr10 ="01") then
                MW <="0010";
            elsif(Adr10 ="10") then
                MW <="0100";
            else
                MW <="1000";
            end if;
    elsif(ins_class = DP and load_store = store and Instruction(4)='1' and Instruction(7)='1' and MWset ="1111" and Instruction(6 downto 5)= "01") then
        Min(31 downto 16 )<= Rout(15 downto 0);
        Min(15 downto 0 )<= Rout(15 downto 0);
        if(Adr10 ="00" ) then
            MW<="0011";
        elsif(Adr10="10") then 
            MW <="1100";
        else 
            MW<="0011";
        end if;
    elsif(MWset ="1111") then
        Min<= Rout;
        MW<="1111";
    else
        Min<=Rout;
        MW<="0000";
    end if;
    end process;
end rtl;
