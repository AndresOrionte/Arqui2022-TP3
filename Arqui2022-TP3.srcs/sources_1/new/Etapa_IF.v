`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2023 18:50:51
// Design Name: 
// Module Name: Etapa_IF
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


module Etapa_IF(
    //Inputs comunes
    input wire i_clk,
    input wire i_reset,
    //PC
    input wire i_block_pc,
    input wire i_reset_pc,
    //MemoriaDeInstrucciones
    input wire i_ctrl_dir_mem,
    input wire [31:0] i_dir_mem,
    input wire [31:0]i_dato_escritura_mem,
    input wire i_flag_escritura_mem,
    //Latch_IF
    input wire i_block_latch,
    //Señales de control de saltos e ingreso de direcciones
    input wire i_take_jump,
    input wire [31:0] i_jump_address,
    input wire i_take_jump_r,
    input wire [31:0] i_jump_r_address,
    input wire i_take_branch,
    input wire [31:0] i_branch_address,
    //Outputs comunes
    output wire [31:0] o_pc_p4,
    output wire [31:0] o_instruccion,
    //Outputs UnidadDeDebug
    output wire [31:0] o_pc

    );
    
    wire [31:0] pc_next;
    
    wire [31:0] mem_dir;
    
    wire [31:0] instruccion;
    wire [31:0] pc_p4;
    
    reg [31:0] literal_4 = 32'h00000004;
    
    wire [31:0] mux_0;
    wire [31:0] mux_1;
    
    PC PC0(i_clk, (i_reset | i_reset_pc), pc_next, i_block_pc, o_pc);
    
    Mux2 Mux_Mem_Dir(i_ctrl_dir_mem, o_pc, i_dir_mem, mem_dir);
    
    MemoriaDeInstrucciones Mem_0(i_clk, i_reset, mem_dir, i_dato_escritura_mem, i_flag_escritura_mem, instruccion);
    
    LatchIFID Latch_1(i_clk, i_reset, i_block_latch, pc_p4, instruccion, o_pc_p4, o_instruccion);
    
    Sumador Sumador_0(literal_4, o_pc, pc_p4);
    
    Mux2 Mux_0(i_take_jump, pc_p4, i_jump_address, mux_0);
    
    Mux2 Mux_1(i_take_jump_r, mux_0, i_jump_r_address, mux_1);
    
    Mux2 Mux_2(i_take_branch, mux_1, i_branch_address, pc_next);
    
endmodule
