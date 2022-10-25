-- ============================================================================
-- 4001B Dual 3-Input NOR Gates	and Inverter (Test Bench)
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

entity A4000B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

architecture behaviour of A4000B_TestBench is
	component A4000B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			a1			:	in		std_logic;
			b1			:	in		std_logic;
			c1			:	in		std_logic;
			a2			:	in		std_logic;
			b2			:	in		std_logic;
			c2			:	in		std_logic;
			i3			:	in		std_logic;
			o1			:	out		std_logic;
			o2			:	out		std_logic;
			o3			:	out		std_logic);
	end	component;

	signal	abc	: std_logic_vector (1 to 3);
	signal	xyz	: std_logic_vector (1 to 3);
	signal	i	: std_logic := '0';
	signal	o	: std_logic_vector (1 to 3);
begin
	-- Normal test pattern
	abc <=	"UUU",

			"000" after  10 ns,
			"001" after  20 ns,
			"010" after  30 ns,
			"011" after  40 ns,

			"100" after  50 ns,
			"101" after  60 ns,
			"110" after  70 ns,
			"111" after  80 ns,

			"LLL" after  90 ns,
			"LLH" after 100 ns,
			"LHL" after 110 ns,
			"LHH" after 120 ns,

			"HLL" after 130 ns,
			"HLH" after 140 ns,
			"HHL" after 150 ns,
			"HHH" after 160 ns;

	-- Normal test pattern
	xyz <=	"UUU",

			"111" after  10 ns,
			"110" after  20 ns,
			"101" after  30 ns,
			"100" after  40 ns,

			"011" after  50 ns,
			"010" after  60 ns,
			"001" after  70 ns,
			"000" after  80 ns,

			"HHH" after  90 ns,
			"HHL" after 100 ns,
			"HLH" after 110 ns,
			"HLL" after 120 ns,

			"LHH" after 130 ns,
			"LHL" after 140 ns,
			"LLH" after 150 ns,
			"LLL" after 160 ns;

	-- Inverter pattern
	i	<= not i after 10 ns;

	-- Connect the testbench to	the	component
	nor3: A4000B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (
			abc(1), abc(2), abc(3),
			xyz(1), xyz(2), xyz(3),
			i, o(1), o(2), o(3));
end	architecture;