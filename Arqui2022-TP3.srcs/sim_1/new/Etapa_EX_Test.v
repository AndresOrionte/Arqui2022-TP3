`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 17:55:42
// Design Name: 
// Module Name: Etapa_EX_Test
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


module Etapa_EX_Test();


    reg i_clk;
    reg i_reset;
    reg [31:0] i_dato_1;
    reg [31:0] i_operando_b;
    reg [5:0] i_aluop;
    reg [1:0] i_forward_a_sel;
    reg [31:0] i_forward_a_dato_mem;
    reg [31:0] i_forward_a_dato_wb;
    reg [1:0] i_forward_b_sel;
    reg [31:0] i_forward_b_dato_mem;
    reg [31:0] i_forward_b_dato_wb;
    reg [1:0] i_forward_c_sel;
    reg [31:0] i_forward_c_dato_mem;
    reg [31:0] i_forward_c_dato_wb;
    reg i_take_jump_r;
    reg i_branch_neq;
    reg i_take_branch;
    reg [31:0] i_instruccion;
    reg [31:0] i_pc_p4;
    reg i_reg_dst;
    reg i_gpr31;
    reg i_block_latch;
    reg i_reset_latch;
    reg [31:0] i_dato_2;
    reg i_reg_write;
    reg i_mem_write;
    reg i_mem_to_reg;
    reg i_pc_4_wb;
    reg [3:0] i_mem_width;
    reg i_less_wb;

    wire o_take_jump_r;
    wire [31:0] o_jump_r_address;
    wire o_take_branch;
    wire [31:0] o_branch_address;
    wire [31:0] o_pc_p4;
    wire [31:0] o_resultado;
    wire o_carry;
    wire [31:0] o_dato_2;
    wire [4:0] o_reg_esc;
    wire o_reg_write;
    wire o_mem_write;
    wire o_mem_to_reg;
    wire o_pc_4_wb;
    wire [3:0] o_mem_width;
    wire o_less_wb;

    Etapa_EX Etapa_3(i_clk, i_reset, i_dato_1, i_operando_b, i_aluop, i_forward_a_sel, i_forward_a_dato_mem, i_forward_a_dato_wb,
                    i_forward_b_sel, i_forward_b_dato_mem, i_forward_b_dato_wb, i_forward_c_sel, i_forward_c_dato_mem, i_forward_c_dato_wb, 
                    i_take_jump_r, i_branch_neq, i_take_branch, 
                    i_instruccion, i_pc_p4, i_reg_dst, i_gpr31, i_block_latch, i_reset_latch, i_dato_2, i_reg_write, i_mem_write, 
                    i_mem_to_reg, i_pc_4_wb, i_mem_width, i_less_wb, o_take_jump_r, o_jump_r_address, o_take_branch, 
                    o_branch_address, o_pc_p4, o_resultado, o_carry, o_dato_2, o_reg_esc, o_reg_write, o_mem_write, o_mem_to_reg, 
                    o_pc_4_wb, o_mem_width, o_less_wb);

    initial begin
        
        i_clk = 0;
        i_reset = 0;
        i_dato_1 = 0;
        i_operando_b = 0;
        i_aluop = 0;
        i_forward_a_sel = 0;
        i_forward_a_dato_mem = 0;
        i_forward_a_dato_wb = 0;
        i_forward_b_sel = 0;
        i_forward_b_dato_mem = 0;
        i_forward_b_dato_wb = 0;
        i_forward_c_sel = 0;
        i_forward_c_dato_mem = 0;
        i_forward_c_dato_wb = 0;
        i_take_jump_r = 0;
        i_branch_neq = 0;
        i_take_branch = 0;
        i_instruccion = 0;
        i_pc_p4 = 0;
        i_reg_dst = 0;
        i_gpr31 = 0;
        i_block_latch = 0;
        i_reset_latch = 0;
        i_dato_2 = 0;
        i_reg_write = 0;
        i_mem_write = 0;
        i_mem_to_reg = 0;
        i_pc_4_wb = 0;
        i_mem_width = 0;
        i_less_wb = 0;

    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end
endmodule
