`timescale 1ns / 1ps

module clkdiv_pulse(
	input clk,
	input rst,
	input Sel_CLK,
	input pulse,
	output CK,
	output reg [31:0] clkdiv
);
	 
	always @(posedge clk or posedge rst) begin
		if(rst) clkdiv <= 0;
		else clkdiv <= clkdiv + 1'b1;
	end
	
	assign CK = (Sel_CLK)? ~pulse : clkdiv[26];

endmodule
