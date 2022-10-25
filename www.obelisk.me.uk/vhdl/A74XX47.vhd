-- ============================================================================
-- 74XX47 BCD to 7-Segment Decoder/Driver
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

entity A74XX47 is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		a0			:	in		std_logic;
		a1			:	in		std_logic;
		a2			:	in		std_logic;
		a3			:	in		std_logic;
		lt_n		:	in		std_logic;
		rbi_n		:	in		std_logic;
		rbo_n		:	inout	std_logic;
		a_n			:	out		std_logic;
		b_n			:	out		std_logic;
		c_n			:	out		std_logic;
		d_n			:	out		std_logic;
		e_n			:	out		std_logic;
		f_n			:	out		std_logic;
		g_n			:	out		std_logic);
end	entity;

-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behaviour of A74XX47 is
begin

	process (lt_n, rbi_n, rbo_n, a3, a2, a1, a0)
		variable a		: std_logic_vector (3 downto 0);
   	begin
		-- I would rather write something more obvious like:
		--
		-- 	a := to_bit(a3) & to_bit(a2) & to_bit(a1) & to_bit(a0)
		--
		-- But VDHL won't accept it so I'm using logic operators to do the
		-- to_bit conversion. They are optimised away during synthesis.

		a := not ((not a3) & (not a2) & (not a1) & (not a0));

		if (to_bit(rbo_n) = '0') then
			-- Blanking input takes priority
			a_n <= '1' after tplh;
			b_n <= '1' after tplh;
			c_n <= '1' after tplh;
			d_n <= '1' after tplh;
			e_n <= '1' after tplh;
			f_n <= '1' after tplh;
			g_n <= '1' after tplh;
		elsif (to_bit(lt_n) = '0') then
			-- Then a lamp test
 			a_n <= '0' after tphl;
			b_n <= '0' after tphl;
			c_n <= '0' after tphl;
			d_n <= '0' after tphl;
			e_n <= '0' after tphl;
			f_n <= '0' after tphl;
			g_n <= '0' after tphl;

			rbo_n <= '1' after tplh; 
		elsif ((a = "0000") and (to_bit(rbi_n) = '0')) then
			-- Suppressing a zero?
			a_n <= '1' after tplh;
			b_n <= '1' after tplh;
			c_n <= '1' after tplh;
			d_n <= '1' after tplh;
			e_n <= '1' after tplh;
			f_n <= '1' after tplh;
			g_n <= '1' after tplh;

			rbo_n <= '0' after tphl;
		else
			-- Normal digit display
			case a is
			when "0000" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '0' after tphl;
				g_n <= '1' after tplh;

			when "0001" =>
				a_n <= '1' after tplh;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '1' after tplh;
				g_n <= '1' after tplh;

			when "0010" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '1' after tplh;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '1' after tplh;
				g_n <= '0' after tphl;

			when "0011" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '1' after tplh;
				f_n <= '1' after tplh;
				g_n <= '0' after tphl;

			when "0100" =>
				a_n <= '1' after tplh;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "0101" =>
				a_n <= '0' after tphl;
				b_n <= '1' after tplh;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '1' after tplh;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "0110" =>
				a_n <= '1' after tplh;
				b_n <= '1' after tplh;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "0111" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '1' after tplh;
				g_n <= '1' after tplh;

			when "1000" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "1001" =>
				a_n <= '0' after tphl;
				b_n <= '0' after tphl;
				c_n <= '0' after tphl;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "1010" =>
				a_n <= '1' after tplh;
				b_n <= '1' after tplh;
				c_n <= '1' after tplh;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '1' after tplh;
				g_n <= '0' after tphl;

			when "1011" =>
				a_n <= '1' after tplh;
				b_n <= '1' after tplh;
				c_n <= '0' after tphl;
				d_n <= '0' after tphl;
				e_n <= '1' after tplh;
				f_n <= '1' after tplh;
				g_n <= '0' after tphl;

			when "1100" =>
				a_n <= '1' after tplh;
				b_n <= '0' after tphl;
				c_n <= '1' after tplh;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "1101" =>
				a_n <= '0' after tphl;
				b_n <= '1' after tplh;
				c_n <= '1' after tplh;
				d_n <= '0' after tphl;
				e_n <= '1' after tplh;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when "1110" =>
				a_n <= '1' after tplh;
				b_n <= '1' after tplh;
				c_n <= '1' after tplh;
				d_n <= '0' after tphl;
				e_n <= '0' after tphl;
				f_n <= '0' after tphl;
				g_n <= '0' after tphl;

			when others =>
				a_n <= '1' after tplh;
				b_n <= '1' after tplh;
				c_n <= '1' after tplh;
				d_n <= '1' after tplh;
				e_n <= '1' after tplh;
				f_n <= '1' after tplh;
				g_n <= '1' after tplh;
   			end case;

			rbo_n <= '1' after tphl;
		end if;
	end process;
end architecture;