`timescale 1ns/1ns

module Mux3_test();

    reg [1:0] i_sel;
    reg [31:0] i_dato_1;
    reg [31:0] i_dato_2;
    reg [31:0] i_dato_3;
    wire [31:0] o_dato;

    Mux3 mux3( i_sel, i_dato_1, i_dato_2, i_dato_3, o_dato);

    initial begin
        // Test Case 1
        i_sel = 0;
        i_dato_1 = 8'h01;
        i_dato_2 = 8'h02;
        i_dato_3 = 8'h03;
        #5;
        
        // Test Case 2
        i_sel = 1;
        #5;
        
        // Test Case 3
        i_sel = 2;
    end

endmodule
