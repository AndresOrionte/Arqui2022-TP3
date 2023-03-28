`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2023 18:53:30
// Design Name: 
// Module Name: MemoriaDeInstrucciones_Test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MemoriaDeInstrucciones_Test();

    reg i_clk;
    reg i_reset;
    reg [31:0] i_direccion;
    reg [31:0] i_escritura;
    reg i_flag_escritura;
    
    wire [31:0] o_instruccion;
    wire o_error_flag;        

    MemoriaDeInstrucciones Mem0(i_clk, i_reset, i_direccion, i_escritura, i_flag_escritura, o_instruccion, o_flag_error);
    
    initial begin

        i_clk = 0;
        i_direccion = 32'h0000;
        i_escritura = 32'h0000;
        i_flag_escritura = 1'b0;
        // Primero hacemos un reset
        i_reset = 1;
        
        #3
        i_reset = 0;
        
        // Comprobamos 3 direcciones aleatorias para ver que comienzen en 0
        #1
        i_direccion = 32'h0002;
        
        #1
        i_direccion = 32'h000F;
        
        #1
        i_direccion = 32'h001F;
        
        // Escribimos 3 direcciones
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h0003;
        i_escritura = 32'h1111;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h0005;
        i_escritura = 32'h2222;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h0007;
        i_escritura = 32'h3333;
        
        // Chequeamos los datos de manera alternada
        
        #1
        i_flag_escritura = 1'b0;
        i_direccion = 32'h0002;

        #1
        i_direccion = 32'h0003;
        
        #1
        i_direccion = 32'h0004;
        
        #1
        i_direccion = 32'h0005;
        
        #1
        i_direccion = 32'h0006;
        
        #1
        i_direccion = 32'h0007;
        
        #1
        i_direccion = 32'h0008;
        
        // Check del limite de 64 posiciones
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h0109;
        i_escritura = 32'h4444;
        
        #1
        i_flag_escritura = 1'b0;
        i_direccion = 32'h0009;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'hFFFF;
        i_escritura = 32'h5555;
        
        #1
        i_flag_escritura = 1'b0;
        
        #1
        i_direccion = 32'h003F;
        
    end
    
        // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end
    
endmodule
