`timescale 1ns/1ns

module Mux2_test();

    reg i_sel;
    reg [31:0] i_dato_1;
    reg [31:0] i_dato_2;
    wire [31:0] o_dato;

    Mux2 mux2( i_sel, i_dato_1, i_dato_2, o_dato);

    initial begin
        // Test Case 1
        i_sel = 0;
        i_dato_1 = 32'h0001;
        i_dato_2 = 32'h0002;
        #5;
        
        // Test Case 2
        i_sel = 1;
    end

endmodule
