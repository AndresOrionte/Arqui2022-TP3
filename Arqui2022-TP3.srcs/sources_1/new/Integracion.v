`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 08:14:24
// Design Name: 
// Module Name: Integracion
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


module Integracion#(
    parameter NCFT = 162
    )(
    
    input wire i_clk,
    input wire i_reset,
    
    input wire i_rx,
    
    output wire o_tx,
    
    output wire [3:0] o_state,
    output wire o_locked
    );
    
    wire clk_25;
    
    clk_wiz_0 clk_wiz
   (
    // Clock out ports
    .clk_25(clk_25),            // output clk_25
    // Status and control signals
    .reset(i_reset),            // input reset
    .locked(o_locked),          // output locked
   // Clock in ports
    .clk_in1(i_clk)); 
    
    MIPS #(.NCFT(NCFT)) M_0(clk_25, (i_reset | !o_locked), i_rx, o_tx, o_state);
    
endmodule
