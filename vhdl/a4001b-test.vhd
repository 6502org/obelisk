-- ============================================================================
-- 4001B Quad 2-Input NOR Gates	(Test Bench)
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

entity A4001B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

architecture behaviour of A4001B_TestBench is
	component A4001B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			a1			:	in		std_logic;
			b1			:	in		std_logic;
			a2			:	in		std_logic;
			b2			:	in		std_logic;
			a3			:	in		std_logic;
			b3			:	in		std_logic;
			a4			:	in		std_logic;
			b4			:	in		std_logic;
			o1			:	out		std_logic;
			o2			:	out		std_logic;
			o3			:	out		std_logic;
			o4			:	out		std_logic);
	end	component;

	signal	ab	: std_logic_vector (1 to 2);
	signal	wx	: std_logic_vector (1 to 2);
	signal	o	: std_logic_vector (1 to 4);
begin
	-- Normal test pattern
	ab <=	"UU",

			"00" after 10 ns,
			"01" after 20 ns,
			"10" after 30 ns,
			"11" after 40 ns,

			"LL" after 50 ns,
			"LH" after 60 ns,
			"HL" after 70 ns,
			"HH" after 80 ns;

	-- Normal test pattern
	wx <=	"UU",

			"11" after 10 ns,
			"10" after 20 ns,
			"01" after 30 ns,
			"00" after 40 ns,

			"HH" after 50 ns,
			"HL" after 60 ns,
			"LH" after 70 ns,
			"LL" after 80 ns;

	-- Connect the testbench to	the	component
	nor2: A4001B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (
			ab(1), ab(2),
			ab(1), wx(2),
			wx(1), ab(2),
			wx(1), wx(2),
			o(1), o(2),	o(3), o(4));
end	architecture;