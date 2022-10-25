-- ============================================================================
-- 4024B 7-Stage Binary Counter
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

library	ieee;
use	ieee.std_logic_1164.all;

entity A4024B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp_n		:	in		std_logic;
		mr			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic;
		o4			:	out		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4024B is
	-- Internal flip-flop states
	signal	ff0		:	std_logic := 'U';
	signal	ff1		:	std_logic := 'U';
	signal	ff2		:	std_logic := 'U';
	signal	ff3		:	std_logic := 'U';
	signal	ff4		:	std_logic := 'U';
	signal	ff5		:	std_logic := 'U';
	signal	ff6		:	std_logic := 'U';
begin
	-- Handle async. reset and active low clock pulse
	process (cp_n, mr)
	begin
		if (to_bit(mr) = '1') then
			ff0 <= '0';
			ff1 <= '0';
			ff2 <= '0';
			ff3 <= '0';
			ff4 <= '0';
			ff5 <= '0';
			ff6 <= '0';
		elsif falling_edge(cp_n) then
			ff0 <= not ff0;

			if ff0 = '1' then
				ff1 <= not ff1;
			end if;
			 
			if ff1 = '1' then
				ff2 <= not ff2;
			end if;
			 
			if ff2 = '1' then
				ff3 <= not ff3;
			end if;
			 
			if ff3 = '1' then
				ff4 <= not ff4;
			end if;
			 
			if ff4 = '1' then
				ff5 <= not ff5;
			end if;
			 
			if ff5 = '1' then
				ff6 <= not ff6;
			end if;
		end if;
	end process;

	-- Copy flip-flop states to output adding delay
	o0  <= '1' after tplh when to_bit(ff0) = '1' else
	       '0' after tphl;

	o1  <= '1' after tplh when to_bit(ff1) = '1' else
	       '0' after tphl;

	o2  <= '1' after tplh when to_bit(ff2) = '1' else
	       '0' after tphl;

	o3  <= '1' after tplh when to_bit(ff3) = '1' else
		   '0' after tphl;

	o4  <= '1' after tplh when to_bit(ff4) = '1' else
		   '0' after tphl;

	o5  <= '1' after tplh when to_bit(ff5) = '1' else
		   '0' after tphl;

	o6  <= '1' after tplh when to_bit(ff6) = '1' else
		   '0' after tphl;
end architecture;