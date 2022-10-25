-- ============================================================================
-- 74XX04 Hex Inverter (Test Bench)
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

entity A74XX04_TestBench is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A74XX04_TestBench is
	component A74XX04 is
		generic	(
			tplh		:	time	:= 0 ns;
			tphl		:	time	:= 0 ns);
		port (
			i1			:	in		std_logic;
			i2			:	in		std_logic;
			i3			:	in		std_logic;
			i4			:	in		std_logic;
			i5			:	in		std_logic;
			i6			:	in		std_logic;
			o1			:	out		std_logic;
			o2			:	out		std_logic;
			o3			:	out		std_logic;
			o4			:	out		std_logic;
			o5			:	out		std_logic;
			o6			:	out		std_logic);
	end component;
	
	signal	i		: std_logic_vector (1 to 6);
	signal	o		: std_logic_vector (1 to 6);
begin
	i <=	"UUUUUU",

			"000000" after  10 ns,
			"100000" after  20 ns,
			"010000" after  30 ns,
			"001000" after  40 ns,
			"000100" after  50 ns,
			"000010" after  60 ns,
			"000001" after  70 ns,
			
			"LLLLLL" after  80 ns,
			"HLLLLL" after  90 ns,
			"LHLLLL" after 100 ns,
			"LLHLLL" after 110 ns,
			"LLLHLL" after 120 ns,
			"LLLLHL" after 130 ns,
			"LLLLLH" after 140 ns;

	gate: A74XX04
		generic map (
			tphl => 5 ns, tplh => 7 ns)
		port map (
			i(1), i(2), i(3), i(4), i(5), i(6),
			o(1), o(2), o(3), o(4), o(5), o(6));			
end	architecture;