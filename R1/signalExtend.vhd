----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Prof. Dr. Eng. Rafael Luiz Cancian
-- 
-- Create Date:    
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
library IEEE;
use ieee.std_logic_1164.all;

entity signalExtend is
	generic(	finalWidth:  integer := 12;
				actualWidth: integer := 6);
	port(
		input:  in  std_logic_vector(actualWidth-1 downto 0);
		output: out std_logic_vector(finalWidth-1 downto 0)
	);
end entity;


architecture behavioral of signalExtend is
begin
	output(actualWidth-1 downto 0) <= input;
	output(finalWidth-1 downto actualWidth) <= (others=>input(actualWidth-1));
end architecture;