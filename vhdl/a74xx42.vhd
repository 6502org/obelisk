-- ============================================================================
-- 74XX42 BCD to Decimal Decoder (1-of-10)
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

entity A74XX42 is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		a0			:	in		std_logic;
		a1			:	in		std_logic;
		a2			:	in		std_logic;
		a3			:	in		std_logic;
		o0_n		:	out		std_logic;
		o1_n		:	out		std_logic;
		o2_n		:	out		std_logic;
		o3_n		:	out		std_logic;
		o4_n		:	out		std_logic;
		o5_n		:	out		std_logic;
		o6_n		:	out		std_logic;
		o7_n		:	out		std_logic;
		o8_n		:	out		std_logic;
		o9_n		:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture dataflow of A74XX42 is
	signal a		: std_logic_vector (3 downto 0);
begin
	a <= not ((not a3) & (not a2) &	(not a1) & (not	a0));

	o0_n <=	'0'	after tphl when	(a = "0000") or	(a = "LLLL") else
			'1'	after tplh;

	o1_n <=	'0'	after tphl when	(a = "0001") or	(a = "LLLH")else
			'1'	after tplh;

	o2_n <=	'0'	after tphl when	(a = "0010") or	(a = "LLHL")else
			'1'	after tplh;

	o3_n <=	'0'	after tphl when	(a = "0011") or	(a = "LLHH")else
			'1'	after tplh;

	o4_n <=	'0'	after tphl when	(a = "0100") or	(a = "LHLL")else
			'1'	after tplh;				   

	o5_n <=	'0'	after tphl when	(a = "0101") or	(a = "LHLH")else
			'1'	after tplh;

	o6_n <=	'0'	after tphl when	(a = "0110") or	(a = "LHHL")else
			'1'	after tplh;

	o7_n <=	'0'	after tphl when	(a = "0111") or	(a = "LHHH")else
			'1'	after tplh;

	o8_n <=	'0'	after tphl when	(a = "1000") or	(a = "HLLL")else
			'1'	after tplh;

	o9_n <=	'0'	after tphl when	(a = "1001") or	(a = "HLLH")else
			'1'	after tplh;
end	architecture;