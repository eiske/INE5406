library ieee;
use ieee.std_logic_1164.all;

entity blocoControle is 
   port(
    	Clock, Reset: in std_logic;
    	PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: out std_logic;
    	ULAFonteB, ULAOp, FontePC: out std_logic_vector(1 downto 0);
    	opcode: in std_logic_vector(5 downto 0);
    	ControlState: out std_logic_vector(3 downto 0)
   );
end entity;

architecture FSMBehavioral of blocoControle is
	type state is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
	signal current_state, next_state: state; 
	
	constant lw    : std_logic_vector(5 downto 0) := "100011";
	constant sw    : std_logic_vector(5 downto 0) := "101011";
	constant Rtype : std_logic_vector(5 downto 0) := "000000"; 
	constant beq   : std_logic_vector(5 downto 0) := "000100";
	constant jump  : std_logic_vector(5 downto 0) := "000010";

begin

	-- Next state logic
	process(current_state, opcode)
	begin
		next_state <= current_state;
		case current_state is
			when S0 => 
				next_state <= S1;
			when S1 =>
				if opcode = Rtype then
					next_state <= S6;
				elsif (opcode = lw) or (opcode = sw) then
					next_state <= S2;
				elsif opcode = beq then
					next_state <= S8;
				elsif opcode = jump then
					next_state <= S9;
				end if;
			when S2 =>
				if opcode = lw then
					next_state <= S3;
				else 
					next_state <= S5;
				end if;
			when S3 =>
				next_state <= S4;
			when S4 => 
				next_state <= S0;
			when S5 =>
				next_state <= S0;
			when S6 =>
				next_state <= S7;
			when S7 =>
				next_state <= S0;
			when S8 =>
				next_state <= S0;
			when S9 =>
				next_state <= S0;
		end case;
	end process;

	-- State register
	process(Clock, Reset)
	begin
		if Reset = '1' then 
			current_state <= S0;
		elsif rising_edge(Clock) then
			current_state <= next_state; 
		end if;
	end process;

	-- output logic
	process(current_state)
	begin
		PCEscCond <= '0';
		PCEsc <= '0';
		IouD <= '0';
		LerMem <= '0';
		EscMem <= '0';
		MemParaReg <= '0';
		IREsc <= '0';
		RegDst <= '0';
		EscReg <= '0';
		ULAFonteA <= '0';
		ULAFonteB <= "00";
		ULAOp <= "00";
		FontePC <= "00";
		ControlState <= "1110";
		
		case current_state is
			when S0 => 
				LerMem <= '1';
				IREsc <= '1';
				ULAFonteB <= "01";
				PCEsc <= '1';
				ControlState <= "0000";
			when S1 =>
				ULAFonteB <= "11";
				ControlState <= "0001";
			when S2 =>
				ULAFonteA <= '1';
				ULAFonteB <= "10";
				ControlState <= "0010";
			when S3 =>
				LerMem <= '1';
				IouD <= '1';
				ControlState <= "0011";
			when S4 =>
				EscReg <= '1';
				MemParaReg <= '1';
				ControlState <= "0100";
			when S5 =>
				EscMem <= '1';
				IouD <= '1';
				ControlState <= "0101";
			when S6 =>
				ULAFonteA <= '1';
				ULAOp <= "10";
				ControlState <= "0110";
			when S7 =>
				RegDst <= '1';
				EscReg <= '1';
				ControlState <= "0111";
			when S8 =>
				ULAFonteA <= '1';
				ULAOp <= "01";
				PCEscCond <= '1';
				FontePC <= "01";
				ControlState <= "1000";
			when S9 =>
				PCEsc <= '1';
				FontePC <= "10";
				ControlState <= "1001";
			end case;
	end process;
end architecture;