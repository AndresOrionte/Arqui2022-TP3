`timescale 1ns / 1ps

module ExtensorDeSigno_test();

    reg [15:0] i_dato;
    wire [31:0] o_dato;

    ExtensorDeSigno extensor(i_dato, o_dato);
    
    initial begin
    
    i_dato = 16'h8000;
    #5
    
    i_dato = 16'h00FF;
    #5
    
    i_dato = 16'hFFFF;
    
    end
endmodule
