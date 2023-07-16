`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2023 17:15:27
// Design Name: 
// Module Name: UnidadDeRegistros_Test
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


module UnidadDeRegistros_Test();

    reg i_clk;
    reg i_reset;
    reg [4:0] i_reg_lec_1;
    reg [4:0] i_reg_lec_2;
    reg [4:0] i_reg_esc;
    reg [31:0] i_dato_esc;
    reg i_flag_reg_write;
    reg i_block_write;
    
    wire [31:0] o_dato_1;
    wire [31:0] o_dato_2;
    
    UnidadDeRegistros Un0(i_clk, i_reset, i_reg_lec_1, i_reg_lec_2, i_reg_esc, i_dato_esc, i_flag_reg_write, i_block_write, o_dato_1, o_dato_2);
    
    initial begin
        
        i_clk = 1;
        i_reg_lec_1 = 5'b00000;
        i_reg_lec_2 = 5'b00000;
        i_reg_esc = 5'b00000;
        i_dato_esc = 32'b0000000;
        i_flag_reg_write = 0;
        i_block_write = 0;
        
        // Primero hacemos un reset
        i_reset = 1;
        
        #3
        i_reset = 0;
        
        // Comprobamos la salida de un par de posiciones
        #1
        i_reg_lec_1 = 5'b00010;
        i_reg_lec_2 = 5'b00100;
        
        //Comenzamos a grabar algunos datos
        #1
        i_flag_reg_write = 1;
        i_reg_esc = 5'b11111;
        i_dato_esc = 32'hAAAAAAAA;
        
        #1
        i_reg_esc = 5'b00011;
        i_dato_esc = 32'h99999999;
        
        #1
        i_reg_esc = 5'b00100;
        i_dato_esc = 32'h88888888;
        
        #1
        i_flag_reg_write = 0;
        
        //Comprobamos si se puede acceder al mismo registro simultaneamente
        #1
        i_reg_lec_1 = 5'b11111;
        i_reg_lec_2 = 5'b11111;
        
        #1
        i_reg_lec_1 = 5'b00000;
        i_reg_lec_2 = 5'b00011;
        
        // Intentamos escribir la posicion 0
        #1 
        i_flag_reg_write = 1;
        i_reg_esc = 5'b00000;
        i_dato_esc = 32'hAAAAAAAA;
        
        // Leemos la posicion 0
        #1
        i_flag_reg_write = 0;
        i_reg_lec_1 = 5'b00000;
        
    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end

endmodule
