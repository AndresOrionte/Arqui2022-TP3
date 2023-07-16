`timescale 1ns / 1ps

module LatchIFID_test();

    reg i_clk;
    reg i_reset;
    reg i_bloqueo;
    reg [31:0] i_pc_p4;
    reg [31:0] i_instruccion;
    wire [31:0] o_pc_p4;
    wire [31:0] o_instruccion;
    
    LatchIFID latch1(i_clk, i_reset, i_bloqueo, i_pc_p4, i_instruccion, o_pc_p4, o_instruccion);
    
    initial begin
        
        // Comienzo con un bloqueo
        i_clk = 1;
        i_reset = 1;
        i_bloqueo = 1;
        
        i_pc_p4 = 0;
        i_instruccion = 0;
        
        #5
        i_reset = 0;

        // Asigno valores a la entrada
        i_instruccion = 32'h00000F0F;
        #1
        i_pc_p4 = 32'h00000004;
        #3
        i_instruccion = 32'h0000FFFF;
        #3
        
        // Desbloqueo y compruebo que funcione el latch
        i_bloqueo = 0;
        i_pc_p4 = 8;
        i_instruccion = 255;
        #1
        i_pc_p4 = 12;
        #1
        i_instruccion = 32'h00000000;
        #3
        i_instruccion = 32'hF000000F;
        #1
        
        // Vuelvo a bloquear y compruebo nuevamente
        i_bloqueo = 1;
        #1
        i_pc_p4 = 32'hFFFFFFFF;
        i_instruccion = 32'hFFFFFFFF;
    end
        
    
    // Inicializo el Clk
    always begin
        #0.5
        i_clk = ~i_clk;
    end
endmodule
