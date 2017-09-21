-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LAB8 is
  Port ( 
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 15 downto 0 );
    btnU : in STD_LOGIC;
    btnD : in STD_LOGIC;
    btnR : in STD_LOGIC;
    btnL : in STD_LOGIC;
    seg : out STD_LOGIC_VECTOR ( 6 downto 0 );
    dp : out STD_LOGIC;
    an : out STD_LOGIC_VECTOR ( 3 downto 0 );
    led : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end LAB8;

architecture stub of LAB8 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
begin
end;
