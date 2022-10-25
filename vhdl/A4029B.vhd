-- ============================================================================
-- 4029B Synchronous Up/Down Counter, Binary/Decade Counter
--
-- Copyright (C),2005 Andrew John Jacobs.
--
-- This program is provided free of charge for educational purposes
--
-- Redistribution and use in binary form without modification, is permitted
-- provided that the above copyright notice, this list of conditions and the
-- following disclaimer in the documentation and/or other materials provided
-- with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
-- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
-- THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

entity A4029B is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp			:	in		std_logic;
		pl			:	in		std_logic;
		ce_n		:	in		std_logic;
		bin			:	in		std_logic;
		up			:	in		std_logic;
		i0			:	in		std_logic;
		i1			:	in		std_logic;
		i2			:	in		std_logic;
		i3			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic;
		tc_n		:	out		std_logic);
end	entity;

-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of A4029B is
	signal	clk		: std_logic := 'U';
	signal	dn		: std_logic := 'U';
	signal	dec		: std_logic := 'U';
	signal	is_0	: std_logic := 'U';
	signal	is_9	: std_logic := 'U';
	signal	is_f	: std_logic := 'U';
	signal	data	: std_logic_vector (3 downto 0) := "UUUU";
begin
	dn  <= not up;

	dec <= not bin;

	-- Combine inputs that trigger change
	clk <= cp and (not pl) and (not ce_n);

	-- Handle asynchronous parallel load
	process (pl)
	begin
		if rising_edge(pl) then
			data(0) <= not (not i0);
			data(1) <= not (not i1);
			data(2) <= not (not i2);
			data(3) <= not (not i3);
		end if;
	end process;

	-- Process clock pulses
	process (clk)
	begin
		if rising_edge(clk) then
			if to_bit(up) = '1' then
				if to_bit(bin) = '1' then
					-- Binary Increment
					case data is
					when "0000" => 	data <= "0001";
					when "0001" => 	data <= "0010";
					when "0010" => 	data <= "0011";
					when "0011" => 	data <= "0100";
					when "0100" => 	data <= "0101";
					when "0101" => 	data <= "0110";
					when "0110" => 	data <= "0111";
					when "0111" => 	data <= "1000";
					when "1000" => 	data <= "1001";
					when "1001" => 	data <= "1010";
					when "1010" => 	data <= "1011";
					when "1011" => 	data <= "1100";
					when "1100" => 	data <= "1101";
					when "1101" => 	data <= "1110";
					when "1110" => 	data <= "1111";
					when others =>	data <= "0000";
					end case;
				else
					-- Decade Increment
					case data is
					when "0000" => 	data <= "0001";
					when "0001" => 	data <= "0010";
					when "0010" => 	data <= "0011";
					when "0011" => 	data <= "0100";
					when "0100" => 	data <= "0101";
					when "0101" => 	data <= "0110";
					when "0110" => 	data <= "0111";
					when "0111" => 	data <= "1000";
					when "1000" => 	data <= "1001";
					when "1001" => 	data <= "0000";
					when "1010" => 	data <= "1011";
					when "1011" => 	data <= "0110";
					when "1100" => 	data <= "1101";
					when "1101" => 	data <= "0100";
					when "1110" => 	data <= "1111";
					when others =>	data <= "0010";
					end case;
				end if;
			else
				if to_bit(bin) = '1' then
					-- Binary Decrement
					case data is
					when "0000" => 	data <= "1111";
					when "0001" => 	data <= "0000";
					when "0010" => 	data <= "0001";
					when "0011" => 	data <= "0010";
					when "0100" => 	data <= "0011";
					when "0101" => 	data <= "0100";
					when "0110" => 	data <= "0101";
					when "0111" => 	data <= "0110";
					when "1000" => 	data <= "0111";
					when "1001" => 	data <= "1000";
					when "1010" => 	data <= "1001";
					when "1011" => 	data <= "1010";
					when "1100" => 	data <= "1011";
					when "1101" => 	data <= "1100";
					when "1110" => 	data <= "1101";
					when others =>	data <= "1110";
					end case;
				else
					-- Decade Decrement
					case data is
					when "0000" => 	data <= "1001";
					when "0001" => 	data <= "0000";
					when "0010" => 	data <= "0001";
					when "0011" => 	data <= "0010";
					when "0100" => 	data <= "0011";
					when "0101" => 	data <= "0100";
					when "0110" => 	data <= "0101";
					when "0111" => 	data <= "0110";
					when "1000" => 	data <= "0111";
					when "1001" => 	data <= "1000";
					when "1010" => 	data <= "1001";
					when "1011" => 	data <= "1010";
					when "1100" => 	data <= "1011";
					when "1101" => 	data <= "1100";
					when "1110" => 	data <= "1101";
					when others =>	data <= "1110";
					end case;
				end if;
			end if;
		end if;
	end process;

	-- Copy internal state to outputs adding delays
	o0	<= '1' after tplh when to_bit(data(0)) = '1' else
		   '0' after tphl;

	o1	<= '1' after tplh when to_bit(data(1)) = '1' else
		   '0' after tphl;

	o2	<= '1' after tplh when to_bit(data(2)) = '1' else
		   '0' after tphl;

	o3	<= '1' after tplh when to_bit(data(3)) = '1' else
		   '0' after tphl;

	-- Set the terminal count output		   
	is_0 <= not data(0) and not data(1) and not data(2) and not data(3);

	is_9 <= data(0) and data(3);

	is_f <= data(0) and data(1) and data(2) and data(3);

	tc_n <= '0' after tphl when	(not ce_n and (
				(dn and is_0) or
				(bin and up and is_f) or
				(dec and up and is_9))) = '1' else				
			'1' after tplh;
end architecture;