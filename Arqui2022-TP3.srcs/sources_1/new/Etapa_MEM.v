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
    //Latch3
    input wire i_block_latch,
    input wire [4:0] i_reg_esc,
    input wire i_reg_write,
    input wire i_post_bloqueo,
    //UnidadDeDebug
    input wire i_sel_dir_mem,
    input wire [31:0] i_dir_mem,
    
    //Outputs hacia adelante, etapa WB
    output wire [31:0] o_dato_wb,
    output wire [4:0] o_reg_esc,
    output wire o_reg_write,
    output wire o_post_bloqueo,
    //UnidadDeDebug
    output wire [31:0] o_lec_mem

    );
    
    wire [31:0] carry_ext;
    
    wire [31:0] resultado;
    
    wire [31:0] direccion_memoria;
    
    wire literal_0;
    wire [3:0] literal_1100;

    wire mem_write;    
    wire [3:0] mem_width;

    wire [31:0] dato_mem;
    
    wire [31:0] dato_sel;
    
    wire [31:0] dato_wb;
    
    assign literal_1100 = 4'b1100;
    assign literal_0 = 1'b0;
    assign o_lec_mem = dato_mem;
    
    ExtensorDePalabra #1 ExtP_0(i_carry, carry_ext);
    
    Mux2 Mux_0(i_less_wb, i_resultado, carry_ext, resultado);
    
    Mux2 Mux_1(i_sel_dir_mem, resultado, i_dir_mem, direccion_memoria);
    
    Mux2 #1 Mux_3(i_sel_dir_mem, i_mem_write, literal_0, mem_write);
    
    Mux2 #4 Mux_2(i_sel_dir_mem, i_mem_width, literal_1100, mem_width);
    
    MemoriaDeDatos Mem_0(i_clk, i_reset, direccion_memoria, i_dato_escritura, mem_write, mem_width, dato_mem);
    
    Mux2 Mux_4(i_mem_to_reg, resultado, dato_mem, dato_sel);
    
    Mux2 Mux_5(i_pc_4_wb, dato_sel, i_pc_p4, dato_wb);
    
    LatchMEMWB Latch_4(i_clk, i_reset, i_block_latch, dato_wb, i_reg_esc, i_reg_write, i_post_bloqueo, o_dato_wb, o_reg_esc, o_reg_write, o_post_bloqueo);
    
endmodule
