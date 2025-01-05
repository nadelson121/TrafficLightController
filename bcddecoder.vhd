library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcddecoder is
    Port ( d : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (6 downto 0) );
end bcddecoder;

architecture Behavioral of bcddecoder is

begin
	s <= "0000001" when d="0000" else
		"1001111" when d="0001" else
		"0010010" when d="0010" else
		"0000110" when d="0011" else
		"1001100" when d="0100" else
		"0100100" when d="0101" else
		"0100000" when d="0110" else
		"0001111" when d="0111" else
		"0000000" when d="1000" else
		"0000100" when d="1001" else
		"0001000" when d="1010" else
		"1100000" when d="1011" else
		"1110010" when d="1100" else
		"1000010" when d="1101" else
		"0010000" when d="1110" else
		"0111000";

end Behavioral;

