-- ============================================================================
-- 74XX151 8-Input Multiplexer
--
-- Copyright (C),2004 Andrew John Jacobs.
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

entity A74XX151 is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		en_n		:	in		std_logic;
		s0			:	in		std_logic;
		s1			:	in		std_logic;
		s2			:	in		std_logic;
		i0			:	in		std_logic;
		i1			:	in		std_logic;
		i2			:	in		std_logic;
		i3			:	in		std_logic;
		i4			:	in		std_logic;
		i5			:	in		std_logic;
		i6			:	in		std_logic;
		i7			:	in		std_logic;
		o			:	out		std_logic;
		o_n			:	out		std_logic);
end	entity;

-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of A74XX151 is
	signal	value		:	std_logic := 'U';
begin
	-- Process changes to the select or input lines
	process (s0, s1, s2, i0, i1, i2, i3, i4, i5, i6, i7)
		variable	sel		: std_logic_vector (0 to 2);
	begin
		sel := not((not s2) & (not s1) & (not s0));

		case sel is
		when "000" => 	value <= i0;
		when "001" => 	value <= i1;
		when "010" => 	value <= i2;
		when "011" => 	value <= i3;
		when "100" => 	value <= i4;
		when "101" => 	value <= i5;
		when "110" => 	value <= i6;
		when others =>	value <= i7;
		end case;
	end process;

	-- Set the actual outputs (NB. Same timing for both o and o_n)
	o   <= '0' after tphl when ((not en_n) and value) = '0' else
		   '1' after tplh;

	o_n <= '1' after tphl when ((not en_n) and value) = '0' else
		   '0' after tplh;
end architecture;