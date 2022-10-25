-- ============================================================================
-- 74XX08 Quad 2-Input AND Gates
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

entity A74XX08 is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
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
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture dataflow of A74XX08 is
begin
	o1 <= '0' after	tphl when (a1 and b1) =	'0'	else
		  '1' after	tplh;

	o2 <= '0' after	tphl when (a2 and b2) =	'0'	else
		  '1' after	tplh;

	o3 <= '0' after	tphl when (a3 and b3) =	'0'	else
		  '1' after	tplh;

	o4 <= '0' after	tphl when (a4 and b4) =	'0'	else
		  '1' after	tplh;
end	architecture;