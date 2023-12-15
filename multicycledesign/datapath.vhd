library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MyTypes.all;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port(
        PW,RW,Asrc1,Fset,lorD,DW,IW,AW,BW,ReW,SD,DRW,CW,lorD2,wrselect,Rsrc1,RdLoW,MLARESW,r14OrIns15_12S,routOrInputS,reset,shifterCarrySet,clk : in std_logic;
        Rsrc,Asrc2,SS,M2R,RESorSaveAdrS,retOrBranchS: in std_logic_vector(1 downto 0);
        input: in std_logic_vector(7 downto 0);
        MWset,op: in std_logic_vector(3 downto 0);
        instruct: out std_logic_vector(31 downto 0);
        flag: out std_logic_vector(3 downto 0):="0000"
    );
end datapath;

architecture rtl of datapath is
component conditionchecker is
    port(
        instr: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        res: out std_logic
    );
end component;

component ALU is
    port (opcode : in std_logic_vector(3 downto 0);
        a,b  : in std_logic_vector(31 downto 0);
        cin: in STD_LOGIC;
        result: out std_logic_vector(31 downto 0);
        cout: out STD_LOGIC);
end component;

component dataMem is
  port(
    dataout  : out std_logic_vector(31 downto 0);
    datainput       : in  std_logic_vector(31 downto 0);
    we1,we2,we3,we4 : in  std_logic;
    readadd    : in  std_logic_vector(6 downto 0);
    modeflag : in std_logic;
    clk    : in  std_logic
    );
end component;


component programcounter is
    port(
        inputcount: in std_logic_vector(31 downto 0);
      PW,clk : in std_logic;
      outputcount : out std_logic_vector(31 downto 0)
    );
end component;

component flagcircuit is
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
end component;

component registerFile is
  port(
    dataout1,dataout2  : out std_logic_vector(31 downto 0);
    datainput       : in  std_logic_vector(31 downto 0);
    writeEnable : in  std_logic;
    reg1Sel,reg2sel,writeadd     : in  std_logic_vector(3 downto 0);
    clk         : in  std_logic
    );
end component;

component shifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end component;

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
component multiply_accumulate is
  port(
        ml1,ml2: in std_logic_vector(31 downto 0);
        acc: in std_logic_vector(63 downto 0);
        instruction: in std_logic_vector(31 downto 0);
        mlout: out std_logic_vector(63 downto 0)
    );
end component;
component PMconnect is
  port(
        Rout,Mout,Instruction : in std_logic_vector(31 downto 0);
        Adr10: in std_logic_vector(1 downto 0);
        MWset: in std_logic_vector(3 downto 0);
        ins_class : in instr_class_type;
        load_store : in load_store_type;
        Rin,Min : out std_logic_vector(31 downto 0);
        MW : out std_logic_vector(3 downto 0)
    );
end component;
signal progmeminputex,rd1,rd2,rd,wd,alui2,alui1,aluout,shin,shou,immoffsetDP,Rin,Min,prepost,RESorSaveAdr,retOrBranch,routOrInput: std_logic_vector(31 downto 0);
signal ad: std_logic_vector(6 downto 0);
signal rr1,rr2,flags,MW,wad,r14OrIns15_12: std_logic_vector(3 downto 0); 
signal stype: std_logic_vector(1 downto 0);
signal cout,cin,sco,SR,modeflag: std_logic;
signal instr_class :	instr_class_type;
signal operation : optype;
signal DP_subclass : DP_subclass_type;
signal DP_operand_src : DP_operand_src_type; 
signal load_store : load_store_type;
signal DT_offset_sign : DT_offset_sign_type;
signal A,B,IR,DR,RES,C,D,RdLo: std_logic_vector(31 downto 0);
signal shselect:std_logic_vector(4 downto 0);
signal MLARES,Acc,MLAout : std_logic_vector(63 downto 0);
begin

	instruct<=IR;
	flag<=flags;
    retOrBranch<= aluout(29 downto 0)&"00" when retOrBranchS="00" else B when retOrBranchS="01" else X"00000008" when retOrBranchS="10" else X"00000000";
    PC :programcounter port map( retOrBranch, PW,clk,progmeminputex);
    prepost<= RES when lord2='0' else A;
    ad <="0000011" when routOrInputS='1' else progmeminputex(8 downto 2) when (lorD ='0' and routOrInputS='0') else prepost(8 downto 2);
    routOrInput<= B when routOrInputS='0' else X"000000"&input;
    PMC: PMconnect port map(routOrInput,rd,IR,prepost(1 downto 0),MWset,instr_class,load_store,Rin,Min,MW);
    DM : dataMem port map(rd,Min,MW(0),MW(1),MW(2),MW(3),ad,modeflag,clk);
    IR<= rd when IW ='1' else IR;
    DR<= Rin when DW ='1' else DR;
    rr2<= IR(3 downto 0) when Rsrc ="00" else IR(15 downto 12) when Rsrc="01" else IR(11 downto 8) when Rsrc="10" else "1110";
    RESorSaveAdr<= RES when RESorSaveAdrS ="00" else progmeminputex when RESorSaveAdrS ="01" else X"00000000";
    wd <= RESorSaveAdr when M2R= "00" else DR when M2R= "01" else MLARES(31 downto 0) when M2R="10" else MLARES(63 downto 32);
    r14OrIns15_12<= "1110" when r14OrIns15_12S = '1' else IR(15 downto 12);
    wad<= r14OrIns15_12 when wrselect='0' else IR(19 downto 16);
    rr1<= IR(19 downto 16) when Rsrc1='0' else IR(15 downto 12);
    RDr: RegisterFile port map(rd1,rd2,wd,RW,rr1,rr2,wad,clk);
    Acc <= A&RdLo;
    MLA: multiply_accumulate port map(B,C,Acc,IR,MLAout);
    MLARES<= MLAout when MLARESW ='0' else MLARES;
    A<= rd1 when AW ='1' else A;
    B<= rd2 when BW ='1' else B;
    RdLo<= rd1 when RdLoW ='1' else RdLo;
    C<= rd2 when CW ='1' else C;
    shin<= C when (SS="11") else  B when SD ='0' else X"000000"&IR(7 downto 0) ;
    shselect <= C(4 downto 0) when SS="00"  else IR(11 downto 8)&"0" when SS= "10" else "00000" when (instr_class= DP and DP_operand_src= reg and IR(4)='1' and IR(7)='1') else IR(11 downto 7) ;
    stype <= "11" when (DP_operand_src= imm and instr_class= DP) else IR(6 downto 5);
    SH :shifter port map(shin,stype,shselect,flags(2),shou,sco);
    D<= shou when DRW ='1' else D;
    SR<= sco when DRW='1' else SR;
    alui1 <= A when Asrc1 ='1' else "00"&progmeminputex(31 downto 2) ;
    immoffsetDP <=  X"000000"&IR(11 downto 8)&IR(3 downto 0)when instr_class = DP else X"00000"&IR(11 downto 0);
    alui2<= D when Asrc2 ="00" else X"00000001" when Asrc2="01" else  immoffsetDP when Asrc2= "10" else std_logic_vector(resize(signed(IR(23 downto 0)),32));
    cin<='1' when Asrc2 ="11" else flags(2);
    AL: ALU port map(op,alui1 ,alui2,cin,aluout,cout);
    RES<=aluout when ReW ='1' else RES;
    Dec: Decoder port map(IR,instr_class,operation,DP_subclass, DP_operand_src,load_store, DT_offset_sign);
    FC : flagcircuit port map(instr_class,DP_subclass,operation,Fset,shifterCarrySet,load_store,cout,sco,alui1(31),alui2(31),clk,aluout,MLAout,IR,reset,flags,modeflag);

end rtl;