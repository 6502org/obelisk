-- ============================================================================
-- 4008B 4-Bit Binary Full Adder
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

entity A4008B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		ci			:	in		std_logic;
		a			:	in		std_logic_vector (3 downto 0);
		b			:	in		std_logic_vector (3 downto 0);
		co			:	out		std_logic;
		o			:	out		std_logic_vector (3 downto 0));
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture dataflow of A4008B is
	signal	p		: std_logic_vector (3 downto 0);
	signal	g		: std_logic_vector (3 downto 0);
	signal	c1		: std_logic;
	signal	c2		: std_logic;
	signal	c3		: std_logic;
begin
	-- Create intermediate values
	p  <= a xor b;
	g  <= a and b;

	-- Do look ahead carry generation
	c1 <= g(0) or (p(0) and ci);
	c2 <= g(1) or (p(1) and c1);
	c3 <= g(2) or (p(2) and c2);
	co <= g(3) or (p(3) and c3);

	-- Perform the binary addition
	o(0) <= '1' after tplh when (p(0) xor ci) = '1' else
			'0' after tphl;

	o(1) <= '1' after tplh when (p(1) xor c1) = '1' else
			'0' after tphl;

	o(2) <= '1' after tplh when (p(2) xor c2) = '1' else
			'0' after tphl;

	o(3) <= '1' after tplh when (p(3) xor c3) = '1' else
			'0' after tphl;
end	architecture;