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

entity Execution is
	port(
		-- control inputs
		DvC, ULAFonte: in std_logic;
		ULAOp: in std_logic_vector(1 downto 0);
		-- data inputs
		Reg1, Reg2: in std_logic_vector(31 downto 0);
		Cte: in std_logic_vector(15 downto 0);
		-- control outputs
		FontePC: out std_logic;
		-- data outputs
		Result: out std_logic_vector(31 downto 0)
	);
end entity;

architecture HierarchicalStructuralModel of Execution is
	
	signal s_mux, s_ula, s_ext : std_logic_vector (31 downto 0);
	signal s_zero : std_logic;
	signal s_op : std_logic_vector(2 downto 0);
	
	component ula is
		generic(width: positive := 14);
		port(
			a, b: in std_logic_vector(width-1 downto 0);
			op: in std_logic_vector(2 downto 0);  --000:AND , 001:OR , 010:ADD, 110:SUB, 111:SLT
			zero: out std_logic;
			res: out std_logic_vector(width-1 downto 0)
		);
	end component;
	
	component operacaoULA is
		port(
			ULAOp: in std_logic_vector(1 downto 0);
			Funct: in std_logic_vector(5 downto 0);
			op: out std_logic_vector(2 downto 0)
		);
	end component;
	
	component signalExtend is
	generic(	finalWidth:  integer := 12;
				actualWidth: integer := 6);
	port(
			input:  in  std_logic_vector(actualWidth-1 downto 0);
			output: out std_logic_vector(finalWidth-1 downto 0)
		);
	end component;
	
	component mux2x1nbits is
		generic(width: integer := 4);
		port(
			inpt0: in std_logic_vector(width-1 downto 0);
			inpt1: in std_logic_vector(width-1 downto 0);
			sel: in std_logic;
			outp: out std_logic_vector(width-1 downto 0)
		);
	end component;
begin
		mux: mux2x1nbits generic map(32) port map (
			inpt0 => Reg2,
			inpt1 => s_ext,
			sel => ULAFonte,
			outp => s_mux
		);
		
		opUla: operacaoULA port map (
			ULAOp => ULAOp,
			Funct => Cte(5 downto 0),
			op => s_op
		);
		
		alu: ula generic map (32) port map (
			a => s_mux,
			b => Reg1,
			op => s_op,
			zero => s_zero,
			res => s_ula
		);
		
		extSignal: signalExtend generic map (32, 16) port map (
			input => Cte (15 downto 0),
			output => s_ext
		);
		
		Result <= s_ula;
		FontePC <= (Dvc and s_zero);
		
end architecture;