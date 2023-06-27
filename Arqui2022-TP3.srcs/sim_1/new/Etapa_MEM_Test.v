`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 19:20:23
// Design Name: 
// Module Name: Etapa_MEM_Test
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


module Etapa_MEM_Test();

    reg i_clk;
    reg i_reset;
    reg [31:0] i_resultado;
    reg i_carry;
    reg i_less_wb;
    reg [31:0] i_dato_escritura;
    reg i_mem_write;
    reg [3:0] i_mem_width;
    reg i_mem_to_reg;
    reg i_pc_4_wb;
    reg [31:0] i_pc_p4;
    reg i_block_latch;
    reg i_reg_esc;
    reg i_reg_write;
    reg i_post_bloqueo;
    reg i_sel_dir_mem;
    reg i_dir_mem;

    wire o_dato_wb;
    wire o_reg_esc;
    wire o_reg_write;
    wire o_post_bloqueo;
    wire [31:0] o_lec_mem;


    Etapa_MEM Etapa_4(i_clk, i_reset, i_resultado, i_carry, i_less_wb, i_dato_escritura, i_mem_write, i_mem_width, i_mem_to_reg, i_pc_4_wb, i_pc_p4, i_block_latch, i_reg_esc, i_reg_write, i_post_bloqueo, i_sel_dir_mem, i_dir_mem, o_dato_wb, o_reg_esc, o_reg_write, o_post_bloqueo, o_lec_mem);

    initial begin
        
        i_clk <= 1;
        i_reset <= 1;
        i_resultado <= 0;
        i_carry <= 0;
        i_less_wb <= 0;
        i_dato_escritura <= 0;
        i_mem_write <= 0;
        i_mem_width <= 0;
        i_mem_to_reg <= 0;
        i_pc_4_wb <= 0;
        i_pc_p4 <= 0;
        i_block_latch <= 0;
        i_reg_esc <= 0;
        i_reg_write <= 0;
        i_post_bloqueo <= 0;
        i_sel_dir_mem <= 0;
        i_dir_mem <= 0;
        
        #5
        i_reset <= 0;
        
        #1
        i_reg_esc <= 1;
        i_resultado <= 200;
        i_reg_write <= 1;
        
        #1
        i_reg_esc <= 0;
        i_resultado <= 0;
        i_reg_write <= 0;

    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk <= ~i_clk;
    end
    
endmodule
