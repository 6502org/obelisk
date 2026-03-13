-- ============================================================================
-- 4028B 1-of-10 Decoder
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

library ieee;
use ieee.std_logic_1164.all;

entity A4028B is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		a0			:	in		std_logic;
		a1			:	in		std_logic;
		a2			:	in		std_logic;
		a3			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic;
		o4			:	out		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic;
		o7			:	out		std_logic;
		o8			:	out		std_logic;
		o9			:	out		std_logic);
end	entity;

-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

architecture dataflow of A4028B is
	signal	n0		: std_logic := 'U';
	signal	n1		: std_logic := 'U';
	signal	n2		: std_logic := 'U';
	signal	n3		: std_logic := 'U';
begin
	-- Create negated inputs for use in outputs
	n0	<= not a0;
	n1	<= not a1;
	n2	<= not a2;
	n3	<= not a3;
	
	-- Create outputs adding delays
	o0	<= '1' after tplh when (n3 and n2 and n1 and n0) = '1' else
		   '0' after tphl;

	o1	<= '1' after tplh when (n3 and n2 and n1 and a0) = '1' else
		   '0' after tphl;

	o2	<= '1' after tplh when (n3 and n2 and a1 and n0) = '1' else
		   '0' after tphl;

	o3	<= '1' after tplh when (n3 and n2 and a1 and a0) = '1' else
		   '0' after tphl;

	o4	<= '1' after tplh when (n3 and a2 and n1 and n0) = '1' else
		   '0' after tphl;

	o5	<= '1' after tplh when (n3 and a2 and n1 and a0) = '1' else
		   '0' after tphl;

	o6	<= '1' after tplh when (n3 and a2 and a1 and n0) = '1' else
		   '0' after tphl;

	o7	<= '1' after tplh when (n3 and a2 and a1 and a0) = '1' else
		   '0' after tphl;

	o8	<= '1' after tplh when (a3 and n2 and n1 and n0) = '1' else
		   '0' after tphl;

	o9	<= '1' after tplh when (a3 and n2 and n1 and a0) = '1' else
		   '0' after tphl;
end architecture;