-- ============================================================================
-- 4006B 18-Stage Static Shift Register (Test Bench)
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

entity A4006B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

architecture behaviour of A4006B_TestBench is
	component A4006B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			cp_n		:	in		std_logic;
			da			:	in		std_logic;
			db			:	in		std_logic;
			dc			:	in		std_logic;
			dd			:	in		std_logic;
			o3a			:	out		std_logic;
			o3b			:	out		std_logic;
			o3c			:	out		std_logic;
			o4c			:	out		std_logic;
			o3d			:	out		std_logic;
			o4d			:	out		std_logic);
	end	component;

	signal	clk_n	: std_logic	:= '0';
	signal	da		: std_logic;
	signal	o3a		: std_logic;
	signal	o3b		: std_logic;
	signal	o3c		: std_logic;
	signal	o4c		: std_logic;
	signal	o3d		: std_logic;
	signal	o4d		: std_logic;
begin
	-- Create a clock pluse
	clk_n <= not clk_n after 10 ns;

	-- Inject a single pulse to shift thru the entire register
	da 	  <= '0',
			 '1' after 60 ns,
			 '0' after 70 ns;

	-- Connect the testbench to	the	component
	shift: A4006B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (
			clk_n, da, o3a, o3b, o4c,
			o3a, o3b, o3c, o4c, o3d, o4d);
end	architecture;