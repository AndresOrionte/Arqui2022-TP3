`timescale 1ns / 1ps

module Sumador_test();

    reg [31:0] i_A;
    reg [31:0] i_B;
    wire [31:0] o_C;
    
    Sumador sumador(i_A, i_B, o_C);
    
    initial begin
    
    i_A = 32'h00000000;
    i_B = 32'h00000004;
    #5
    
    i_A = 32'h0000FFF0;
    #5
    
    i_A = 32'hFFFFFFFF;
    
    end

endmodule
