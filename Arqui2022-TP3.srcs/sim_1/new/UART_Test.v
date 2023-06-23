`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:22:45
// Design Name: 
// Module Name: UART_Test
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


module UART_Test();
    
    reg i_clk;
    reg i_reset;
    reg i_rx;
    reg i_send_start;
    reg [7:0] i_send_byte;
    wire o_eor;
    wire o_tx;
    wire o_sending;
    wire [7:0] o_recept_byte;
    wire o_err;
    
    UART #(.NCFT(10)) U0(
        i_clk,
        i_reset,
        i_rx,
        i_send_start,
        i_send_byte,
        o_tx,
        o_eor,
        o_sending,
        o_recept_byte,
        o_err
    );
    
    initial begin
        
        i_reset = 1;
        i_clk = 1;
        i_rx = 1;
        i_send_start = 0;
        i_send_byte = 0;
        
        #100
        i_reset = 0;
        
        //Comienzo a recibir una A y a enviar una A en el mismo momento para chequear buen funcionamiento
        #100
        i_rx = 0;
        i_send_byte = 8'h41;
        i_send_start = 1;
        #1
        i_send_byte = 0;
        i_send_start = 0;
        //0
        #159
        i_rx = 1;
        //1
        #160
        i_rx = 0;
        //2
        #160
        i_rx = 0;
        //3
        #160
        i_rx = 0;
        //4
        #160
        i_rx = 0;
        //5
        #160
        i_rx = 0;
        //6
        #160
        i_rx = 1;
        //7
        #160
        i_rx = 0;
        //parity
        #160
        i_rx = 0;
        //stop
        #160
        i_rx = 1;
     
    end
    
    always begin
        #0.5
        i_clk = ~i_clk;
    end
    
endmodule
