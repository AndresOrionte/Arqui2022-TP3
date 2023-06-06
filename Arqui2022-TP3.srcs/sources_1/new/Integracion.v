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


module Integracion(
    
    input wire i_clk,
    input wire i_reset,
    
    input wire i_block_pc,
    input wire i_ctrl_dir_mem_instrucciones,
    input wire [31:0] i_dir_mem_instrucciones,
    input wire [31:0]i_dato_escritura_mem_instrucciones,
    input wire i_flag_escritura_mem_instrucciones,
    input wire i_block_latch_1,
    
    input wire i_block_latch_2,
    
    input wire i_block_latch_3,
    
    input wire i_block_latch_4
    
    );
    
    wire take_jump_0, take_jump_r_0, take_branch_0;
    wire [31:0] jump_address, jump_r_address, branch_address;
    wire [31:0] pc_p4_0, instruccion_0; 
    
    wire [4:0] reg_esc_registros;
    wire [31:0] dato_esc_registros;
    wire reg_write_id;
    wire [31:0] pc_p4_1, dato_1_1, dato_2_1, operando_b_1, instruccion_1;
    wire [5:0] aluop;
    wire less_wb_1, gpr31_1, pc_4_wb_1, reg_dst_1, mem_to_reg_1, mem_write_1, reg_write_1, take_jump_r_1, take_branch_1, branch_neq_1, post_bloqueo_1_0, post_bloqueo_1_1;
    wire take_jump_r_uc, take_branch_uc;
    wire [3:0] mem_width_1;
    
    wire [31:0] pc_p4_2, resultado_2, dato_2_2;
    wire carry_2;
    wire [4:0] reg_esc_2;
    wire reg_write_2, mem_write_2, mem_to_reg_2, pc_4_wb_2, less_wb_2, post_bloqueo_2_0, post_bloqueo_2_1;
    wire [3:0] mem_width_2;
    
    wire reset_signals;
    wire reset_latch_exmem;
    wire block_pc_udr, block_latch_1_udr, block_latch_2_udr;
    
    Etapa_IF Etapa_0(i_clk, i_reset, (i_block_pc | block_pc_udr), i_ctrl_dir_mem_instrucciones, i_dir_mem_instrucciones,i_dato_escritura_mem_instrucciones, 
                        i_flag_escritura_mem_instrucciones, (i_block_latch_1 | block_latch_1_udr), take_jump_0, jump_address, take_jump_r_0, jump_r_address, 
                        take_branch_0, branch_address, pc_p4_0, instruccion_0);
    
    Etapa_ID Etapa_1(i_clk, i_reset, instruccion_0, pc_p4_0, reg_esc_registros, dato_esc_registros, reg_write_id, reset_signals, (i_block_latch_2 | block_latch_2_udr), post_bloqueo_1_0,
                        take_jump_0, jump_address, pc_p4_1, dato_1_1, dato_2_1, operando_b_1, instruccion_1, aluop, less_wb_1, mem_width_1,
                        gpr31_1, pc_4_wb_1, reg_dst_1, mem_to_reg_1, mem_write_1, reg_write_1, take_jump_r_1, take_branch_1, branch_neq_1, post_bloqueo_1_1, take_jump_r_uc, take_branch_uc);
    
    Etapa_EX Etapa_2(i_clk, i_reset, dato_1_1, operando_b_1, aluop, take_jump_r_1, branch_neq_1, take_branch_1, instruccion_1, pc_p4_1, reg_dst_1, gpr31_1,
                        i_block_latch_3, reset_latch_exmem, dato_2_1, reg_write_1, mem_write_1, mem_to_reg_1, pc_4_wb_1, mem_width_1, less_wb_1, take_jump_r_0, jump_r_address,
                        take_branch_0, branch_address, pc_p4_2, resultado_2, carry_2, dato_2_2, reg_esc_2, reg_write_2, mem_write_2, mem_to_reg_2, pc_4_wb_2, 
                        mem_width_2, less_wb_2);
                        
    Etapa_MEM Etapa_3(i_clk, i_reset, resultado_2, carry_2, less_wb_2, dato_2_2, mem_write_2, mem_width_2, mem_to_reg_2, pc_4_wb_2, pc_p4_2, i_block_latch_4,
                        reg_esc_2, reg_write_2, post_bloqueo_2_0, dato_esc_registros, reg_esc_registros, reg_write_id, post_bloqueo_2_1);
    
    UnidadDeCortocircuito Uc_0();
    
    UnidadDeDeteccionDeRiesgos Udr_0(i_reset, take_jump_r_uc, take_branch_uc, mem_to_reg_2, reg_dst_1, instruccion_1[25:21], instruccion_1[20:16], reg_esc_2, post_bloqueo_1_1,
                                        post_bloqueo_2_1, block_pc_udr, block_latch_1_udr, block_latch_2_udr, reset_signals, reset_latch_exmem, post_bloqueo_1_0, post_bloqueo_2_0);
    
    
endmodule
