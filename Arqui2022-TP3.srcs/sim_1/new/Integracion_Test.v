`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 22:26:54
// Design Name: 
// Module Name: Integracion_Test
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


module Integracion_Test();

    reg i_clk, i_reset, i_eor, i_err, i_sending_flag;
    reg [7:0] i_recept_byte;
    
    wire o_send_start;
    wire [7:0] o_send_byte;
    
    Integracion Int_0(i_clk, i_reset, i_eor, i_err, i_recept_byte, i_sending_flag, o_send_start, o_send_byte);

    initial begin
        
        i_clk = 1;
        i_reset = 1;
        
        i_eor = 0;
        i_err = 0;
        i_sending_flag = 0;
        i_recept_byte = 0;
        
        #10
        i_reset = 0;
        
        // PRUEBA RESET
        
        #10 //R
        i_eor = 1;
        i_recept_byte = 'h52;
        #1
        i_eor = 0;
        
        // PRUEBA PROGRAMACION
        
        #9 //P
        i_eor = 1;
        i_recept_byte = 'h50;
        #1
        i_eor = 0;
        
        #9 // Cantidad de instrucciones
        i_eor = 1;
        i_recept_byte = 6;
        #1
        i_eor = 0;
        
        // LUI R4 170
        #9 
        i_eor = 1;
        i_recept_byte = 8'b01011100;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000100;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b10101010;
        #1
        i_eor = 0;
        
        // LUI R5 5
        #9 
        i_eor = 1;
        i_recept_byte = 8'b01011100;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000101;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000101;
        #1
        i_eor = 0;
        
        // ADD R6 R4 R5
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000100;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b10000101;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00110000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000000;
        #1
        i_eor = 0;
        
        // ADD R6 R4 R6
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000100;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b10000110;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00110000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000000;
        #1
        i_eor = 0;
        
        // SW 
        #9 
        i_eor = 1;
        i_recept_byte = 8'b10110000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000110;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000000;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b00000100;
        #1
        i_eor = 0;
        
        // HALT
        #9 
        i_eor = 1;
        i_recept_byte = 8'b11111111;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b11111111;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b11111111;
        #1
        i_eor = 0;
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'b11111111;
        #1
        i_eor = 0;
        
        // PRUEBA MODO CONTINUO
        
        #9 
        i_eor = 1;
        i_recept_byte = 8'h43;
        #1
        i_eor = 0;
        
        // PRUEBA MODO STEP
        
        #399
        i_eor = 1;
        i_recept_byte = 8'h53;
        #1
        i_eor = 0;
        
        #399
        i_eor = 1;
        i_recept_byte = 8'h53;
        #1
        i_eor = 0;
        
        #399
        i_eor = 1;
        i_recept_byte = 8'h53;
        #1
        i_eor = 0;
        
        #399
        i_eor = 1;
        i_recept_byte = 8'h53;
        #1
        i_eor = 0;

    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule
