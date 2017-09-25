----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  <nome completo do aluno>
-- 
-- Create Date: <data da criação do arquivo> 
-- Design Name: 
-- Module Name:    
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--completar

entity ULA is
	generic(width: positive := 14);
	port(
		a, b: in std_logic_vector(width-1 downto 0);
		op: in std_logic_vector(2 downto 0);  --000:AND , 001:OR , 010:ADD, 110:SUB, 111:SLT
		zero: out std_logic;
		res: out std_logic_vector(width-1 downto 0)
	);
end entity;

architecture Behavioral of ULA is
	--completar
	signal result : std_logic_vector(width-1 downto 0);
begin
	--completar
	result <= a + b when op = "010" else -- add
			 a - b when op = "110" else -- sub
			 a or b when op = "001" else -- or
			 a and b when op = "000" else
			 (others => '1') when a < b else
			 (others => '0'); -- and
			 
	res <= result;
	zero <= '1' when result = (width => '0') else '0';
			 
end architecture;