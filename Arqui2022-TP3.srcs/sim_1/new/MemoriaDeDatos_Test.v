`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.05.2023 21:30:10
// Design Name: 
// Module Name: MemoriaDeDatos_Test
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


module MemoriaDeDatos_Test();

    reg i_clk;
    reg i_reset;
    reg [31:0] i_direccion;
    reg [31:0] i_escritura;
    reg i_mem_write;
    reg [3:0] i_mem_width;
    
    wire [31:0] o_dato;
    wire o_error_flag;        

    MemoriaDeDatos Mem1(i_clk, i_reset, i_direccion, i_escritura, i_mem_write, i_mem_width, o_dato, o_error_flag);
    
    
    initial begin
    
        i_clk = 1;
        i_direccion = 32'h00000000;
        i_escritura = 32'h00000000;
        i_mem_write = 1'b0;
        i_mem_width = 4'b1001;
        // Primero hacemos un reset
        i_reset = 1;
        
        #3
        i_reset = 0;
        
        // Comprobamos 3 direcciones aleatorias para ver que comienzen en 0
        #1
        i_direccion = 32'h00000008;
        
        #1
        i_direccion = 32'h00000014;
        
        #1
        i_direccion = 32'h0000002C;
        
        //Chequeamos todos los tipos de escritura para byte y generamos datos para probar luego las lecturas
        #5
        i_mem_write = 1'b1;         // Byte comenzado en 1
        i_mem_width = 4'b1001;
        i_direccion = 32'h00000010;
        i_escritura = 32'h000000F3;
        
        #1
        i_mem_write = 1'b1;         // Byte comenzado en 0
        i_mem_width = 4'b1001;
        i_direccion = 32'h00000014;
        i_escritura = 32'h00000073;
        
        #1
        i_mem_write = 1'b1;         // Byte que tiene datos hasta halfword
        i_mem_width = 4'b1001;
        i_direccion = 32'h00000018;
        i_escritura = 32'h0000A0FF;
        
        #1
        i_mem_write = 1'b1;         // Byte que tiene datos para una word completa
        i_mem_width = 4'b1001;
        i_direccion = 32'h0000001C;
        i_escritura = 32'hA000A0FF;
        
        //Chequeamos todos los tipos de escritura para halfword
        #5
        i_mem_write = 1'b1;         // Halfword comenzado en 1
        i_mem_width = 4'b1010;
        i_direccion = 32'h00000020;
        i_escritura = 32'h0000F300;
        
        #1
        i_mem_write = 1'b1;         // Halfword comenzado en 0
        i_mem_width = 4'b1010;
        i_direccion = 32'h00000024;
        i_escritura = 32'h00007300;
        
        #1
        i_mem_write = 1'b1;         // Halfword con datos para una word completa
        i_mem_width = 4'b1010;
        i_direccion = 32'h00000028;
        i_escritura = 32'hAA007300;
        
        //Chequeamos todos los tipos de escritura para word
        #5
        i_mem_write = 1'b1;         // Word solo guarda con signo aunque tecnicamente no hace ninguna diferencia
        i_mem_width = 4'b1100;
        i_direccion = 32'h00000030;
        i_escritura = 32'hF3000000;
        
        //Chequeamos todos los tipos de lectura para byte
        #5
        i_mem_write = 1'b0;         //Leemos unsigned un byte comenzado en 1, no deberia rellenar. 
        i_mem_width = 4'b0001;      //Esperado: 000000F3
        i_direccion = 32'h0000010;
        
        #1
        i_mem_write = 1'b0;         //Leemos unsigned un byte comenzado en 0, no deberia rellenar. 
        i_mem_width = 4'b0001;      //Esperado: 00000073
        i_direccion = 32'h0000014;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un byte comenzado en 1, deberia rellenar. 
        i_mem_width = 4'b1001;      //Esperado: FFFFFFF3
        i_direccion = 32'h0000010;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un byte comenzado en 0, no deberia rellenar. 
        i_mem_width = 4'b1001;      //Esperado: 00000073
        i_direccion = 32'h0000014;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un byte de una posicion que contiene mas valores y cuyo byte esta comenzado en 0, no deberia rellenar.
        i_mem_width = 4'b1001;      // Esperado: 00000000
        i_direccion = 32'h0000028;
        
        //Chequeamos todos los tipos de lectura para halfword
        #5
        i_mem_write = 1'b0;         //Leemos unsigned un halfword comenzado en 1, no deberia rellenar.
        i_mem_width = 4'b0010;      // Esperado: 0000F300
        i_direccion = 32'h0000020;
        
        #1
        i_mem_write = 1'b0;         //Leemos unsigned un halfword comenzado en 0, no deberia rellenar.
        i_mem_width = 4'b0010;      // Esperado: 00007300
        i_direccion = 32'h0000024;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un halfword comenzado en 1, deberia rellenar.
        i_mem_width = 4'b1010;      // Esperado: FFFFF300
        i_direccion = 32'h0000020;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un halfword comenzado en 0, no deberia rellenar.
        i_mem_width = 4'b1010;      // Esperado: 00007300
        i_direccion = 32'h0000024;
        
        #1
        i_mem_write = 1'b0;         //Leemos signed un halfword de una posicion que contiene mas valores y cuyo byte esta comenzado en 0, no deberia rellenar.
        i_mem_width = 4'b1010;      // Esperado: 00000000
        i_direccion = 32'h0000030;
        
        //Chequeamos todos los tipos de lectura para word
        #5
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: 000000F3
        i_direccion = 32'h0000010;
        
        #1
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: 0000F300
        i_direccion = 32'h0000020;
        
        #1
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: F3000000
        i_direccion = 32'h0000030;
        
        //Comprobaciones de los store de byte y halfword que contenian datos mas extensos de los que se guardaban
        #1
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: 000000FF
        i_direccion = 32'h0000018;
        #1
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: 000000FF
        i_direccion = 32'h000001C;
        #1
        i_mem_write = 1'b0;         //Siempre debemos obtener el contenido tal cual
        i_mem_width = 4'b1100;      // Esperado: 00007300
        i_direccion = 32'h0000028;

        
    
    end

    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end

endmodule
