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

    MemoriaDeInstrucciones Mem0(i_clk, i_reset, i_direccion, i_escritura, i_flag_escritura, o_instruccion);
    
    initial begin

        i_clk = 0;
        i_direccion = 32'h00000000;
        i_escritura = 32'h00000000;
        i_flag_escritura = 1'b0;
        // Primero hacemos un reset
        i_reset = 1;
        
        #3
        i_reset = 0;
        
        // Comprobamos 3 direcciones aleatorias para ver que comienzen en 0
        #1
        i_direccion = 32'h00000000;
        
        #1
        i_direccion = 32'h00000004;
        
        #1
        i_direccion = 32'h0000000C;
        
        // Escribimos 3 direcciones
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h00000004;
        i_escritura = 32'h00111111;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h00000000C;
        i_escritura = 32'h00222222;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h0000014;
        i_escritura = 32'h00333333;
        
        // Chequeamos los datos de manera alternada
        
        #1
        i_flag_escritura = 1'b0;
        i_direccion = 32'h00000000;

        #1
        i_direccion = 32'h00000004;
        
        #1
        i_direccion = 32'h00000008;
        
        #1
        i_direccion = 32'h0000000C;
        
        #1
        i_direccion = 32'h00000010;
        
        #1
        i_direccion = 32'h00000014;
        
        #1
        i_direccion = 32'h00000018;
        
        #1
        i_direccion = 32'h0000001C;
        
        // Check del limite de 256 posiciones
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h000000FC;
        i_escritura = 32'h00444444;
        
        #1
        i_flag_escritura = 1'b0;
        i_direccion = 32'h000001FC;
        
        #1
        i_flag_escritura = 1'b1;
        i_direccion = 32'h00FFFF00;
        i_escritura = 32'h00555555;
        
        #1
        i_flag_escritura = 1'b0;
        
        #1
        i_direccion = 32'h00003F00;
        
        // Check de instataniedad de los bucles for como descriptores de hardware
        
        #1
        i_reset = 1;
        
        #1
        i_reset = 0;
        
        #1
        i_direccion = 32'h00000000;

        #1
        i_direccion = 32'h00000004;
        
        #1
        i_direccion = 32'h00000008;
        
        #1
        i_direccion = 32'h0000000C;
        
        #1
        i_direccion = 32'h00000010;
        
        #1
        i_direccion = 32'h00000014;
        
        #1
        i_direccion = 32'h00000018;
        
    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end
    
endmodule
