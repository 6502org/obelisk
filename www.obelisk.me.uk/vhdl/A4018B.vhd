-- ============================================================================
-- 4018B Presettable Divide-By-N Counter
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

entity A4018B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp			:	in		std_logic;
		mr			:	in		std_logic;
		d			:	in		std_logic;
		pl			:	in		std_logic;
		p0			:	in		std_logic;
		p1			:	in		std_logic;
		p2			:	in		std_logic;
		p3			:	in		std_logic;
		p4			:	in		std_logic;
		o0_n		:	out		std_logic;
		o1_n		:	out		std_logic;
		o2_n		:	out		std_logic;
		o3_n		:	out		std_logic;
		o4_n		: 	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4018B is
	signal	ff1		:	std_logic := 'U';
	signal	ff2		:	std_logic := 'U';
	signal	ff3		:	std_logic := 'U';
	signal	ff4		:	std_logic := 'U';
	signal	ff5		:	std_logic := 'U';
begin
	-- Handle async. reset, load and clock pulse
	process (cp, mr, pl)
	begin
		if (to_bit(mr) = '1') then
			ff1 <= '0';
			ff2 <= '0';
			ff3 <= '0';
			ff4 <= '0';
			ff5 <= '0';
		elsif (to_bit(pl) = '1') then
			ff1 <= p0;
			ff2 <= p1;
			ff3 <= p2;
			ff4 <= p3;
			ff5 <= p4;
		elsif rising_edge(cp) then
			ff1 <= d;
			ff2 <= ff1;
			ff3 <= (ff1 or ff3) and ff2;
			ff4 <= ff3;
			ff5 <= ff4;
		end if;
	end process;

	-- Invert flip-flop states and output with added delay
	o0_n <= '1' after tplh when to_bit(ff1) = '0' else
	        '0' after tphl;

	o1_n <= '1' after tplh when to_bit(ff2) = '0' else
		    '0' after tphl;

	o2_n <= '1' after tplh when to_bit(ff3) = '0' else
		    '0' after tphl;

	o3_n <= '1' after tplh when to_bit(ff4) = '0' else
		    '0' after tphl;

	o4_n <= '1' after tplh when to_bit(ff5) = '0' else
		    '0' after tphl;
end architecture;