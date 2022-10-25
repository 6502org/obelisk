-- ============================================================================
-- 4020B 14-Stage Binary Counter (Test Bench)
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

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

entity A4020B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library	work;

architecture behaviour of A4020B_TestBench is
	component A4020B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			cp_n		:	in		std_logic;
			mr			:	in		std_logic;
			o0			:	out		std_logic;
			o3			:	out		std_logic;
			o4			:	out		std_logic;
			o5			:	out		std_logic;
			o6			:	out		std_logic;
			o7			:	out		std_logic;
			o8			:	out		std_logic;
			o9			:	out		std_logic;
			o10			:	out		std_logic;
			o11			:	out		std_logic;
			o12			:	out		std_logic;
			o13			:	out		std_logic);
	end	component;

	signal	clk_n	: std_logic	:= '0';
	signal	rst		: std_logic;
	signal  o		: std_logic_vector (11 downto 0);
begin
	-- Create a clock pluse
	clk_n <= not clk_n after 10 ns;
	
	-- Reset after short delay
	rst   <= 'U',
			 '1' after 20 ns,
			 '0' after 30 ns;

	-- Connect the testbench to	the	component
	device: A4020B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (
			clk_n, rst, o(0), o(1), o(2), o(3), o(4), o(5),
			o(6), o(7), o(8), o(9), o(10), o(11));
end	architecture;