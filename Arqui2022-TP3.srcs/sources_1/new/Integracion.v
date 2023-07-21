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
    parameter NCFT = 260
    )(
    
    input wire i_clk,
    input wire i_reset,
    
    input wire i_rx,
    
    output wire o_tx,
    
    output wire [3:0] o_state,
    output wire o_locked
    );
    
    wire clk_out;
    
    clock_wizard_MIPS clock_machine
   (
    // Clock out ports
    .clk_out(clk_out),     // output clk_out
    // Status and control signals
    .reset(i_reset), // input reset
    .locked(o_locked),       // output locked
   // Clock in ports
    .clk_in1(i_clk));      // input clk_in1
    
    MIPS #(.NCFT(NCFT)) M_0(clk_out, (i_reset | !o_locked), i_rx, o_tx, o_state);
    
    // NCFT
    // 25MHz = 162
    // 40MHz = 260
    
endmodule
