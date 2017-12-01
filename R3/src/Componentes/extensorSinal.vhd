library ieee;
use ieee.std_logic_1164.all;

entity extensorSinal is 
   	generic(
      	OriginalVectorLength: positive := 16;
      	ExtendedVectorLength: positive := 32);
   	port(
      	Input: in std_logic_vector(OriginalVectorLength-1 downto 0);
      	Output: out std_logic_vector(ExtendedVectorLength-1 downto 0)
   	);
end entity;

architecture Behavioral of extensorSinal is
begin
	Output(OriginalVectorLength-1 downto 0) <= Input;
	Output(ExtendedVectorLength-1 downto OriginalVectorLength) <= (others => Input(OriginalVectorLength-1));
end architecture;
