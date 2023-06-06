`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2023 17:15:46
// Design Name: 
// Module Name: UnidadDeDeteccionDeRiesgos
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


module UnidadDeDeteccionDeRiesgos(
    input wire i_reset,
    input wire i_take_jump_r,
    input wire i_take_branch,
    input wire i_mem_to_reg,
    input wire i_reg_dst,
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,
    input wire [4:0] i_rd,
    input wire i_post_bloqueo_1,
    input wire i_post_bloqueo_2,
        
    output wire o_bloqueo_pc,
    output wire o_bloqueo_latch_ifid,
    output reg o_bloqueo_latch_idex,
    output reg o_reset_signals,
    output reg o_reset_latch_exmem,
    output reg o_post_bloqueo_1,
    output reg o_post_bloqueo_2
    );
    
    reg bloqueo_pc_1, bloqueo_pc_2, bloqueo_ifid_1, bloqueo_ifid_2;
    
    assign o_bloqueo_pc = bloqueo_pc_1 | bloqueo_pc_2;
    assign o_bloqueo_latch_ifid = bloqueo_ifid_1 | bloqueo_ifid_2;
    
    always @* begin
        
        if(i_reset) begin
            
            bloqueo_pc_1 <= 0;
            bloqueo_pc_2 <= 0;
            bloqueo_ifid_1 <= 0;
            bloqueo_ifid_2 <= 0;
            o_bloqueo_latch_idex <= 0;
            o_reset_signals <= 0;
            o_reset_latch_exmem <= 0;
            o_post_bloqueo_1 <= 0;
            o_post_bloqueo_2 <= 0;
            
        end else begin
        
            if(!i_post_bloqueo_2) begin                 // Si en el ciclo anterior no hubo riesgo por load
            
                o_reset_latch_exmem <= 0;
                
                if(i_mem_to_reg & ((i_rd == i_rs) | (i_reg_dst & (i_rd == i_rt)))) begin
                    
                    bloqueo_pc_2 <= 1;
                    bloqueo_ifid_2 <= 1;
                    o_bloqueo_latch_idex <= 1;
                    o_post_bloqueo_2 <= 1;
                    
                end
                
            end else begin                              // Si en este ciclo anterior hubo riesgo por load
                
                bloqueo_pc_2 <= 0;
                bloqueo_ifid_2 <= 0;
                o_bloqueo_latch_idex <= 0;
                o_post_bloqueo_2 <= 0;
                o_reset_latch_exmem <= 1;
                
            end
            
            if(!i_post_bloqueo_1) begin                 // Si en el ciclo anterior no hubo riesgo por jump o branch
            
                o_reset_signals <= 0;
                
                if(i_take_jump_r | i_take_branch) begin
                    
                    bloqueo_pc_1 <= 1;
                    bloqueo_ifid_1 <= 1;
                    o_post_bloqueo_1 <= 1;
                    
                end
                
            end else begin                              // Si en el ciclo anterior hubo riesgo por jump o branch
                
                bloqueo_pc_1 <= 0;
                bloqueo_ifid_1 <= 0;
                o_post_bloqueo_1 <= 0;
                o_reset_signals <= 1;
                
            end
        
        end
            
    end
    
    
endmodule
