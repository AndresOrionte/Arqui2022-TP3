`timescale 1ns / 1ps

module ExtensorDePalabra_test();

    reg [31:0]i_dato_0;
    wire [31:0] o_dato_0;
    
    reg [31:0]i_dato_1;
    wire [31:0] o_dato_1;

    ExtensorDePalabra #(1) extensorpalabra_0 (i_dato_0, o_dato_0);
    ExtensorDePalabra #(16) extensorpalabra_1 (i_dato_1, o_dato_1);
    
    initial begin
    
    i_dato_0 = 1'b0;
    i_dato_1 = 16'h0000;
    
    #5
    i_dato_0 = 1'b1;
    i_dato_1 = 16'hFFFF;
    
    #5
    i_dato_0 = 2'b11;
    i_dato_1 = 20'hFFFFF;
    
    end
    
endmodule