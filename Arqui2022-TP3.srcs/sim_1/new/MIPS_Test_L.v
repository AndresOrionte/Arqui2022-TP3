`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2023 12:48:54
// Design Name: 
// Module Name: MIPS_Test_L
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


module MIPS_Test_L();

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
    
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    
    // 00 OR R10 R0 0070
    // 04 OR R11 R0 R10
    // 08 BEQ R10 R11 +1
    // 0C HALT
    // 10 SW R11 (R0+112)
    // 14 LW R12 (R11)
    // 18 SUB R12 R12 68
    // 1C JALR guardoen(R11) saltoa(R12)
    
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
        send_byte = 8;
        #1
        send_start = 0;
        
        // 00 OR R10 R0 0070
        #369
        send_start = 1;
        send_byte = 8'b01010000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00001010;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01110000;
        #1
        send_start = 0;
        
        // 04 OR R11 R0 R10
        #369
        send_start = 1;
        send_byte = 8'b00010000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00001010;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01011000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        // 08 BEQ R10 R11 +1
        #369
        send_start = 1;
        send_byte = 8'b11010001;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01001011;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000001;
        #1
        send_start = 0;
        
        // 0C HALT
        #369
        send_start = 1;
        send_byte = 8'b11111100;
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
        
        // 10 SW R11 (R0+112)
        #369
        send_start = 1;
        send_byte = 8'b10110000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00001011;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01110000;
        #1
        send_start = 0;
        
        // 14 LW R12 (R11+0)
        #369
        send_start = 1;
        send_byte = 8'b10010001;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01101100;
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
        
        // 18 SUB R12 R12 h68
        #369
        send_start = 1;
        send_byte = 8'b01001001;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10001100;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01101000;
        #1
        send_start = 0;
        
        // 1C JALR R11 R12
        #369
        send_start = 1;
        send_byte = 8'b11001101;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b10000000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b01011000;
        #1
        send_start = 0;
        
        #369
        send_start = 1;
        send_byte = 8'b00000000;
        #1
        send_start = 0;
        /*
        // PRUEBA MODO CONTINUO
        #369
        send_start = 1;
        send_byte = 8'h43;
        #1
        send_start = 0;
        */
        
        
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

    
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule
