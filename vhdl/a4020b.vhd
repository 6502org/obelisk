-- ============================================================================
-- 4020B 14-Stage Binary Counter
--
-- Copyright (C),2004-2005 Andrew John Jacobs.
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

entity A4020B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp_n		:	in		std_logic;
		mr			:	in		std_logic;
		o0			:	out		std_logic;
		o3			:	out		std_logic;
		o4			:	out		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic;
		o7			:	out		std_logic;
		o8			:	out		std_logic;
		o9			:	out		std_logic;
		o10			:	out		std_logic;
		o11			:	out		std_logic;
		o12			:	out		std_logic;
		o13			:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

architecture behaviour of A4020B is
	-- Internal flip-flop states
	signal	ff		:	std_logic_vector (13 downto 0) := "UUUUUUUUUUUUUU";
begin
	-- Handle async. reset and active low clock pulse
	process (cp_n, mr)
	begin
		if (to_bit(mr) = '1') then
			ff <= "00000000000000";
		elsif falling_edge(cp_n) then
			ff <= ff + 1;
		end if;
	end process;

	-- Copy flip-flop states to output adding delay
	o0  <= '1' after tplh when to_bit(ff(0)) = '1' else
	       '0' after tphl;

	o3  <= '1' after tplh when to_bit(ff(3)) = '1' else
		   '0' after tphl;

	o4  <= '1' after tplh when to_bit(ff(4)) = '1' else
		   '0' after tphl;

	o5  <= '1' after tplh when to_bit(ff(5)) = '1' else
		   '0' after tphl;

	o6  <= '1' after tplh when to_bit(ff(6)) = '1' else
		   '0' after tphl;

	o7  <= '1' after tplh when to_bit(ff(7)) = '1' else
		   '0' after tphl;

	o8  <= '1' after tplh when to_bit(ff(8)) = '1' else
		   '0' after tphl;

	o9  <= '1' after tplh when to_bit(ff(9)) = '1' else
		   '0' after tphl;

	o10 <= '1' after tplh when to_bit(ff(10)) = '1' else
		   '0' after tphl;

	o11 <= '1' after tplh when to_bit(ff(11)) = '1' else
		   '0' after tphl;

	o12 <= '1' after tplh when to_bit(ff(12)) = '1' else
		   '0' after tphl;

	o13 <= '1' after tplh when to_bit(ff(13)) = '1' else
		   '0' after tphl;
end architecture;