library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cnt4b is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Cnt : out STD_LOGIC_VECTOR (3 downto 0);
           EC : out STD_LOGIC);
end ;

architecture Behavioral of Cnt4b is
--signal Decad : STD_LOGIC_VECTOR (7 downto 0);

begin
 
DcadCnt : process (clk, reset)
 variable Decad : STD_LOGIC_VECTOR (3 downto 0);
 begin
    if reset = '0' then
        Decad := "0000";
    elsif rising_edge (clk) then
       if CE = '1' then
            Decad <= Decad + 1;
	    if Decad(3 downto 0)= "1001" then -- Decad = 9
                Decad(3 downto 0) := "0000";
            end if; -- Decad
         end if; -- CE        
    end if; -- reset
    
    -- Combinatorial part --
    Cnt <= Decad;
    if Decad(3 downto 0) = "1001" then
      EC <= '1';
    else
      EC <= '0';
    end if; -- Decad    
 end process DcadCnt;
end Behavioral;

