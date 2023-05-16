`timescale 1ns / 1ps

module Shift2_test();

    reg [15:0] i_dato_0;
    wire [31:0] o_dato_0;
    
    reg [25:0] i_dato_1;
    wire [31:0] o_dato_1;

    Shift2 #16 shift_0(i_dato_0, o_dato_0);
    Shift2 #26 shift_1(i_dato_1, o_dato_1);
    
    initial begin
    
    i_dato_0 = 16'h000F;
    i_dato_1 = 26'h0000FFF;
    #5
    
    i_dato_0 = 16'hFFFF;
    i_dato_1 = 26'hFFFFFFF;
    #5
    
    i_dato_0 = 16'h0000;
    i_dato_1 = 26'h0000000;
    
    end
endmodule
