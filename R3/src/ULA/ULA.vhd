library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is 
   generic(VectorLength: positive := 32);
   port(
      	InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
      	Operation: in std_logic_vector(2 downto 0);
      	Output: out std_logic_vector(VectorLength-1 downto 0);
      	Zero: out std_logic
   );
end entity;

architecture Behavioral of ULA is

component Arithmetic is
	generic(VectorLength: positive := 32);
	port(
		InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
		CarryIn: in std_logic;
		Output: out std_logic_vector(VectorLength-1 downto 0)
   );
end component;

component Logical is
	generic(VectorLength: positive := 32);
	port(
		InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
		SelectionAndOr: in std_logic;
		OutputSlt, OutputAndOr: out std_logic_vector(VectorLength-1 downto 0)
   );
end component;

signal Output_s, OutputArithmetic, OutputSlt, OutputAndOr: std_logic_vector(VectorLength-1 downto 0);

begin

AddSub: Arithmetic generic map (VectorLength) port map(InputA, InputB, Operation(2), OutputArithmetic);
AndOrSlt: Logical generic map (VectorLength) port map(InputA, InputB, Operation(0), OutputSlt, OutputAndOr);

Output_s <= OutputSlt when Operation = "111" else
			OutputAndOr when Operation(1) = '0' else
			OutputArithmetic;

Zero <= '1' when to_integer(unsigned(Output_s)) = 0 else '0';
Output <= Output_s;

end architecture;