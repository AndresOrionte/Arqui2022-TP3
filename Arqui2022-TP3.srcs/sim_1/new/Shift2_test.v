`timescale 1ns / 1ps

module Shift2_test();

    reg [31:0] i_dato;
    wire [31:0] o_dato;

    Shift2 shift2(i_dato, o_dato);
    
    initial begin
    
    i_dato = 32'h0000000F;
    #5
    
    i_dato = 32'h00FFFF00;
    #5
    
    i_dato = 32'hFFFFFFFF;
    
    end
endmodule
