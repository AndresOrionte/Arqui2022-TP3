`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:04:31
// Design Name: 
// Module Name: UART_ParityGen
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

module UART_ParityGen#(
    parameter N_Bits = 8
)
(
    input wire [N_Bits-1 : 0] i_word,
    output wire o_pbit
);
    
    wire [N_Bits-3 : 0] x;
    
    assign x[0] = i_word[0] ^ i_word[1];
    
    genvar i;
    generate
        for(i=1; i<=(N_Bits-3); i=i+1) begin
            assign x[i] = x[i-1] ^ i_word[i+1];
        end
    endgenerate
    
    assign o_pbit = x[N_Bits-3] ^ i_word[N_Bits-1];

    
endmodule