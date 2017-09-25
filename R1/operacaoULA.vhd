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
--completar 

entity OperacaoULA is
	port(
		ULAOp: in std_logic_vector(1 downto 0);
		Funct: in std_logic_vector(5 downto 0);
		op: out std_logic_vector(2 downto 0)
	);
end entity;

architecture Behavioral of OperacaoULA is
begin
	op <= "010" when ULAOp = "00" else -- add
			"110" when ULAOp = "01" else -- sub
			"001" when Funct(3 downto 0) = "0101" else -- or
			"010" when Funct(3 downto 0) = "0000" else -- add
			"000" when Funct(3 downto 0) = "0100" else -- and
			"111" when Funct(3 downto 0) = "1010" else -- slt
			"110" when Funct(3 downto 0) = "0010";
			
		
end architecture;