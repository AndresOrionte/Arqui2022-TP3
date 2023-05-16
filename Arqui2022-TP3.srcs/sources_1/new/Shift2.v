`timescale 1ns / 1ps

module Shift2 #(
    parameter BUS_WIDTH = 16
    )(
    input wire [BUS_WIDTH-1:0] i_dato,
    output wire [31:0] o_dato
    );
    
    assign o_dato = i_dato << 2;
    
endmodule
