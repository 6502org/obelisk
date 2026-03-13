-- ============================================================================
-- 4015B Dual 4-Bit Static Shift Register
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

library ieee;
use ieee.std_logic_1164.all;

entity A4015B is
	generic (
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cpa			:	in		std_logic;
		mra			:	in		std_logic;
		da			:	in		std_logic;
		cpb			:	in		std_logic;
		mrb			:	in		std_logic;
		db			:	in		std_logic;
		o0a			:	out		std_logic;
		o1a			:	out		std_logic;
		o2a			:	out		std_logic;
		o3a			:	out		std_logic;
		o0b			:	out		std_logic;
		o1b			:	out		std_logic;
		o2b			:	out		std_logic;
		o3b			:	out		std_logic);
end entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4015B is
	-- Shift registers
	signal	sa		: std_logic_vector (0 to 3)	:= "UUUU";
	signal	sb		: std_logic_vector (0 to 3)	:= "UUUU";
begin
	-- Process clock inputs and resets
	process (cpa, mra)
	begin
		if (to_bit(mra) = '1') then
			sa <= "0000";
		else
			if rising_edge (cpa) then
				sa <= da & sa(0	to 2);
			end if;
		end	if;
	end process;

	process (cpb, mrb)
	begin
		if (to_bit(mrb) = '1') then
			sb <= "0000";
		else
			if rising_edge (cpb) then
				sb <= db & sb(0	to 2);
			end if;
		end	if;
	end	process;

	-- Extract outputs from	shift registers
	o0a	<= '1' after tplh when sa(0) = '1' else
		   '0' after tphl;

	o1a	<= '1' after tplh when sa(1) = '1' else
		   '0' after tphl;

	o2a	<= '1' after tplh when sa(2) = '1' else
		   '0' after tphl;

	o3a	<= '1' after tplh when sa(3) = '1' else
		   '0' after tphl;

	o0b	<= '1' after tplh when sb(0) = '1' else
		   '0' after tphl;

	o1b	<= '1' after tplh when sb(1) = '1' else
		   '0' after tphl;

	o2b	<= '1' after tplh when sb(2) = '1' else
		   '0' after tphl;

	o3b	<= '1' after tplh when sb(3) = '1' else
		   '0' after tphl;
end	architecture;