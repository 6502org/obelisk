-- ============================================================================
-- 4041B Quadruple True/Complement Buffer
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

entity A4041B is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		i1			:	in		std_logic;
		i2			:	in		std_logic;
		i3			:	in		std_logic;
		i4			:	in		std_logic;
		o1			:	out		std_logic;
		o1_n		:	out		std_logic;
		o2			:	out		std_logic;
		o2_n		:	out		std_logic;
		o3			:	out		std_logic;
		o3_n		:	out		std_logic;
		o4			:	out		std_logic;
		o4_n		:	out		std_logic);
end	entity;

-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

architecture dataflow of A4041B is
begin
	o1	 <= '1' after tplh when to_bit(i1) = '1' else
		    '0' after tphl;

	o1_n <= '1' after tplh when to_bit(i1) = '0' else
		    '0' after tphl;

	o2	 <= '1' after tplh when to_bit(i2) = '1' else
		    '0' after tphl;

	o2_n <= '1' after tplh when to_bit(i2) = '0' else
		    '0' after tphl;

	o3	 <= '1' after tplh when to_bit(i3) = '1' else
		    '0' after tphl;

	o3_n <= '1' after tplh when to_bit(i3) = '0' else
		    '0' after tphl;

	o4	 <= '1' after tplh when to_bit(i4) = '1' else
		    '0' after tphl;

	o4_n <= '1' after tplh when to_bit(i4) = '0' else
		    '0' after tphl;
end architecture;