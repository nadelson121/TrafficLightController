library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pedestrian is
    Port ( clock : in  STD_LOGIC;
			  clear : in STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (3 downto 0));
end pedestrian;

architecture Behavioral of counter is
	Signal cnt:STD_LOGIC_VECTOR(3 downto 0);
begin
	process(clock, clear)
		begin
			if clear='1' then
				cnt <= "1001";
			else if (clock'event and clock='0') then
				cnt <= cnt-1;
					end if;
			end if;
	end process;
	count <= cnt;

	end Behavioral;