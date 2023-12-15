library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU1bit is
    port (opcode : in std_logic_vector(3 downto 0);
        a,b  : in std_logic;
        cin: in STD_LOGIC;
        result: out std_logic;
        cout: out STD_LOGIC);

end entity ALU1bit;

architecture rtl of ALU1bit is
begin

    process (opcode,a,b,cin)
    begin

  case opcode is
    when "0000" =>        
        result <= a and b;
        cout<=cin;
    when "0001" =>
        result <= a xor b;
        cout<=cin;
    when "0010" =>    
        result<= a xor (not b) xor cin;
        cout <= (a and(not b)) or(cin and(a or (not b))); 
    when "0011" =>    
        result<= b xor (not a) xor cin;
        cout <= (b and(not a)) or(cin and(b or (not a))); 
    when "0100" =>    
        result<= a xor  b xor cin;
        cout <= (a and  b) or(cin and(a or b)); 
    when "0101" =>    
        result<= a xor  b xor cin;
        cout <= (a and  b) or(cin and(a or b)); 
    when "0110" =>    
        result<= a xor (not b) xor cin;
        cout <= (a and(not b)) or(cin and(a or (not b))); 
    when "0111" =>    
        result<= b xor (not a) xor cin;
        cout <= (b and(not a)) or(cin and(b or (not a)));     
    when "1000" =>        
        result <= a and b;
        cout<=cin;
    when "1001" =>        
        result <= a xor b;
        cout<=cin;
    when "1010" =>    
        result<= a xor (not b) xor cin;
        cout <= (a and(not b)) or(cin and(a or (not b))); 
    when "1011" =>    
        result<= a xor  b xor cin;
        cout <= (a and  b) or(cin and(a or b));   
    when "1100" =>        
        result <= a or b;
        cout<=cin;
    when "1101"=>
        result<= b;
        cout<=cin;
    when "1110" =>        
        result <= a and (not b);
        cout<=cin;
    when "1111" =>        
        result <= not b;
        cout<=cin;
    when others=>
      null;              
  end case;

end process;
end rtl;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
    port (opcode : in std_logic_vector(3 downto 0);
        a,b  : in std_logic_vector(31 downto 0);
        cin: in STD_LOGIC;
        result: out std_logic_vector(31 downto 0);
        cout: out STD_LOGIC);

end entity ALU;

architecture rtl1 of ALU is
component ALU1bit is
port(opcode : in std_logic_vector(3 downto 0);
    a,b  : in std_logic;
    cin: in STD_LOGIC;
    result: out std_logic;
    cout: out STD_LOGIC);
end component;
signal cary: std_logic_vector(31 downto 0);
begin
process(opcode,cin)
begin
  case opcode is
    when "0100" =>        
        cary(0) <= '0';
    when "1011" =>
        cary(0) <= '0';    
    when "0010" =>        
        cary(0) <= '1';
    when "0011" =>
        cary(0) <= '1';    
    when "1010" =>    
        cary(0) <= '1';
    when others=>
      cary(0)<=cin;              
  end case;
  end process;
C0: ALU1bit port map(opcode,a(0), b(0), cary(0), result(0), cary(1)) ;
C: for i IN 1 to 30 generate
  C1to30: ALU1bit port map (opcode,a(i), b(i), cary(i), result(i), cary(i+1));
end generate;
C31: ALU1bit port map (opcode,a(31), b(31), cary(31), result(31), cout);
end rtl1;
