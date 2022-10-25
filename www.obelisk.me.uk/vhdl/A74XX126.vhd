-- ============================================================================
-- 74XX126 Quad Buffer/Line Driver (3-State)
--
-- Copyright (C),2004 Andrew John Jacobs.
--
-- This	program	is provided	free of	charge for educational purposes
--
-- Redistribution and use in binary	form without modification, is permitted
-- provided	that the above copyright notice, this list of conditions and the
-- following disclaimer	in the documentation and/or	other materials	provided
-- with	the	distribution.
--
-- THIS	SOFTWARE IS	PROVIDED BY	THE	AUTHOR AND CONTRIBUTORS	'AS	IS'	AND	ANY
-- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED.	IN NO EVENT	SHALL THE AUTHOR OR	CONTRIBUTORS BE	LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR	CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS	OF USE,	DATA, OR PROFITS; OR BUSINESS INTERRUPTION)	HOWEVER	CAUSED AND
-- ON ANY THEORY OF	LIABILITY, WHETHER IN CONTRACT,	STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR	OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
-- THIS	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF	SUCH DAMAGE.
-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

entity A74XX126 is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns;
		tpzh		:	time	:= 0 ns;
		tpzl		:	time	:= 0 ns;
		tphz		:	time	:= 0 ns;
		tplz		:	time	:= 0 ns);
	port (
		a1			:	in		std_logic;
		oe1			:	in		std_logic;
		a2			:	in		std_logic;
		oe2			:	in		std_logic;
		a3			:	in		std_logic;
		oe3			:	in		std_logic;
		a4			:	in		std_logic;
		oe4			:	in		std_logic;
		o1			:	out		std_ulogic;
		o2			:	out		std_ulogic;
		o3			:	out		std_ulogic;
		o4			:	out		std_ulogic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A74XX126 is
	signal v1	: std_logic := 'U';
	signal v2	: std_logic := 'U';
	signal v3	: std_logic := 'U';
	signal v4	: std_logic := 'U';

	signal c1	: std_logic := 'U';
	signal c2	: std_logic := 'U';
	signal c3	: std_logic := 'U';
	signal c4	: std_logic := 'U';
begin
	-- I have tried several different ways of including the propagation delays
	-- in this model but I am yet to find a technique that will pass Xilinx
	-- synthesis without reporting a 'bad synchronous description' error.

	-- Copy inputs to local signals adding delay
	v1 <= '0' after tphl when to_bit(a1) = '0' else
		  '1' after tplh;

	v2 <= '0' after tphl when to_bit(a2) = '0' else
		  '1' after tplh;

	v3 <= '0' after tphl when to_bit(a3) = '0' else
		  '1' after tplh;

	v4 <= '0' after tphl when to_bit(a4) = '0' else
		  '1' after tplh;

	-- Copy control inputs signal adding delay
	c1 <= '0' after tplz when to_bit(oe1) = '0' and to_bit(a1) = '0' else
		  '0' after tphz when to_bit(oe1) = '0' and to_bit(a1) = '1' else
		  '1' after tpzl when to_bit(oe1) = '1' and to_bit(a1) = '0' else
		  '1' after tpzh when to_bit(oe1) = '1' and to_bit(a1) = '1';

	c2 <= '0' after tplz when to_bit(oe2) = '0' and to_bit(a2) = '0' else
		  '0' after tphz when to_bit(oe2) = '0' and to_bit(a2) = '1' else
		  '1' after tpzl when to_bit(oe2) = '1' and to_bit(a2) = '0' else
		  '1' after tpzh when to_bit(oe2) = '1' and to_bit(a2) = '1';

	c3 <= '0' after tplz when to_bit(oe3) = '0' and to_bit(a3) = '0' else
		  '0' after tphz when to_bit(oe3) = '0' and to_bit(a3) = '1' else
		  '1' after tpzl when to_bit(oe3) = '1' and to_bit(a3) = '0' else
		  '1' after tpzh when to_bit(oe3) = '1' and to_bit(a3) = '1';

	c4 <= '0' after tplz when to_bit(oe4) = '0' and to_bit(a4) = '0' else
		  '0' after tphz when to_bit(oe4) = '0' and to_bit(a4) = '1' else
		  '1' after tpzl when to_bit(oe4) = '1' and to_bit(a4) = '0' else
		  '1' after tpzh when to_bit(oe4) = '1' and to_bit(a4) = '1';

	-- Set the outputs
	o1 <= v1 when to_bit(c1) = '1' else 'Z';		  
	o2 <= v2 when to_bit(c2) = '1' else 'Z';
	o3 <= v3 when to_bit(c3) = '1' else 'Z';
	o4 <= v4 when to_bit(c4) = '1' else 'Z';
end architecture;