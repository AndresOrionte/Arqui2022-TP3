`timescale 1ns / 1ps

module ExtensorDePalabra(
    input wire i_dato,
    output wire [31:0] o_dato
    );
    
    assign o_dato = {31'h00000000, i_dato};
    
endmodule