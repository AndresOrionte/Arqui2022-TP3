`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2023 11:38:54
// Design Name: 
// Module Name: Etapa_ID_Test
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


module Etapa_ID_Test();
   
   //Inputs comunes
    reg i_clk;
    reg i_reset;
    reg [31:0] i_instruccion;
    reg [31:0] i_pc_p4;
    //UnidadDeRegistros
    reg [4:0] i_reg_esc;
    reg [31:0] i_dato_esc;
    reg i_reg_write;
    //UnidadeDeControl_Signals y UnidadDeControl_ALUOP
    reg i_reset_signals;
    
    reg i_block_latch;
    
    //Outputs hacia atras, para jumps
    wire o_take_jump;
    wire o_jump_address;
    
    //Outputs hacia adelante, etapa EX
    wire [31:0] o_pc_p4;
    wire [31:0] o_dato_1;
    wire [31:0] o_dato_2;
    wire [31:0] o_operando_b;
    wire [31:0] o_instruccion;
    wire [5:0] o_aluop;
    // De control
    wire o_less_wb;
    wire [3:0] o_mem_width;
    wire o_gpr31;
    wire o_pc_4_wb;
    wire o_reg_dst;
    wire o_mem_to_reg;
    wire o_mem_write;
    wire o_reg_write;
    wire o_take_jump_r;
    wire o_take_branch;
    wire o_branch_neq;
    // Deteccion de riesgo
    wire o_auto_desbloqueo;
    
    Etapa_ID etapa_1(i_clk, i_reset, i_instruccion, i_pc_p4, i_reg_esc, i_dato_esc, i_reg_write, i_reset_signals, i_block_latch, o_take_jump, o_jump_address, o_pc_p4, o_dato_1, o_dato_2, o_operando_b, o_instruccion, o_aluop, o_less_wb, o_mem_width, o_gpr31, o_pc_4_wb, o_reg_dst, o_mem_to_reg, o_mem_write, o_reg_write, o_take_jump_r, o_take_branch, o_branch_neq, o_auto_desbloqueo);
                        
    initial begin
        
        i_clk = 1;
        i_reset = 1;
        i_instruccion = 0;
        i_pc_p4 = 0;
        i_reg_esc = 0;
        i_dato_esc = 0;
        i_reg_write = 0;
        i_reset_signals = 0;
        i_block_latch = 0;
        
        #5
        i_reset = 0;
        
        #1
        i_instruccion = 32'b01011100001000010000000011001000;
        
        #1
        i_instruccion = 32'b01000100001000100000000010000000;
        
        #1
        i_instruccion = 0;
        
    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end

    
    
endmodule
