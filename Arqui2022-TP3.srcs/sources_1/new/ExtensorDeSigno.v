`timescale 1ns / 1ps

module ExtensorDeSigno(
    input wire [15:0] i_dato,
    output wire [31:0] o_dato
    );
    
    assign o_dato = (i_dato[15] == 1) ? {16'b1111111111111111, i_dato} : {16'b0000000000000000, i_dato};
    
endmodule
