`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2023 20:12:46
// Design Name: 
// Module Name: MIPS_Test
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


module MIPS_Test();

    reg i_clk, i_reset;
    
    wire i_rx, o_tx;
    
    wire tick, sending;
    reg send_start;
    reg [7:0] send_byte;
    
    wire [7:0] word;
    wire eor, err;
    
    wire [3:0] state;

    
    MIPS #2 M_0(i_clk, i_reset, i_rx, o_tx, state);
    
    UART_BRG #2 B0(i_clk, i_reset, tick);
    
    UART_Transmitter T0(i_clk, i_reset, tick, send_start, send_byte, i_rx, sending);
    
    UART_Receiver R0(i_clk, i_reset, tick, o_tx, word, eor, err);
    
    
    // LUI R4 170
    // LUI R5 5
    // ADD R6 R4 R5
    // ADD R6 R4 R6
    // ADD R6 R5 R6
    // SW (R0+4) R6
    // HALT
    // Comprueba a la perfeccion todos los casos de funcionamiento de la unidad de cortocircuitos
    // Funcionando todo en orden!
    /*
    initial begin
        
        i_clk = 1;
        i_reset = 1;
        send_start = 0;
        send_byte = 0;
        
        #10
        i_reset = 0;
        
        #5 //P
        send_start = 1;
        send_byte = 8'h50;
        #1
        send_start = 0;
        
        #369 //Cantidad instrucciones
        send_start = 1;
        send_byte = 7;
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
        
        // ADD R6 R5 R6
        #369
        send_start = 1;
        send_byte = 8'b00000100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10100110;
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
        
        // SW (R0+4) R6
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

        // PRUEBA MODO STEP
        #369
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
        #99999
        send_start = 1;
        send_byte = 8'h53;
        #1
        send_start = 0;
        
    end
    */
    
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule

