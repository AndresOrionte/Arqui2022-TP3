`timescale 1ns / 1ps

module ExtensorDeSigno_test #(
    parameter BUS_WIDTH = 28
)();

    reg [BUS_WIDTH-1:0] i_dato;
    wire [31:0] o_dato;

    ExtensorDeSigno #(.BUS_WIDTH(BUS_WIDTH)) extensor(i_dato, o_dato);
    
    initial begin

        i_dato = 28'hFFFF00F;
        #5;

        i_dato = 28'h0000FFF;  
        #5;

        i_dato = 28'hFFFFFFF;
        #5;
    
    end
endmodule
