`timescale 1ns / 1ps

module Sumador(
    input wire [31:0] i_A,
    input wire [31:0] i_B,
    output wire [31:0] o_C
    );
    
    assign o_C = $signed(i_A) + $signed(i_B);
endmodule
