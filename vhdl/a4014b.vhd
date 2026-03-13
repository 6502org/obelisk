-- ============================================================================
-- 4014B 8-Bit Static Shift Register
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

library	ieee;
use	ieee.std_logic_1164.all;

entity A4014B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp			:	in		std_logic;
		pe			:	in		std_logic;
		ds			:	in		std_logic;
		i0			:	in		std_logic;
		i1			:	in		std_logic;
		i2			:	in		std_logic;
		i3			:	in		std_logic;
		i4			:	in		std_logic;
		i5			:	in		std_logic;
		i6			:	in		std_logic;
		i7			:	in		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic;
		o7			:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library work;

architecture behaviour of A4014B is
	signal state	: std_logic_vector (0 to 7) := "UUUUUUUU";
begin
	process (cp)
	begin
		if rising_edge(cp) then
			if (to_bit(pe) = '1') then
				state <= i0 & i1 & i2 & i3 & i4 & i5 & i6 & i7;
			else
				state <= ds & state (0 to 6);
			end if;
		end if;
	end process;

	-- Copy state to outputs adding propagation delay
	o5 <= '1' after tplh when to_bit(state(5)) = '1' else
		  '0' after tphl;

	o6 <= '1' after tplh when to_bit(state(6)) = '1' else
		  '0' after tphl;

	o7 <= '1' after tplh when to_bit(state(7)) = '1' else
		  '0' after tphl;
end	architecture;