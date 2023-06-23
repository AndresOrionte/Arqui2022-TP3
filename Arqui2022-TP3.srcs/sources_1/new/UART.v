`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:04:31
// Design Name: 
// Module Name: UART
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

module UART#(
    parameter NCFT = 651
)
(
    input wire i_clk,
    input wire i_reset,
    input wire i_rx,
    input wire i_send_start,
    input wire [7:0] i_send_byte,
    output wire o_tx,
    output wire o_eor,
    output wire o_sending,
    output wire [7:0] o_recept_byte,
    output wire o_err
);
    
    wire tick;
    
    UART_BRG #(.NCFT(NCFT)) BRG0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_tick(tick)
    ); 
    
    UART_Receiver R0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_tick(tick),
        .i_rx(i_rx),
        .o_word(o_recept_byte),
        .o_eor(o_eor),
        .o_err(o_err)
    );
    
    UART_Transmitter T0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_tick(tick),
        .i_start(i_send_start),
        .i_word(i_send_byte),
        .o_tx(o_tx),
        .o_sending(o_sending)
    );   
    
endmodule