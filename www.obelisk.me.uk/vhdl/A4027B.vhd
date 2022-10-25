-- ============================================================================
-- 4027B Dual JK Flip Flop
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

entity A4027B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		s1			:	in		std_logic;		-- Set
		c1			:	in		std_logic;		-- Clear
		j1			:	in		std_logic;		-- Data
		k1			:	in		std_logic;		-- Data
		cp1			:	in		std_logic;		-- Clock
		s2			:	in		std_logic;
		c2			:	in		std_logic;
		j2			:	in		std_logic;
		k2			:	in		std_logic;
		cp2			:	in		std_logic;
		o1			:	out		std_logic;		-- Output
		o1_n		:	out		std_logic;		-- Output inverted (usually)
		o2			:	out		std_logic;
		o2_n		:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;
library work;

architecture behaviour of A4027B is
	-- Internal flip flop states
	signal ff1		: std_logic_vector (1 to 2);
	signal ff2 		: std_logic_vector (1 to 2);
begin
	-- Flip flop 1
	process (cp1,s1,c1)
		variable jk		: std_logic_vector (1 to 2);
	begin
		if ((s1 or c1) = '1') then
			ff1(1) <= not (not s1);
			ff1(2) <= not (not c1);
		elsif rising_edge(cp1) then
			jk := not ((not j1) & (not k1));

			case jk is
			when "10" => ff1 <= "10";
			when "01" => ff1 <= "01";
			when "11" => ff1 <= not(ff1(1)) & not(ff1(2));
			when others =>
			end case;
		end if;
	end process;

	-- Flip flop 2
	process (cp2,s2,c2)
		variable jk		: std_logic_vector (1 to 2);
	begin
		if ((s2 or c2) = '1') then
			ff2(1) <= not (not s2);
			ff2(2) <= not (not c2);
		elsif rising_edge(cp2) then
			jk := not ((not j2) & (not k2));

			case jk is
			when "10" => ff2 <= "10";
			when "01" => ff2 <= "01";
			when "11" => ff2 <= not(ff2(1)) & not(ff2(2));
			when others =>
			end case;
		end if;
	end process;

	-- Copy state to outputs adding propagation delay
	o1 	 <= '1' after tplh when to_bit(ff1(1)) = '1' else
		  	'0' after tphl;
	o1_n <= '1' after tplh when to_bit(ff1(2)) = '1' else
			'0' after tphl;

	o2 	 <= '1' after tplh when to_bit(ff2(1)) = '1' else
		  	'0' after tphl;
	o2_n <= '1' after tplh when to_bit(ff2(2)) = '1' else
			'0' after tphl;
end	architecture;