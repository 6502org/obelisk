-- ============================================================================
-- 4002B Dual 4-Input NOR Gates
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

entity A4002B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
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
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture dataflow of A4002B is
begin
	o1 <= '1' after	tplh when (a1 or b1	or c1 or d1) = '0' else
		  '0' after	tphl;

	o2 <= '1' after	tplh when (a2 or b2	or c2 or d2) = '0' else
		  '0' after	tphl;
end	architecture;