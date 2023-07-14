`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2023 20:08:51
// Design Name: 
// Module Name: MIPS
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


module MIPS #(
    parameter NCFT = 651
    )(
    
    input wire i_clk,
    input wire i_reset,
    
    input wire i_rx,
    
    output wire o_tx,
    
    output wire [3:0] o_state
    );

    
    wire [31:0] pc_0;
    wire take_jump_0, take_jump_r_0, take_branch_0;
    wire [31:0] jump_address, jump_r_address, branch_address;
    wire [31:0] pc_p4_0, instruccion_0; 
    
    wire [4:0] reg_esc_registros;
    wire [31:0] dato_esc_registros;
    wire reg_write_id;
    wire [31:0] pc_p4_1, dato_1_1, dato_2_1, operando_b_1, instruccion_1;
    wire [5:0] aluop;
    wire less_wb_1, gpr31_1, pc_4_wb_1, reg_dst_1, mem_to_reg_1, mem_write_1, reg_write_1, take_jump_r_1, take_branch_1, branch_neq_1, halt_1, post_bloqueo_1_0, post_bloqueo_1_1;
    wire take_jump_r_uc, take_branch_uc;
    wire [3:0] mem_width_1;
    
    wire [31:0] pc_p4_2, resultado_2, dato_2_2;
    wire carry_2;
    wire [4:0] reg_esc_2;
    wire reg_write_2, mem_write_2, mem_to_reg_2, pc_4_wb_2, less_wb_2, halt_2, post_bloqueo_2_0, post_bloqueo_2_1;
    wire [3:0] mem_width_2;
    
    wire reset_signals;
    wire reset_latch_exmem;
    wire block_pc_udr, block_latch_1_udr, block_latch_2_udr;
    
    wire [1:0] forward_a, forward_b, forward_c;
    
    wire reset_out_debug;
    wire sel_dir_mem_instr_debug;
    wire flag_esc_mem_instr_debug;
    wire [31:0] dir_mem_instr_debug;
    wire [31:0] dato_mem_instr_debug;
    wire sel_dir_un_reg_debug;
    wire [4:0] dir_un_reg_debug;
    wire [31:0] lec_reg_debug;
    wire sel_dir_mem_datos_debug;
    wire [31:0] dir_mem_datos_debug;
    wire [31:0] lec_mem_datos_debug;
    wire send_start_debug;
    wire [7:0] send_byte_debug;
    wire reset_pc_debug;
    wire block_latchs_debug;
    
    assign o_send_start = send_start_debug;
    assign o_send_byte = send_byte_debug;
    
    wire eor, sending_flag, err;
    wire [7:0] recept_byte;
    
    // Para solucionar asincronia en UnidadDeRegistros 
    
    wire [31:0] dato_wb_reg;
    wire [4:0] reg_esc_reg;
    wire reg_write_reg;

    
    Etapa_IF Etapa_0(i_clk, reset_out_debug, (block_latchs_debug | block_pc_udr), reset_pc_debug, sel_dir_mem_instr_debug, dir_mem_instr_debug, dato_mem_instr_debug, 
                        flag_esc_mem_instr_debug, (block_latchs_debug | block_latch_1_udr), (block_latchs_debug | block_latch_1_udr), take_jump_0, jump_address, take_jump_r_0, jump_r_address, 
                        take_branch_0, branch_address, pc_p4_0, instruccion_0, pc_0);
    
    Etapa_ID Etapa_1(i_clk, reset_out_debug, instruccion_0, pc_p4_0, reg_esc_reg, dato_wb_reg, reg_write_reg, block_latchs_debug, reset_signals, (block_latchs_debug | block_latch_2_udr), post_bloqueo_1_0,
                        sel_dir_un_reg_debug, dir_un_reg_debug, take_jump_0, jump_address, pc_p4_1, dato_1_1, dato_2_1, operando_b_1, instruccion_1, aluop, less_wb_1, mem_width_1,
                        gpr31_1, pc_4_wb_1, reg_dst_1, mem_to_reg_1, mem_write_1, reg_write_1, take_jump_r_1, take_branch_1, branch_neq_1, halt_1, post_bloqueo_1_1, take_jump_r_uc, take_branch_uc, lec_reg_debug);
    
    Etapa_EX Etapa_2(i_clk, reset_out_debug, dato_1_1, operando_b_1, aluop, forward_a, dato_esc_registros, resultado_2, forward_b, dato_esc_registros, resultado_2,
                        forward_c, dato_esc_registros, resultado_2, take_jump_r_1, branch_neq_1, take_branch_1, instruccion_1, pc_p4_1, reg_dst_1, gpr31_1,
                        block_latchs_debug, reset_latch_exmem, dato_2_1, reg_write_1, mem_write_1, mem_to_reg_1, pc_4_wb_1, mem_width_1, less_wb_1, halt_1, take_jump_r_0, jump_r_address,
                        take_branch_0, branch_address, pc_p4_2, resultado_2, carry_2, dato_2_2, reg_esc_2, reg_write_2, mem_write_2, mem_to_reg_2, pc_4_wb_2, 
                        mem_width_2, less_wb_2, halt_2);
                        
    Etapa_MEM Etapa_3(i_clk, reset_out_debug, resultado_2, carry_2, less_wb_2, dato_2_2, mem_write_2, mem_width_2, mem_to_reg_2, pc_4_wb_2, pc_p4_2, block_latchs_debug,
                        reg_esc_2, reg_write_2, post_bloqueo_2_0, sel_dir_mem_datos_debug, dir_mem_datos_debug, dato_esc_registros, reg_esc_registros, reg_write_id, post_bloqueo_2_1, lec_mem_datos_debug,
                        dato_wb_reg, reg_esc_reg, reg_write_reg);
    
    UnidadDeCortocircuito Uc_0(instruccion_1[25:21], instruccion_1[20:16], reg_esc_2, reg_write_2, reg_esc_registros, reg_write_id, reg_dst_1, mem_write_1, forward_a, forward_b, forward_c);
    
    UnidadDeDeteccionDeRiesgos Udr_0(reset_out_debug, take_jump_r_uc, take_branch_uc, mem_to_reg_2, reg_dst_1, instruccion_1[25:21], instruccion_1[20:16], reg_esc_2, post_bloqueo_1_1,
                                        post_bloqueo_2_1, block_pc_udr, block_latch_1_udr, block_latch_2_udr, reset_signals, reset_latch_exmem, post_bloqueo_1_0, post_bloqueo_2_0);
    
    UnidadDeDebug Udebug_0(i_clk, i_reset, eor, err, recept_byte, sending_flag, pc_0, lec_reg_debug, lec_mem_datos_debug, halt_2,
                        send_start_debug, send_byte_debug, reset_out_debug, reset_pc_debug, block_latchs_debug, sel_dir_mem_instr_debug, flag_esc_mem_instr_debug,
                        dir_mem_instr_debug, dato_mem_instr_debug, sel_dir_un_reg_debug, dir_un_reg_debug, sel_dir_mem_datos_debug, dir_mem_datos_debug, o_state);
    
    UART #(.NCFT(NCFT)) UART_0(i_clk, i_reset, i_rx, send_start_debug, send_byte_debug, o_tx, eor, sending_flag, recept_byte, err);
    
endmodule