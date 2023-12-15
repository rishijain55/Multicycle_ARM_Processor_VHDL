library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter1 is
  port(
        datain1 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select1 : in std_logic;
        cin1 : in std_logic;
        dataout1 : out std_logic_vector(31 downto 0);
        cout1 : out std_logic
    );
end rshifter1;

architecture rtl of rshifter1 is
begin
    process(datain1,shtype,cin1,select1) is
        begin
            if(select1 = '1') then 
                if(shtype ="01") then
                    dataout1(30 downto 0)<= datain1(31 downto 1);
                    dataout1(31 downto 31)<=(others=>'0');
                    cout1<= datain1(0);
                elsif(shtype= "10") then
                    dataout1(30 downto 0)<= datain1(31 downto 1);
                    dataout1(31 downto 31)<= std_logic_vector(resize(unsigned(datain1(31 downto 31)),1));
                    cout1<= datain1(0);
                else
                    dataout1(30 downto 0)<= datain1(31 downto 1);
                    dataout1(31 downto 31)<= datain1(0 downto 0);
                    cout1<= datain1(0);
                end if;
            else 
                dataout1<= datain1;
                cout1<= cin1;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter2 is
  port(
        datain2 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select2 : in std_logic;
        cin2 : in std_logic;
        dataout2 : out std_logic_vector(31 downto 0);
        cout2 : out std_logic
    );
end rshifter2;

architecture rtl of rshifter2 is
begin
    process(datain2,shtype,cin2,select2) is
        begin
            if(select2 = '1') then 
                if(shtype ="01") then
                    dataout2(29 downto 0)<= datain2(31 downto 2);
                    dataout2(31 downto 30)<=(others=>'0');
                    cout2<= datain2(1);
                elsif(shtype= "10") then
                    dataout2(29 downto 0)<= datain2(31 downto 2);
                    dataout2(31 downto 30)<= std_logic_vector(resize(unsigned(datain2(31 downto 31)),2));
                    cout2<= datain2(1);
                else
                    dataout2(29 downto 0)<= datain2(31 downto 2);
                    dataout2(31 downto 30)<= datain2(1 downto 0);
                    cout2<= datain2(1);
                end if;
            else 
                dataout2<= datain2;
                cout2<= cin2;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter4 is
  port(
        datain4 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select4 : in std_logic;
        cin4 : in std_logic;
        dataout4 : out std_logic_vector(31 downto 0);
        cout4 : out std_logic
    );
end rshifter4;

architecture rtl of rshifter4 is
begin
    process(datain4,shtype,cin4,select4) is
        begin
            if(select4 = '1') then 
                if(shtype ="01") then
                    dataout4(27 downto 0)<= datain4(31 downto 4);
                    dataout4(31 downto 28)<=(others=>'0');
                    cout4<= datain4(3);
                elsif(shtype= "10") then
                    dataout4(27 downto 0)<= datain4(31 downto 4);
                    dataout4(31 downto 28)<= std_logic_vector(resize(unsigned(datain4(31 downto 31)),4));
                    cout4<= datain4(3);
                else
                    dataout4(27 downto 0)<= datain4(31 downto 4);
                    dataout4(31 downto 28)<= datain4(3 downto 0);
                    cout4<= datain4(3);
                end if;
            else 
                dataout4<= datain4;
                cout4<= cin4;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter8 is
  port(
        datain8 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select8 : in std_logic;
        cin8 : in std_logic;
        dataout8 : out std_logic_vector(31 downto 0);
        cout8 : out std_logic
    );
end rshifter8;

architecture rtl of rshifter8 is
begin
    process(datain8,shtype,cin8,select8) is
        begin
            if(select8 = '1') then 
                if(shtype ="01") then
                    dataout8(23 downto 0)<= datain8(31 downto 8);
                    dataout8(31 downto 24)<=(others=>'0');
                    cout8<= datain8(7);
                elsif(shtype= "10") then
                    dataout8(23 downto 0)<= datain8(31 downto 8);
                    dataout8(31 downto 24)<= std_logic_vector(resize(unsigned(datain8(31 downto 31)),8));
                    cout8<= datain8(7);
                else
                    dataout8(23 downto 0)<= datain8(31 downto 8);
                    dataout8(31 downto 24)<= datain8(7 downto 0);
                    cout8<= datain8(7);
                end if;
            else 
                dataout8<= datain8;
                cout8<= cin8;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter16 is
  port(
        datain16 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select16 : in std_logic;
        cin16 : in std_logic;
        dataout16 : out std_logic_vector(31 downto 0);
        cout16 : out std_logic
    );
end rshifter16;

architecture rtl of rshifter16 is
begin
    process(datain16,shtype,cin16,select16) is
        begin
            if(select16 = '1') then 
                if(shtype ="01") then
                    dataout16(15 downto 0)<= datain16(31 downto 16);
                    dataout16(31 downto 16)<=(others=>'0');
                    cout16<= datain16(15);
                elsif(shtype= "10") then
                    dataout16(15 downto 0)<= datain16(31 downto 16);
                    dataout16(31 downto 16)<= std_logic_vector(resize(unsigned(datain16(31 downto 31)),16));
                    cout16<= datain16(15);
                else
                    dataout16(15 downto 0)<= datain16(31 downto 16);
                    dataout16(31 downto 16)<= datain16(15 downto 0);
                    cout16<= datain16(15);
                end if;
            else 
                dataout16<= datain16;
                cout16<= cin16;
            end if;
    end process;
end rtl;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter1 is
  port(
        datain1 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select1 : in std_logic;
        cin1 : in std_logic;
        dataout1 : out std_logic_vector(31 downto 0);
        cout1 : out std_logic
    );
end lshifter1;

architecture rtl of lshifter1 is
begin
    process(datain1,shtype,cin1,select1) is
        begin
            if(select1 = '1') then 
                if(shtype ="00") then
                    dataout1(31 downto 1)<= datain1(30 downto 0);
                    dataout1(0 downto 0)<=(others=>'0');
                    cout1<= datain1(31);
            else 
                dataout1<= datain1;
                cout1<= cin1;
                end if;
            else 
                dataout1<= datain1;
                cout1<= cin1;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter2 is
  port(
        datain2 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select2 : in std_logic;
        cin2 : in std_logic;
        dataout2 : out std_logic_vector(31 downto 0);
        cout2 : out std_logic
    );
end lshifter2;

architecture rtl of lshifter2 is
begin
    process(datain2,shtype,cin2,select2) is
        begin
            if(select2 = '1') then 
                if(shtype ="00") then
                    dataout2(31 downto 2)<= datain2(29 downto 0);
                    dataout2(1 downto 0)<=(others=>'0');
                    cout2<= datain2(30);
            else 
                dataout2<= datain2;
                cout2<= cin2;
                end if;
            else 
                dataout2<= datain2;
                cout2<= cin2;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter4 is
  port(
        datain4 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select4 : in std_logic;
        cin4 : in std_logic;
        dataout4 : out std_logic_vector(31 downto 0);
        cout4 : out std_logic
    );
end lshifter4;

architecture rtl of lshifter4 is
begin
    process(datain4,shtype,cin4,select4) is
        begin
            if(select4 = '1') then 
                if(shtype ="00") then
                    dataout4(31 downto 4)<= datain4(27 downto 0);
                    dataout4(3 downto 0)<=(others=>'0');
                    cout4<= datain4(28);
            else 
                dataout4<= datain4;
                cout4<= cin4;
                end if;
            else 
                dataout4<= datain4;
                cout4<= cin4;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter8 is
  port(
        datain8 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select8 : in std_logic;
        cin8 : in std_logic;
        dataout8 : out std_logic_vector(31 downto 0);
        cout8 : out std_logic
    );
end lshifter8;

architecture rtl of lshifter8 is
begin
    process(datain8,shtype,cin8,select8) is
        begin
            if(select8 = '1') then 
                if(shtype ="00") then
                    dataout8(31 downto 8)<= datain8(23 downto 0);
                    dataout8(7 downto 0)<=(others=>'0');
                    cout8<= datain8(24);
            else 
                dataout8<= datain8;
                cout8<= cin8;
                end if;
            else 
                dataout8<= datain8;
                cout8<= cin8;
            end if;
    end process;
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter16 is
  port(
        datain16 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select16 : in std_logic;
        cin16 : in std_logic;
        dataout16 : out std_logic_vector(31 downto 0);
        cout16 : out std_logic
    );
end lshifter16;

architecture rtl of lshifter16 is
begin
    process(datain16,shtype,cin16,select16) is
        begin
            if(select16 = '1') then 
                if(shtype ="00") then
                    dataout16(31 downto 16)<= datain16(15 downto 0);
                    dataout16(15 downto 0)<=(others=>'0');
                    cout16<= datain16(16);
					else 
						 dataout16<= datain16;
						 cout16<= cin16;
                end if;
            else 
                dataout16<= datain16;
                cout16<= cin16;
            end if;
    end process;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rshifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end rshifter;



architecture rtl of rshifter is
component rshifter1 is
  port(
        datain1 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select1 : in std_logic;
        cin1 : in std_logic;
        dataout1 : out std_logic_vector(31 downto 0);
        cout1 : out std_logic
    );
end component;
component rshifter2 is
  port(
        datain2 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select2 : in std_logic;
        cin2 : in std_logic;
        dataout2 : out std_logic_vector(31 downto 0);
        cout2 : out std_logic
    );
end component;
component rshifter4 is
  port(
        datain4 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select4 : in std_logic;
        cin4 : in std_logic;
        dataout4 : out std_logic_vector(31 downto 0);
        cout4 : out std_logic
    );
end component;
component rshifter8 is
  port(
        datain8 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select8 : in std_logic;
        cin8 : in std_logic;
        dataout8 : out std_logic_vector(31 downto 0);
        cout8 : out std_logic
    );
end component;
component rshifter16 is
  port(
        datain16 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select16 : in std_logic;
        cin16 : in std_logic;
        dataout16 : out std_logic_vector(31 downto 0);
        cout16 : out std_logic
    );
end component;
signal dataout1,dataout2,dataout4,dataout8 : std_logic_vector(31 downto 0);
signal cout1,cout2,cout4,cout8 : std_logic;
begin
    rs1 : rshifter1 port map(datain,shtype,shselect(0),cin,dataout1,cout1);
    rs2 : rshifter2 port map(dataout1,shtype,shselect(1),cout1,dataout2,cout2);
    rs4 : rshifter4 port map(dataout2,shtype,shselect(2),cout2,dataout4,cout4);
    rs8 : rshifter8 port map(dataout4,shtype,shselect(3),cout4,dataout8,cout8);
    rs16 : rshifter16 port map(dataout8,shtype,shselect(4),cout8,dataout,cout);
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lshifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end lshifter;

architecture rtl of lshifter is
component lshifter1 is
  port(
        datain1 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select1 : in std_logic;
        cin1 : in std_logic;
        dataout1 : out std_logic_vector(31 downto 0);
        cout1 : out std_logic
    );
end component;
component lshifter2 is
  port(
        datain2 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select2 : in std_logic;
        cin2 : in std_logic;
        dataout2 : out std_logic_vector(31 downto 0);
        cout2 : out std_logic
    );
end component;
component lshifter4 is
  port(
        datain4 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select4 : in std_logic;
        cin4 : in std_logic;
        dataout4 : out std_logic_vector(31 downto 0);
        cout4 : out std_logic
    );
end component;
component lshifter8 is
  port(
        datain8 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select8 : in std_logic;
        cin8 : in std_logic;
        dataout8 : out std_logic_vector(31 downto 0);
        cout8 : out std_logic
    );
end component;
component lshifter16 is
  port(
        datain16 : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        select16 : in std_logic;
        cin16 : in std_logic;
        dataout16 : out std_logic_vector(31 downto 0);
        cout16 : out std_logic
    );
end component;
signal dataout1,dataout2,dataout4,dataout8 : std_logic_vector(31 downto 0);
signal cout1,cout2,cout4,cout8 : std_logic;
begin
    ls1 : lshifter1 port map(datain,shtype,shselect(0),cin,dataout1,cout1);
    ls2 : lshifter2 port map(dataout1,shtype,shselect(1),cout1,dataout2,cout2);
    ls4 : lshifter4 port map(dataout2,shtype,shselect(2),cout2,dataout4,cout4);
    ls8 : lshifter8 port map(dataout4,shtype,shselect(3),cout4,dataout8,cout8);
    ls16 : lshifter16 port map(dataout8,shtype,shselect(4),cout8,dataout,cout);
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end shifter;

architecture rtl of shifter is

component lshifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end component;

component rshifter is
  port(
        datain : in std_logic_vector(31 downto 0);
        shtype : in std_logic_vector(1 downto 0);
        shselect : in std_logic_vector(4 downto 0);
        cin : in std_logic;
        dataout : out std_logic_vector(31 downto 0);
        cout : out std_logic
    );
end component;
signal dataoutl : std_logic_vector(31 downto 0);
signal coutl : std_logic;
begin 
 LS : lshifter port map(datain,shtype,shselect,cin,dataoutl,coutl);
 RS : rshifter port map(dataoutl,shtype,shselect,coutl,dataout,cout);
end rtl;