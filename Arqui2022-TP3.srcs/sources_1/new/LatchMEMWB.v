`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 19:10:56
// Design Name: 
// Module Name: LatchMEMWB
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


module LatchMEMWB(
    input wire i_clk,
    input wire i_reset,
    input wire i_bloqueo,
    input wire [31:0] i_dato_wb,
    input wire [4:0] i_reg_esc,
    input wire i_reg_write,
    
    output reg [31:0] o_dato_wb,
    output reg [4:0] o_reg_esc,
    output reg o_reg_write

    );
    
    always @(posedge i_clk) begin
    
        if(i_reset) begin
        
            o_dato_wb <= 32'h00000000;
            o_reg_esc <= 5'h00;
            o_reg_write <= 1'b0;
        
        end else begin
        
            if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
                
                o_dato_wb <= i_dato_wb;
                o_reg_esc <= i_reg_esc;
                o_reg_write <= i_reg_write; 
                
            end
        end
    end    
    
    
endmodule
