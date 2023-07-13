`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2023 12:16:51
// Design Name: 
// Module Name: Etapa_ID
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


module Etapa_ID(
    //Inputs comunes
    input wire i_clk,
    input wire i_reset,
    input wire [31:0] i_instruccion,
    input wire [31:0] i_pc_p4,
    //UnidadDeRegistros
    input wire [4:0] i_reg_esc,
    input wire [31:0] i_dato_esc,
    input wire i_reg_write,
    //UnidadeDeControl_Signals y UnidadDeControl_ALUOP
    input wire i_reset_signals,
    //Latch_ID
    input wire i_block_latch,
    input wire i_post_bloqueo,
    //UnidadDeDebug
    input wire i_sel_reg_lec_1,
    input wire [4:0] i_reg_lec_1,
    
    //Outputs hacia atras, para jumps
    output wire o_take_jump,
    output wire [31:0] o_jump_address,
    
    //Outputs hacia adelante, etapa EX
    output wire [31:0] o_pc_p4,
    output wire [31:0] o_dato_1,
    output wire [31:0] o_dato_2,
    output wire [31:0] o_operando_b,
    output wire [31:0] o_instruccion,
    output wire [5:0] o_aluop,
    // De control
    output wire o_less_wb,
    output wire [3:0] o_mem_width,
    output wire o_gpr31,
    output wire o_pc_4_wb,
    output wire o_reg_dst,
    output wire o_mem_to_reg,
    output wire o_mem_write,
    output wire o_reg_write,
    output wire o_take_jump_r,
    output wire o_take_branch,
    output wire o_branch_neq,
    output wire o_halt,
    // Deteccion de riesgo
    output wire o_post_bloqueo,
    output wire o_take_jump_r_uc,     //Salida de la señal directa desde Unidad de Control (para deteccion de riesgos)
    output wire o_take_branch_uc,     //Salida de la señal directa desde Unidad de Control (para deteccion de riesgos)
    // UnidadDeDebug
    output wire [31:0] o_lec_reg_debug
    );
    
    wire [4:0] reg_1;
    
    wire [31:0] dato_1;
    wire [31:0] dato_2;
    
    wire reg_dst, reg_write, alu_src, mem_write, mem_to_reg, pc_4_wb, gpr31, less_wb, take_jump_r, take_branch, branch_neq, halt;
    wire [3:0] mem_width;
    
    wire [5:0] aluop;
    
    wire [31:0] inmediato_ext;
    
    wire [31:0] operando_b;
    
    wire [27:0] jump_address_sh;
    wire [31:0] jump_address_ext;
    
    // Aun no implementados (Para la unidad de deteccion de riesgos)
    
    assign o_take_jump_r_uc = take_jump_r;
    assign o_take_branch_uc = take_branch;
    assign o_lec_reg_debug = dato_1;
    
    Mux2 #5 Mux_0(i_sel_reg_lec_1, i_instruccion[25:21], i_reg_lec_1, reg_1);
    
    UnidadDeRegistros Regs_0(i_clk, i_reset, reg_1, i_instruccion[20:16], i_reg_esc, i_dato_esc, i_reg_write, dato_1, dato_2);
    
    UnidadDeControl_Signals UCS_0((i_reset | i_reset_signals), i_instruccion[31:26], reg_dst, reg_write, alu_src, mem_write, mem_to_reg, 
                                    pc_4_wb, gpr31, mem_width, less_wb, o_take_jump, take_jump_r, take_branch, branch_neq, halt);
    
    UnidadDeControl_ALUOP UCA_0(i_reset, i_instruccion[31:26], aluop);
    
    ExtensorDePalabra #16 ExtP_0(i_instruccion[15:0], inmediato_ext);
    
    Mux2 Mux_1(alu_src, dato_2, inmediato_ext, operando_b);
    
    Shift2 #26 Shift_0(i_instruccion[25:0], jump_address_sh);
    
    ExtensorDeSigno #28 ExtS_0(jump_address_sh, jump_address_ext);
    
    Sumador Sumador_0(jump_address_ext, i_pc_p4, o_jump_address);
    
    LatchIDEX Latch_2(i_clk, i_reset, i_block_latch, i_pc_p4, dato_1, dato_2, operando_b, i_instruccion, aluop, less_wb, mem_width, gpr31, pc_4_wb, 
                        reg_dst, mem_to_reg, mem_write, reg_write, take_jump_r, take_branch, branch_neq,  halt, i_post_bloqueo, o_pc_p4, 
                        o_dato_1, o_dato_2, o_operando_b, o_instruccion, o_aluop, o_less_wb, o_mem_width, o_gpr31, o_pc_4_wb, o_reg_dst, o_mem_to_reg, 
                        o_mem_write, o_reg_write, o_take_jump_r, o_take_branch, o_branch_neq, o_halt, o_post_bloqueo);
    
    
    
endmodule
