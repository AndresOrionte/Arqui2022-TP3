`timescale 1ns / 1ns
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

    reg i_clk, i_reset;
    
    wire i_rx, o_tx;
    
    wire tick, sending;
    reg send_start;
    reg [7:0] send_byte;
    
    wire [7:0] word;
    wire eor, err;
    
    wire [3:0] state;
    wire locked;
    
    Integracion #162 Int_0(i_clk, i_reset, i_rx, o_tx, state, locked);
    
    UART_BRG #651 B0(i_clk, i_reset, tick);
    
    UART_Transmitter T0(i_clk, i_reset, tick, send_start, send_byte, i_rx, sending);
    
    UART_Receiver R0(i_clk, i_reset, tick, o_tx, word, eor, err);
    

    initial begin
        
        i_clk = 1;
        i_reset = 1;
        send_start = 0;
        send_byte = 0;
        
        #10
        i_reset = 0;
        
        #250
        i_reset = 1;
        #1
        i_reset = 0;
        
        #5 //P
        send_start = 1;
        send_byte = 8'h50;
        #1
        send_start = 0;
        
        #1999 //Cantidad instrucciones
        send_start = 1;
        send_byte = 6;
        #1
        send_start = 0;
        
        // LUI R4 170
        #369
        send_start = 1;
        send_byte = 8'b01011100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10101010;
        #1
        send_start = 0;
        
        // LUI R5 5
        #369
        send_start = 1;
        send_byte = 8'b01011100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000101;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000101;
        #1
        send_start = 0;
        
        // ADD R6 R4 R5
        #369
        send_start = 1;
        send_byte = 8'b00000100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10000101;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00110000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        // ADD R6 R4 R6
        #369
        send_start = 1;
        send_byte = 8'b00000100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10000110;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00110000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        // SW
        #369
        send_start = 1;
        send_byte = 8'b10110000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000110;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000100;
        #1
        send_start = 0;
        
        // HALT
        #369
        send_start = 1;
        send_byte = 8'b11111111;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        // PRUEBA MODO CONTINUO
        
        #369
        send_start = 1;
        send_byte = 8'h43;
        #1
        send_start = 0;
    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule
