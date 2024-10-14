module InstructionMemory (
	input [2:0] pc,						// Program counter from IFStage
	output reg [15:0] instruction		// Instruction selected from PC
);
	reg [15:0] memory [0:7]; 			// 8 registers, 16 bit storage
	
	initial begin
		memory[0] = 16'b0000_0000_0000_0000;   // NOP
		
		memory[1] = 16'b0011_0000_0000_0010;   // LOAD R0 IMMEDIATE VALUE 2  
		memory[2] = 16'b0011_0001_0000_0010;   // LOAD R1 IMMEDIATE VALUE 4  
		
		memory[2] = 16'b0001_0000_0001_0010;   // ADD R0 R1 STORE TO R2
		memory[3] = 16'b0010_0010_0001_0011;   // SUB R2 R1 STORE TO R3	  						
	 	  				
		memory[4] = 16'b0100_0011_0000_0111;   // STORE R3 TO MEMORY 7  	  				
		
		memory[5] = 16'b0101_0100_0000_0111;   // LOAD R4 FROM MEMORY 7   				
		memory[6] = 16'b0111_0001_0000_0100;   // STORE IMMEDIATE VALUE 1 TO MEMORY 4  	  	
		
	end
	
	always @(*) begin
		instruction = memory[pc];
	end
	
endmodule