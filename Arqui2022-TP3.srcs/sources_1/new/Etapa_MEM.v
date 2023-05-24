`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 18:25:18
// Design Name: 
// Module Name: Etapa_MEM
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


module Etapa_MEM(
    //Inputs comunes
    input wire i_clk,
    input wire i_reset,
    //Mux0
    input wire [31:0] i_resultado,
    input wire i_carry,
    input wire i_less_wb,
    //MemoriaDeDatos
    input wire [31:0] i_dato_escritura,
    input wire i_mem_write,
    input wire [3:0] i_mem_width,
    //Mux1
    input wire i_mem_to_reg,
    //Mux2
    input wire i_pc_4_wb,
    input wire [31:0] i_pc_p4,
    //LAtch3
    input wire i_block_latch,
    input wire i_reg_esc,
    input wire i_reg_write,
    
    //Outputs hacia adelante, etapa WB
    output wire [31:0] o_dato_wb,
    output wire [4:0] o_reg_esc,
    output wire o_reg_write

    );
    
    wire [31:0] carry_ext;
    
    wire [31:0] resultado;
    
    wire [31:0] dato_mem;
    
    wire [31:0] dato_sel;
    
    wire [31:0] dato_wb;
    
    ExtensorDePalabra #1 ExtP_0(i_carry, carry_ext);
    
    Mux2 Mux_0(i_less_wb, i_resultado, carry_ext, resultado);
    
    MemoriaDeDatos Mem_0(i_clk, i_reset, resultado, i_dato_escritura, i_mem_write, i_mem_width, dato_mem);
    
    Mux2 Mux_1(i_mem_to_reg, resultado, dato_mem, dato_sel);
    
    Mux2 Mux_2(i_pc_4_wb, dato_sel, i_pc_p4, dato_wb);
    
    LatchMEMWB Latch_3(i_clk, i_block_latch, dato_wb, i_reg_esc, i_reg_write, o_dato_wb, o_reg_esc, o_reg_write);
    
endmodule
