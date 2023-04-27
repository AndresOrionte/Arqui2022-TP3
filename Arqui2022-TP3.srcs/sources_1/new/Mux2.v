`timescale 1ns / 1ps

module Mux2(
    input wire i_sel,
    input wire [31:0] i_dato_0,
    input wire [31:0] i_dato_1,
        
    output reg [31:0] o_dato  
    );

    // No lleva clock
    always @(*) begin
        case (i_sel)
            0: o_dato = i_dato_0;
            1: o_dato = i_dato_1;

        default: o_dato = i_dato_0;
     endcase
end
   
endmodule
