`timescale 1ns / 1ps

module ExtensorDeSigno_test #(
    parameter BUS_WIDTH = 16
)();

    reg [BUS_WIDTH-1:0] i_dato;
    wire [31:0] o_dato;

    ExtensorDeSigno #16 extensor(i_dato, o_dato);
    
    initial begin

        i_dato = 28'h00007FFF;
        #5;

        i_dato = 28'h0000F000;  
        #5;

        i_dato = 28'hFFFFFFF;
        #5;
    
    end
endmodule
