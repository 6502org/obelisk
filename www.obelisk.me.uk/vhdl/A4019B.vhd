-- ============================================================================
-- 4019B Quadruple 2-Input Multiplexor
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

entity A4019B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		sa			:	in		std_logic;
		sb			:	in		std_logic;
		a0			:	in		std_logic;
		b0			:	in		std_logic;
		a1			:	in		std_logic;
		b1			:	in		std_logic;
		a2			:	in		std_logic;
		b2			:	in		std_logic;
		a3			:	in		std_logic;
		b3			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture dataflow of A4019B is
begin
	o0 <= '1' after tplh when ((sa and a0) or (sb and b0)) = '1' else
	      '0' after tphl;

	o1 <= '1' after tplh when ((sa and a1) or (sb and b1)) = '1' else
		  '0' after tphl;

	o2 <= '1' after tplh when ((sa and a2) or (sb and b2)) = '1' else
		  '0' after tphl;

	o3 <= '1' after tplh when ((sa and a3) or (sb and b3)) = '1' else
		  '0' after tphl;
end architecture;