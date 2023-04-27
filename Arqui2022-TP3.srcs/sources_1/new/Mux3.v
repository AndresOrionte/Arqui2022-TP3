`timescale 1ns / 1ps

module Mux3(
    input wire [1:0] i_sel,
    input wire [31:0] i_dato_0,
    input wire [31:0] i_dato_1,
    input wire [31:0] i_dato_2,
        
    output reg [31:0] o_dato  
    );

    // No lleva clock
    always @(*) begin
        case (i_sel)
            2'b00: o_dato = i_dato_0;
            2'b01: o_dato = i_dato_1;
            2'b10: o_dato = i_dato_2;

        default: o_dato = i_dato_0;
     endcase
end
   
endmodule
