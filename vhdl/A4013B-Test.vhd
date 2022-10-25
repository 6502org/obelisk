-- ============================================================================
-- 4013B Dual D-type Flip Flop (Test Bench)
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

entity A4013B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4013B_TestBench is
	component A4013B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			s1			:	in		std_logic;		-- Set
			c1			:	in		std_logic;		-- Clear
			d1			:	in		std_logic;		-- Data
			cp1			:	in		std_logic;		-- Clock
			s2			:	in		std_logic;
			c2			:	in		std_logic;
			d2			:	in		std_logic;
			cp2			:	in		std_logic;
			o1			:	out		std_logic;		-- Output
			o1_n		:	out		std_logic;		-- Output inverted
			o2			:	out		std_logic;
			o2_n		:	out		std_logic);
	end	component;

	signal	scd		: std_logic_vector (1 to 3);
	signal	o1		: std_logic_vector (1 to 2);
	signal  o2		: std_logic_vector (1 to 2);
	signal	clk		: std_logic := '0';
begin
	-- Create a clock signal
	clk <= not clk after 10 ns;

	-- Test pattern
	scd <=	"UUU",

			"000" after  20 ns,
			"001" after  40 ns,
			"010" after  60 ns,
			"011" after  80 ns,
			"100" after 100 ns,
			"101" after 120 ns,
			"110" after 140 ns,
			"111" after 160 ns,

			"LLL" after 180 ns,
			"LLH" after 200 ns,
			"LHL" after 220 ns,
			"LHH" after 240 ns,
			"HLL" after 260 ns,
			"HLH" after 280 ns,
			"HHL" after 300 ns,
			"HHH" after 320 ns;

	-- Connect the testbench to	the	component
	gate: A4013B
		generic	map	(
			tplh =>	7 ns, tphl => 7	ns)
		port map (
			scd(1), scd(2), scd(3), clk,
			scd(1), scd(2), scd(3), clk,
			o1(1), o1(2), o2(1), o2(2));
end	architecture;