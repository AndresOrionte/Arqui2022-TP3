`timescale 1ns / 1ps

module ExtensorDeSigno #(
    parameter BUS_WIDTH = 16
)(
    input wire [BUS_WIDTH-1:0] i_dato,
    output wire [31:0] o_dato
    );
    
    assign o_dato = (i_dato[BUS_WIDTH-1] == 1) ? {{BUS_WIDTH{1'b1}}, i_dato} : {{BUS_WIDTH{1'b0}}, i_dato};
    
endmodule