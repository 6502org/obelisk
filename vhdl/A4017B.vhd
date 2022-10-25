-- ============================================================================
-- 4015B 5-Stage Johnson Counter
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

entity A4017B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp0			:	in		std_logic;
		cp1_n		:	in		std_logic;
		mr			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic;
		o4			:	out		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic;
		o7			:	out		std_logic;
		o8			:	out		std_logic;
		o9			:	out		std_logic;
		co_n		:	out		std_logic);
end	entity;

-- ============================================================================

-- This implementation is based on the logic used in the Philips HEF4017B

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4017B is
	signal	cp			: std_logic;
	signal	ff1			: std_logic := 'U';
	signal	ff2			: std_logic := 'U';
	signal	ff3			: std_logic := 'U';
	signal	ff4			: std_logic := 'U';
	signal	ff5			: std_logic := 'U';
begin
	-- Combine the clock inputs
	cp <= cp0 and not(cp1_n);

	-- Handle an async. reset or a sync. clock pulse
	process	(cp, mr)
	begin
		if (to_bit(mr) = '1') then
			ff1 <= '0';
			ff2 <= '0';
			ff3 <= '0';
			ff4 <= '0';
			ff5 <= '0';
		else
			if rising_edge(cp) then
				ff1 <= not ff5;
				ff2 <= ff1;
				ff3 <= (ff1 or ff3) and ff2;
				ff4 <= ff3;
				ff5 <= ff4;
			end if;
		end	if;
	end	process;

	-- Extract outputs from flip-flops
	o0 <= '1' after tplh when not(ff1 or ff5) = '1' else
	      '0' after tphl;

	o1 <= '1' after tplh when not(ff2 or not ff1) = '1' else
		  '0' after tphl;

	o2 <= '1' after tplh when not(ff3 or not ff2) = '1' else
		  '0' after tphl;

	o3 <= '1' after tplh when not(ff4 or not ff3) = '1' else
		  '0' after tphl;

	o4 <= '1' after tplh when not(ff5 or not ff4) = '1' else
		  '0' after tphl;

	o5 <= '1' after tplh when not(not ff1 or not ff5) = '1' else
		  '0' after tphl;

	o6 <= '1' after tplh when not(ff1 or not ff2) = '1' else
		  '0' after tphl;

	o7 <= '1' after tplh when not(ff2 or not ff3) = '1' else
		  '0' after tphl;

	o8 <= '1' after tplh when not(ff3 or not ff4) = '1' else
		  '0' after tphl;

	o9 <= '1' after tplh when not(ff4 or not ff5) = '1' else
		  '0' after tphl;

	co_n <= '1' after tplh when ff5 = '0' else
			'0' after tphl;
end architecture;