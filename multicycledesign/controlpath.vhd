library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MyTypes.all;
use IEEE.NUMERIC_STD.ALL;

entity controlpath is
    port(
        instruction: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        statusbit,reset,clk: in std_logic;
        PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,CW,DRW,SD,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,shifterCarrySet: out std_logic;
        Asrc2,Rsrc,SS,M2R,RESOrSaveAdrS,retOrBranchS: out std_logic_vector(1 downto 0);
        MWset,op:out  std_logic_vector(3 downto 0)
    );
end controlpath;

architecture rtl of controlpath is
component Decoder is 
    Port (
    instruction : in	word;
    instr_class : out	instr_class_type;
    operation : out optype;
    DP_subclass : out DP_subclass_type;
    DP_operand_src : out DP_operand_src_type; 
    load_store : out load_store_type;
    DT_offset_sign : out DT_offset_sign_type
);
end component;

component conditionchecker is
    port(
        instr: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        res: out std_logic
    );
end component;
signal instr_class :	instr_class_type;
signal operation : optype;
signal DP_subclass : DP_subclass_type;
signal DP_operand_src : DP_operand_src_type; 
signal load_store : load_store_type;
signal DT_offset_sign : DT_offset_sign_type;
signal state : std_logic_vector(3 downto 0):="0000";
signal as: std_logic_vector(15 downto 0):=X"0000";
signal condsat: std_logic;
signal bs: std_logic_vector(2 downto 0) := "111";
begin
        as<=X"0000";
        bs <="111";
        D: Decoder port map(instruction,instr_class,operation,DP_subclass, DP_operand_src,load_store, DT_offset_sign);
        C: conditionchecker port map(instruction,flags,condsat);
        process(clk) is 
            begin
                if(rising_edge(clk)) then
                    if(reset='1') then
                        state<="0000";
                    else 
                    case state is
                        when "0000" =>
                            state<="0001";
                        when "0001" =>
									if(instr_class =DP) then
                                        if(instruction(4)='0' or (DP_operand_src = imm)) then
                                            state<="1010";
                                        elsif(instruction(7)='1' and instruction(22)='1' and (not (instruction(6 downto 5)="00" and instruction(24)='0'))) then
                                            state<="0100";
                                        elsif(instruction(7)='1' and instruction(22)='0' and (not (instruction(6 downto 5)="00" and instruction(24)='0'))) then
                                            state<="1011";
                                        else
                                            state<="1001";
                                        end if;
									elsif(instr_class =DT) then
                                        if(DP_operand_src= reg) then
										state<="0100";
                                        elsif(instruction(4)= '0') then
                                         state<= "1011";
                                        else 
                                            state<="1000" ;
                        
                                         end if;
									elsif(instr_class =BRN) then
										state<="1000";
                                    elsif(instr_class= SWI) then
                                        state<="1000";
									else 
										state<="1111";
									end if;
                        when "0010"=>
                            state <= "0011";
                        when "0011"=>
                            state <= "0000";
                        when "0100"=>
									if(load_store = load) then
								 state <= "0110";
                            else 
									 state <= "0101";
									 end if;
                        when "0101"=>
                            state <= "0000";
                        when "0110"=>
                            state <= "0111";
                        when "0111"=>
                            state <= "0000";
                        when "1000"=>
                            if(instr_class= SWI and statusbit='0') then 
                            state<="1000";
                            else 
                            state <= "0000";
                            end if;
                        when "1001"=>
                            if((instruction(6 downto 5)="00" and instruction(24)='0' and instruction(4)='1' and instruction(7)='1')) then 
                                state <= "1101";
                            else 
                                state <= "1010";
                            end if;
                        when "1010"=>
                            state <= "0010";
                        when "1011"=>
                            state <= "1100";
                        when "1100"=>
                            state <= "0100";
                        when "1101"=>
                            state<="1110";
                        when "1110"=>
                            if(instruction(23)='1') then 
                            state <= "0011";
                            else 
                            state <= "0000";
                        end if;
                        when others=>
                            state<="1111";
                    end case;
                end if;
                end if;
        end process;
	process(state,as,bs,DP_subclass,condsat,DP_operand_src,DT_offset_sign,instruction,instr_class,reset,statusbit) is
		begin
    if(reset='1') then 
        (RW,CW,DRW,Fset,Asrc1,MLARESW,lorD,DW,AW,BW,ReW)<=as(10 downto 0);
        MWset<="0000";
        Asrc2<="00";
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="11";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
        PW<='1';
        SS<="00";
        M2R<="00";
        RdLoW<='0';
        Rsrc1<='0';
		  SD<='0';
        Rsrc<="00";
        IW<='0';
        op<="0100";
    elsif (state ="0000") then
        (RW,CW,DRW,Fset,Asrc1,MLARESW,lorD,DW,AW,BW,ReW)<=as(10 downto 0);
        MWset<="0000";
        Asrc2<="01";
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
        PW<='1';
        SS<="00";
        M2R<="00";
        RdLoW<='0';
        Rsrc1<='0';
        Rsrc<="00";
        IW<='1';
        op<="0100";
        SD <='0';
    elsif(condsat ='0') then
        (Asrc1,Fset,ReW,RW,PW,AW,BW,MLARESW,lorD,DW,IW,DRW,CW)<=as(12 downto 0);
        MWset<="0000";
        op<="0000";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        Asrc2<="00";
        SD <='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="0001") then 
        (PW,Fset,Asrc1,MLARESW,lorD,DW,IW,ReW,DRW,CW,RW)<=as(10 downto 0);
        Asrc2<="00";
        SS<="00";
        MWset<="0000";
        (AW,BW)<=bs(1 downto 0);
        op<="0000";
		if(instr_class = DP and (not (DP_operand_src= reg and instruction(7)='1' and instruction(4)='1') or (instruction(6 downto 5)="00" and instruction(24)='0'))) then
        Rsrc <= "00";
        elsif(instr_class= DT and instruction(4)='1') then
            Rsrc<="11";
		else 
			Rsrc<="01";
		end if;
         SD <='0';

        lorD2 <='0';
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="0010") then 
        (RW,PW,AW,BW,MLARESW,lorD,DW,IW,DRW,CW)<=as(9 downto 0);
        MWset<="0000";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        (Asrc1,Fset,Rew)<=bs;
        op<=instruction(24 downto 21);
		--   if(DP_operand_src = reg) then
        Asrc2 <= "00";
        SD <='0';
		--   else 
		-- 	Asrc2<="10";
		--   end if;
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="0011") then 
        (Asrc1,Fset,Rew,PW,AW,BW,MLARESW,lorD,DW,IW,CW,DRW)<=as(11 downto 0);
        MWset<="0000";
        op<="0000";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        Rsrc1<='0';
        Asrc2<="00";
        if((DP_subclass= arith or DP_subclass= logic)) then
        RW<='1';
        else
        RW<='0';
        end if;
        SD <='0';
        lorD2 <='0';
        if( DP_operand_src= reg and instruction(7)='1' and instruction(4)='1'and instruction(6 downto 5)="00" and instruction(24)='0') then
            M2R<="10";
        else 
            M2R<="00";
        end if;
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif (state ="0100") then 
        (Fset,PW,AW,BW,MLARESW,lorD,DW,RW,IW,DRW,CW)<=as(10 downto 0);
        Rew<='1';
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        MWset<="0000";
		  if(DT_offset_sign = plus) then
        op<="0100";
		  else 
			op<="0010";
		  end if;
        Asrc1<='1';
        if((DP_operand_src=reg and instr_class = DT) or (instr_class =DP and instruction(22)= '1')) then
        Asrc2<="10";   
        else
            Asrc2<="00";
        end if;
        SS<="00";
        SD <='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="0101") then 
        (Asrc1,Fset,Rew,PW,AW,BW,MLARESW,DW,IW,DRW,CW)<=as(10 downto 0);
        lorD<='1';
        MWset<="1111";
        if(instruction(24)='1') then
        lorD2<= '0';
        else lorD2<= '1';
        end if;
        RW<= instruction(21) or (not instruction(24));
        op<="0000";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        Asrc2<="00";
        SD <='0';
        wrselect<='1';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state="0110") then 
        (Asrc1,Fset,Rew,PW,AW,BW,MLARESW,IW,DRW,CW)<=as(9 downto 0);
        lorD<='1';
        MWset<="0000";
        RW<= instruction(21) or (not instruction(24));
        op<="0000";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        Asrc2<="00";
        SD <='0';
        DW<='1';  
        if(instruction(24)='1') then
        lorD2<= '0';
        else lorD2<= '1';
        end if;
        wrselect<='1';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="0111") then 
        (Asrc1,Fset,Rew,PW,AW,BW,lorD,DW,IW,DRW,CW)<=as(10 downto 0);
        MWset<="0000";
        op<="0000";
        M2R<="01";
        MLARESW<='0';
        Asrc2<="00";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        Rsrc1<='0';
        RW<='1';
        SD <='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="1000") then 
        (Asrc1,Fset,Rew,AW,BW,MLARESW,lorD,DW,IW,DRW,CW)<=as(10 downto 0);
        if(instr_class = DT and instruction(4)='1') then
            retOrBranchS<="01";
            MWset<="0000";
            routOrInputS<='0';
        elsif(instr_class=SWI) then
            retOrBranchS<="10";
            routOrInputS<='1';
            MWset<="1111";
        else
            retOrBranchS<="00";
            MWset<="0000";
            routOrInputS<='0';
        end if;
        if((instruction(24)='1' and instr_class=BRN )or(instr_class = SWI)) then
            r14OrIns15_12S<='1';
            RESOrSaveAdrS<="01";
            RW<='1';
        else 
            r14OrIns15_12S<='0';
            RESOrSaveAdrS<="00";
            RW<='0';
        end if;
        op<="0101";
        Asrc2<="11";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        SS<="00";
        SD <='0';
        if(instr_class= SWI and statusbit='0') then
        PW<='0';
        else 
        PW<='1';
        end if;
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';

    elsif(state ="1001") then 
        (Asrc1,Fset,Rew,RW,AW,BW,MLARESW,lorD,DW,IW,DRW,PW)<=as(11 downto 0);
        MWset<="0000";
        op<="0000";
        Asrc2<="00";
        CW<='1';
        SS<="00";
        Rsrc<="10";
        RdLoW<='1';
        M2R<="00";
        Rsrc1<='1';
        SD <='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="1010") then 
        (Asrc1,Fset,Rew,RW,AW,BW,MLARESW,lorD,DW,IW,PW,CW) <= as(11 downto 0);
        MWset<="0000";
        op<="0000";
        Asrc2<="00";
        DRW<='1';
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        if(DP_operand_src= reg) then
            SS<= (1=>'0',0=> not(instruction(4)));
            SD <='0';
        else
            SS<="10";
            SD <='1';
        end if;
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='1';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="1011") then 
        (Asrc1,Fset,Rew,RW,AW,BW,MLARESW,lorD,DW,IW,DRW,PW)<=as(11 downto 0);
        
        MWset<="0000";
        op<="0000";
        Asrc2<="00";
        CW<='1';
        SS<="00";
        SD <='0';
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="1100") then 
        (Fset,Rew,RW,AW,BW,MLARESW,lorD,DW,IW,PW,CW) <= as(10 downto 0);
        Asrc1<='1';
        MWset<="0000";
        op<="0000";
        Asrc2<="00";
        DRW<='1';
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        SS<= "11";
        SD <='0';
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='1';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state ="1101") then
        (Asrc1,Rew,RW,PW,AW,BW,lorD,DW,IW,CW,DRW)<=as(10 downto 0);
        Fset<='1';
        MWset<="0000";
        MLARESW<='1';
        op<="0000";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        SD <='0';
        SS<="00";
        Asrc2<="00";
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    elsif(state="1110") then
        (Asrc1,Fset,Rew,PW,AW,BW,lorD,DW,IW,DRW,CW)<=as(10 downto 0);
        MWset<="0000";
        op<="0000";
        if(instruction(23)='0') then
            M2R<="10";
        else 
            M2R<="11";
        end if;
        MLARESW<='0';
        Asrc2<="00";
        SS<="00";
        Rsrc<="00";
        RdLoW<='0';
        Rsrc1<='0';
        RW<='1';
        SD <='0';
        lorD2 <='0';
        wrselect<='1';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    else
        (Asrc1,Fset,Rew,RW,PW,AW,BW,MLARESW,lorD,DW,IW,CW,DRW)<=as(12 downto 0);
        MWset<="0000";
        op<="0000";
        Rsrc<="00";
        RdLoW<='0';
        M2R<="00";
        Rsrc1<='0';
        SD <='0';
        SS<="00";
        Asrc2<="00";
        lorD2 <='0';
        wrselect<='0';
        shifterCarrySet<='0';
        routOrInputS<='0';
        retOrBranchS<="00";
        r14OrIns15_12S<='0';
        RESOrSaveAdrS<="00";
    end if;   
	end process;
end rtl;