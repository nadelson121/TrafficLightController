library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;
entity state_machine is
	Port ( clock, reset, sensor, LTS, pedestrian, long, short : in std_logic;
			HL1, HL0, FL1, FL0, FLL, clear, countdown : out std_logic	);

end state_machine;

architecture Behavioral of state_machine is
	type state_type is ( hwygreen0, hwygreen1, hwyyellow0, hwyyellow1, hwyred0, hwyred1,
farmgreen0, farmgreen1, farmyellow0, farmyellow1, farmred0, farmred1, leftturn0, leftturn1 );
	attribute enum_encoding: string;
	attribute enum_encoding of state_type: type is "000000000001 000000000010 000000000100 000000001000 0000010000 000000100000 000001000000 000010000000 000100000000 001000000000 010000000000 100000000000";
	signal CS, NS: state_type;

begin
	process (clock, reset)
	begin
		if (reset='1') then
			CS <= hwygreen0;
		elsif rising_edge(clock) then
			CS <= NS;
		end if;
end process;

process (CS, reset, sensor, LTS, pedestrian, long, short)
begin
	case CS is
		when hwygreen0 =>
			HL1 <= '0'; HL0 <= '0';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '1';
			countdown <= '1';
		if (reset='0' and (LTS='1' or sensor='1' or pedestrian='1') ) then
			NS <= hwygreen1;
		else
			NS <= hwygreen0;
		end if;
		when hwygreen1 =>
			HL1 <= '0'; HL0 <= '0';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '0';
			countdown <= '1';
		if (reset='0' and ((LTS='1' or sensor='1' or pedestrian='1') and long='1') ) then
			NS <= hwyyellow0;
		else
			NS <= hwygreen1;
		end if;
		when hwyyellow0 =>
			HL1 <= '0'; HL0 <= '0';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '1';
			countdown <= '1';
		if (reset='0' and (LTS='1' or sensor='1' or pedestrian='1')) then
			NS <= hwyyellow1;
		else
			NS <= hwygreen0;
		end if;
		when hwyyellow1 =>
			HL1 <= '1'; HL0 <= '0';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '0';
			countdown <= '1';
		if (reset='0' and short='1') then
			NS <= hwyred0;
		else
			NS <= hwyyellow1;
		end if;
		when hwyred0 =>
			HL1 <= '1'; HL0 <= '0';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '1';
			countdown <= '1';
		if (reset='0') then
			NS <= hwyred1;
		else
			NS <= hwygreen0;
		end if;
		when hwyred1 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '0';
			countdown <= '0';
		if (reset='0' and short='1') then
			if (LTS='1' or sensor='1' or pedestrian='1') then
				NS <= farmgreen0;
			else if (LTS='1') then
				NS <= leftturn0;
			else
				NS <= hwygreen0;
			end if;
			end if;
		else
			NS <= hwyred1;
		end if;
		when farmgreen0 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '0'; FLL <= '0';
			clear <= '1';
			countdown <= '1';
		if (reset='0') then
			NS <= farmgreen1;
		else
			NS <= hwygreen0;
		end if;
		when farmgreen1 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '0'; FLL <= '0';
			clear <= '0';
			countdown <= '0';
		if (reset='0' and ( sensor='0' or long='1' ) ) then
			NS <= farmyellow0;
		else
			NS <= farmgreen1;
		end if;
		when farmyellow0 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '0'; FLL <= '0';
			clear <= '1';
			countdown <= '0';
		if (reset='0') then
			NS <= farmyellow1;
		else
			NS <= hwygreen0;
		end if;
		when farmyellow1 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '1'; FL0 <= '0'; FLL <= '0';
			clear <= '0';
			countdown <= '0';
		if (reset='0' and short='1') then
			NS <= farmred0;
		else
			NS <= farmyellow1;
		end if;
		when farmred0 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '1'; FL0 <= '0'; FLL <= '0';
			clear <= '1';
			countdown <= '1';
		if (reset='0') then
			NS <= farmred1;
		else
			NS <= hwygreen0;
		end if;
		when farmred1 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '0';
			countdown <= '0';
		if (reset='0' and short='1') then
			if (LTS='1') then
				NS <= leftturn0;
			else
				NS <= hwygreen0;
				end if;
		else
			NS <= farmred1;
		end if;
		when leftturn0 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '1'; FLL <= '0';
			clear <= '0';
			countdown <= '0';
		if (reset='0') then
			NS <= leftturn1;
		else
			NS <= hwygreen0;
		end if;
		when leftturn1 =>
			HL1 <= '0'; HL0 <= '1';
			FL1 <= '0'; FL0 <= '1'; FLL <= '1';
			clear <= '0';
			countdown <= '0';
		if ( reset='0' and ( LTS='0' or long='1' ) ) then
			NS <= hwygreen0;
		else
			NS <= leftturn1;
		end if;
	end case;
end process;
end Behavioral;