`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:04:31
// Design Name: 
// Module Name: UART_BRG
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

module UART_BRG#
(
    // NCFT = clk / (BR * 16) => 100,000,000 / (9600 * 16) = 651
    parameter NCFT = 651        // Number of clocks for tick.
)
(
    input wire i_clk,
    input wire i_reset,
    output reg o_tick
);

    reg [15 : 0]clk_counter;        // Contador de 16 bits
    wire [15 : 0]clk_counter_next;
    
    assign clk_counter_next = clk_counter + 1;
    
    always @(posedge i_clk) begin
        if(i_reset) begin    
            clk_counter = {16{1'b1}};
            o_tick = 0;
        end else begin
            if(clk_counter < (NCFT-1)) begin
                o_tick = 0;
                clk_counter = clk_counter_next;
            end else begin
                o_tick = 1;
                clk_counter = {16{1'b0}};
            end
        end
            
    end

    
endmodule


