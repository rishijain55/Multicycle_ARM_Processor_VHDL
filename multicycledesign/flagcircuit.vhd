library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MyTypes.all;
entity flagcircuit is
    port(
        class:in instr_class_type;
        subclass :in DP_subclass_type;
        opet: in optype;
        setflags,shifterCarrySet : in std_logic;
        sbit:in load_store_type;
        carryalu,shifterCarry,a31,b31,clk: in std_logic;
        resultalu: in std_logic_vector(31 downto 0);
        mlout: in std_logic_vector(63 downto 0);
        instruction: in std_logic_vector(31 downto 0);
        reset: in std_logic;
        flags: out std_logic_vector(3 downto 0);
        modeflag: out std_logic
    );
end flagcircuit;

architecture rtl of flagcircuit is
signal flagreg: std_logic_vector(3 downto 0) := "0000";
signal mode: std_logic := '0';
begin
    flags<=flagreg;
    modeflag<=mode;
    process(clk) is
        begin

        if(rising_edge(clk)) then
            if(class = SWI or reset ='1') then
                mode<='1';
            elsif(class =DT  and instruction(4 downto 0) ="10001") then
                mode<='0';
            end if;
        end if;
        if(shifterCarrySet='1' and rising_edge(clk)) then
            flagreg(2)<=shifterCarry;
        end if;          
        if(rising_edge(clk) and setflags ='1') then

            if(class =DP and ((instruction(6 downto 5)="00" and instruction(25 downto 24)="00" and instruction(4)='1' and instruction(7)='1'))) then
                if(instruction(20)='1') then
                    if(instruction(23)='0') then
                        flagreg(1)<= mlout(31);
                        if( mlout(31 downto 0) =X"00000000") then 
                                        flagreg(3)<= '1' ;
                        else
                                        flagreg(3)<= '0' ;
                        end if;
                    else
                        flagreg(1)<= mlout(63);
                        if( mlout(63 downto 0) =X"0000000000000000") then 
                                        flagreg(3)<= '1' ;
                        else
                                        flagreg(3)<= '0' ;
                        end if; 
                    end if;
                end if;              
            elsif(class =DP) then
                case subclass is 
                    when arith=>
                        if(sbit = load) then
                            case opet is
                                when add|adc =>
                                flagreg(0)<= (a31 and b31 and (not resultalu(31)))  or ((not a31) and (not b31) and (resultalu(31)));
                                when sbc| sub =>
                                flagreg(0)<= (a31 and (not b31) and (not resultalu(31)))  or ((not a31) and (b31) and (resultalu(31)));                                 
                                when rsb |rsc =>
                                flagreg(0)<= ((not a31) and b31 and (not resultalu(31)))  or ((a31) and (not b31) and (resultalu(31)));
                                when others=>
                                flagreg(0)<= (a31 and b31 and (not resultalu(31)))  or ((not a31) and (not b31) and (resultalu(31)));
                            end case;
                                    if( resultalu =X"00000000") then 
													flagreg(3)<= '1' ;
												else
													flagreg(3)<= '0' ;
												end if;
                                    flagreg(2)<= carryalu;
                                    flagreg(1)<= resultalu(31);

                        end if; 
                    when logic=>
                        if(sbit=load) then
										if( resultalu =X"00000000") then
											flagreg(3)<= '1' ;
										else
											flagreg(3)<= '0' ;
										end if;     
                            flagreg(1)<= resultalu(31);
                        end if;
                    when test=>
									if( resultalu =X"00000000") then
										flagreg(3)<= '1' ;
									else
										flagreg(3)<= '0' ;
									end if;      
                            flagreg(1)<= resultalu(31);
                    when comp=>
                            case opet is
                                when cmp=>
                                flagreg(0)<= (a31 and (not b31) and (not resultalu(31)))  or ((not a31) and (b31) and (resultalu(31)));                                 
                                when cmn=>
                                flagreg(0)<= (a31 and b31 and (not resultalu(31)))  or ((not a31) and (not b31) and (resultalu(31)));

                                when others=>
                                flagreg(0)<= (a31 and b31 and (not resultalu(31)))  or ((not a31) and (not b31) and (resultalu(31)));

                            end case;
										if( resultalu =X"00000000") then
											flagreg(3)<= '1' ;
										else
											flagreg(3)<= '0' ;
										end if;
                                flagreg(2)<= carryalu;
                                flagreg(1)<= resultalu(31);
                    when others=>
                end case;
            end if;
        end if;
    end process;
end rtl;


