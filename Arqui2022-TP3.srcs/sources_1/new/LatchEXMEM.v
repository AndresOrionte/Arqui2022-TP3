`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2023 00:36:48
// Design Name: 
// Module Name: LatchEXMEM
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


module LatchEXMEM(

    input wire i_clk,
    input wire i_bloqueo,
    input wire [31:0] i_pc_p4,
    input wire [31:0] i_resultado,
    input wire i_carry,
    input wire [31:0] i_dato_2,
    input wire [4:0] i_reg_esc,
    //Señales de control
    input wire i_reg_write,
    input wire i_mem_write,
    input wire i_mem_to_reg,
    input wire i_pc_4_wb,
    input wire [3:0] i_mem_width,
    input wire i_less_wb,
    
    output reg [31:0] o_pc_p4,
    output reg [31:0] o_resultado,
    output reg o_carry,
    output reg [31:0] o_dato_2,
    output reg [4:0] o_reg_esc,
    //Señales de control
    output reg o_reg_write,
    output reg o_mem_write,
    output reg o_mem_to_reg,
    output reg o_pc_4_wb,
    output reg [3:0] o_mem_width,
    output reg o_less_wb
    
    );
    
    always @(posedge i_clk) begin
    
        if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
        
            o_pc_p4 <= i_pc_p4;
            o_resultado <= i_resultado;
            o_carry <= i_carry;
            o_dato_2 <= i_dato_2;
            o_reg_esc <= i_reg_esc;
            
            o_reg_write <= i_reg_write;
            o_mem_write <= i_mem_write;
            o_mem_to_reg <= i_mem_to_reg;
            o_pc_4_wb <= i_pc_4_wb;
            o_mem_width <= i_mem_width;
            o_less_wb <= i_less_wb;
        
        end
    
    end
    
endmodule
