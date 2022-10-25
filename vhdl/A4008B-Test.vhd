-- ============================================================================
-- 4008B 4-Bit Binary Full Adder (Test Bench)
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

entity A4008B_TestBench	is
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4008B_TestBench is
	component A4008B is
		generic	(
			tplh		:	time;
			tphl		:	time);
		port (
			ci			:	in		std_logic;
			a			:	in		std_logic_vector (3 downto 0);
			b			:	in		std_logic_vector (3 downto 0);
			co			:	out		std_logic;
			o			:	out		std_logic_vector (3 downto 0));
	end	component;

	signal	ci		: std_logic;
	signal	a		: std_logic_vector (3 downto 0);
	signal	b		: std_logic_vector (3 downto 0);
	signal	co		: std_logic;
	signal	o		: std_logic_vector (3 downto 0);
begin
	ci <= '0';
	
	a  <= "0000",
		  "1111" after 10 ns;
	
	b  <= "0000",
		  "0001" after 10 ns;
	
	-- Connect the testbench to	the	component
	adder: A4008B
		generic	map	(
			tplh =>	5 ns, tphl => 7	ns)
		port map (ci, a, b, co, o);
end	architecture;