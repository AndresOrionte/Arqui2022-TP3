`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 21:01:12
// Design Name: 
// Module Name: Etapa_EX
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


module Etapa_EX(

    //Inputs comunes
    input wire i_clk,
    input wire i_reset,
    //ALU
    input wire [31:0] i_dato_1,
    input wire [31:0] i_operando_b,
    input wire [5:0] i_aluop,
    //Decisiones branchs y jump
    input wire i_take_jump_r,
    input wire i_branch_neq,
    input wire i_take_branch,
    //Addres branch
    input wire [31:0] i_instruccion,
    input wire [31:0] i_pc_p4,
    //Registro escritura
    input wire i_reg_dst,
    input wire i_gpr31,
    //Latch EX
    input wire i_block_latch,
    //Pasan directas
    input wire [31:0] i_dato_2,
    input wire i_reg_write,
    input wire i_mem_write,
    input wire i_mem_to_reg,
    input wire i_pc_4_wb,
    input wire [3:0] i_mem_width,
    input wire i_less_wb,
    
    //Outputs hacia atras, para jumps y branchs
    output wire o_take_jump_r,
    output wire [31:0] o_jump_r_address,
    output wire o_take_branch,
    output wire [31:0] o_branch_address,
    
    //Outputs hacia adelante, etapa MEM
    output wire [31:0] o_pc_p4,
    output wire [31:0] o_resultado,
    output wire o_carry,
    output wire [31:0] o_dato_2,
    output wire [4:0] o_reg_esc,
    //Señales de control
    output wire o_reg_write,
    output wire o_mem_write,
    output wire o_mem_to_reg,
    output wire o_pc_4_wb,
    output wire [3:0] o_mem_width,
    output wire o_less_wb

    );
    
    wire [31:0] resultado;
    wire carry;
    wire zero;
    
    wire branch_sig_0;
    
    reg literal_0 = 1'b0;
    
    wire [17:0] branch_address_sh;
    wire [31:0] branch_address_ext;
    
    wire [4:0] reg_esc_0;
    reg [4:0] literal_31 = 5'b11111;
    wire [4:0] reg_esc_1;
    
    
    ALU Alu_0(i_dato_1, i_operando_b, i_aluop, resultado, carry, zero);
    
    assign o_take_jump_r = i_take_jump_r;
    assign o_jump_r_address = i_dato_1;
    
    Mux2 #1 Mux_branch_0(i_branch_neq, zero, !zero, branch_sig_0);
    
    Mux2 #1 Mux_branch_1(i_take_branch, literal_0, branch_sig_0, o_take_branch);
    
    Shift2 #16 Shift_0(i_instruccion[15:0], branch_address_sh);
    
    ExtensorDeSigno #18 ExtS_0(branch_address_sh, branch_address_ext);
    
    Sumador Sumador_0(branch_address_ext, i_pc_p4, o_branch_address);
    
    Mux2 #5 Mux_escritura_0(i_reg_dst, i_instruccion[20:16], i_instruccion[15:11], reg_esc_0);
    
    Mux2 #5 Mux_escritura_1(i_gpr31, reg_esc_0, literal_31, reg_esc_1);
    
    LatchEXMEM Latch_3(i_clk, i_reset, i_block_latch, i_pc_p4, resultado, carry, i_dato_2, reg_esc_1, i_reg_write, i_mem_write, i_mem_to_reg, 
                        i_pc_4_wb, i_mem_width, i_less_wb, o_pc_p4, o_resultado, o_carry, o_dato_2, o_reg_esc, o_reg_write, o_mem_write, 
                        o_mem_to_reg, o_pc_4_wb, o_mem_width, o_less_wb);
    
    
endmodule
