-- ============================================================================
-- 4012B Dual 4-Input NAND Gates (Test Bench)
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
library	work;

entity A4012B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

architecture behaviour of A4012B_TestBench is
	component A4012B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			a1			:	in		std_logic;
			b1			:	in		std_logic;
			c1			:	in		std_logic;
			d1			:	in		std_logic;
			a2			:	in		std_logic;
			b2			:	in		std_logic;
			c2			:	in		std_logic;
			d2			:	in		std_logic;
			o1			:	out		std_logic;
			o2			:	out		std_logic);
	end	component;

	signal	abcd	: std_logic_vector (1 to 4);
	signal	wxyz	: std_logic_vector (1 to 4);
	signal	o		: std_logic_vector (1 to 2);
begin
	-- Normal test pattern
	abcd <=	"UUUU",

			"0000" after  10 ns,
			"0001" after  20 ns,
			"0010" after  30 ns,
			"0011" after  40 ns,
			"0100" after  50 ns,
			"0101" after  60 ns,
			"0110" after  70 ns,
			"0111" after  80 ns,
			"1000" after  90 ns,
			"1001" after 100 ns,
			"1010" after 110 ns,
			"1011" after 120 ns,
			"1100" after 130 ns,
			"1101" after 140 ns,
			"1110" after 150 ns,
			"1111" after 160 ns,

			"LLLL" after 170 ns,
			"LLLH" after 180 ns,
			"LLHL" after 190 ns,
			"LLHH" after 200 ns,
			"LHLL" after 210 ns,
			"LHLH" after 220 ns,
			"LHHL" after 230 ns,
			"LHHH" after 240 ns,
			"HLLL" after 250 ns,
			"HLLH" after 260 ns,
			"HLHL" after 270 ns,
			"HLHH" after 280 ns,
			"HHLL" after 290 ns,
			"HHLH" after 300 ns,
			"HHHL" after 310 ns,
			"HHHH" after 320 ns;

	-- Inverted	test pattern for
	wxyz <=	"UUUU",

			"1111" after  10 ns,
			"1110" after  20 ns,
			"1101" after  30 ns,
			"1100" after  40 ns,
			"1011" after  50 ns,
			"1010" after  60 ns,
			"1001" after  70 ns,
			"1000" after  80 ns,
			"0111" after  90 ns,
			"0110" after 100 ns,
			"0101" after 110 ns,
			"0100" after 120 ns,
			"0011" after 130 ns,
			"0010" after 140 ns,
			"0001" after 150 ns,
			"0000" after 160 ns,

			"HHHH" after 170 ns,
			"HHHL" after 180 ns,
			"HHLH" after 190 ns,
			"HHLL" after 200 ns,
			"HLHH" after 210 ns,
			"HLHL" after 220 ns,
			"HLLH" after 230 ns,
			"HLLL" after 240 ns,
			"LHHH" after 250 ns,
			"LHHL" after 260 ns,
			"LHLH" after 270 ns,
			"LHLL" after 280 ns,
			"LLHH" after 290 ns,
			"LLHL" after 300 ns,
			"LLLH" after 310 ns,
			"LLLL" after 320 ns;

	-- Connect the testbench to	the	component
	nand4: A4012B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (
			abcd(1), abcd(2), abcd(3), abcd(4),
			wxyz(1), wxyz(2), wxyz(3), wxyz(4),
			o(1), o(2));
end	architecture;