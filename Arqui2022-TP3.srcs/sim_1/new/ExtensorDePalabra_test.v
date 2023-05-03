`timescale 1ns / 1ps

module ExtensorDePalabra_test();

    reg i_dato;
    wire [31:0] o_dato;

    ExtensorDePalabra extensorpalabra(i_dato, o_dato);
    
    initial begin
    
    i_dato = 1'b0;
    #5
    
    i_dato = 1'b1;
    
    end
endmodule