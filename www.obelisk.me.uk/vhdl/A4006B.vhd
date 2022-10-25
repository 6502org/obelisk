-- ============================================================================
-- 4006B 18-Stage Static Shift Register
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

entity A4006B is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp_n		:	in		std_logic;
		da			:	in		std_logic;
		db			:	in		std_logic;
		dc			:	in		std_logic;
		dd			:	in		std_logic;
		o3a			:	out		std_logic;
		o3b			:	out		std_logic;
		o3c			:	out		std_logic;
		o4c			:	out		std_logic;
		o3d			:	out		std_logic;
		o4d			:	out		std_logic);
end	entity;

-- ============================================================================

library	ieee;
use	ieee.std_logic_1164.all;

architecture behaviour of A4006B is
	-- Shift registers
	signal	sa		: std_logic_vector (1 to 4)	:= "UUUU";
	signal	sb		: std_logic_vector (1 to 4)	:= "UUUU";
	signal	sc		: std_logic_vector (1 to 5)	:= "UUUUU";
	signal	sd		: std_logic_vector (1 to 5)	:= "UUUUU";
begin
	-- Shift the contents on falling edge of clock
	process	(cp_n)
	begin
		if falling_edge	(cp_n) then
			sa <= da & sa(1	to 3);
			sb <= db & sb(1	to 3);
			sc <= dc & sc(1	to 4);
			sd <= dd & sd(1	to 4);
		end	if;
	end	process;

	-- Extract outputs from	shift registers
	o3a	<= '1' after tplh when sa(4) = '1' else
		   '0' after tphl;

	o3b	<= '1' after tplh when sb(4) = '1' else
		   '0' after tphl;

	o3c	<= '1' after tplh when sc(4) = '1' else
		   '0' after tphl;

	o4c	<= '1' after tplh when sc(5) = '1' else
		   '0' after tphl;

	o3d	<= '1' after tplh when sd(4) = '1' else
		   '0' after tphl;

	o4d	<= '1' after tplh when sd(5) = '1' else
		   '0' after tphl;
end	architecture;