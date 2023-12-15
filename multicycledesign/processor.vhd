library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MyTypes.all;
use IEEE.NUMERIC_STD.ALL;

entity processor is 
    port(clk,reset: in std_logic;
        datain: in std_logic_vector(8 downto 0)
    );
end  processor;

architecture rtl of processor is
component datapath is
    port(
        PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,SD,DRW,CW,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,reset,shifterCarrySet,clk : in std_logic;
        Rsrc,Asrc2,SS,M2R,RESorSaveAdrS,retOrBranchS: in std_logic_vector(1 downto 0);
        input: in std_logic_vector(7 downto 0);
        MWset,op: in std_logic_vector(3 downto 0);
        instruct: out std_logic_vector(31 downto 0);
        flag: out std_logic_vector(3 downto 0):="0000"
    );
end component;
 component controlpath is
    port(
        instruction: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        statusbit,reset,clk: in std_logic;
        PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,CW,DRW,SD,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,shifterCarrySet: out std_logic;
        Asrc2,Rsrc,SS,M2R,RESOrSaveAdrS,retOrBranchS: out std_logic_vector(1 downto 0);
        MWset,op:out  std_logic_vector(3 downto 0)
    );
end component;
signal        PW,RW,Asrc1,Fset,MLARESW,Rsrc1,RdLoW,lorD,DW,IW,AW,BW,ReW,SD,CW,DRW,lorD2,wrselect,r14OrIns15_12S,routOrInputS,shifterCarrySet:  std_logic;
signal          Asrc2,Rsrc,SS,M2R,RESorSaveAdrS,retOrBranchS:  std_logic_vector(1 downto 0);
signal        MWset,op:  std_logic_vector(3 downto 0);
signal         instruction:  std_logic_vector(31 downto 0):=X"00000000";
signal         flags:  std_logic_vector(3 downto 0):="0000";
begin
CP:    controlpath port map(instruction,flags,datain(8),reset,clk,PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,CW,DRW,SD,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,shifterCarrySet,Asrc2,Rsrc,SS,M2R,RESOrSaveAdrS,retOrBranchS,MWset,op);
DP : datapath port map(PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,SD,DRW,CW,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,reset,shifterCarrySet,clk,Rsrc,Asrc2,SS,M2R,RESorSaveAdrS,retOrBranchS,datain(7 downto 0),MWset,op,instruction,flags);
end rtl;