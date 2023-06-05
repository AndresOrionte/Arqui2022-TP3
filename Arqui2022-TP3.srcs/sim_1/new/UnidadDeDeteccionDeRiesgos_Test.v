`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2023 20:20:20
// Design Name: 
// Module Name: UnidadDeDeteccionDeRiesgos_Test
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


module UnidadDeDeteccionDeRiesgos_Test();

    reg i_reset;
    reg i_take_jump_r;
    reg i_take_branch;
    reg i_mem_to_reg;
    reg i_reg_dst;
    reg [5:0] i_rs;
    reg [5:0] i_rt;
    reg [5:0] i_rd;
    reg i_post_bloqueo_1;
    reg i_post_bloqueo_2;
        
    wire o_bloqueo_pc;
    wire o_bloqueo_latch_ifid;
    wire o_bloqueo_latch_idex;
    wire o_reset_signals;
    wire o_reset_latch_exmem;
    wire o_post_bloqueo_1;
    wire o_post_bloqueo_2;
    
    UnidadDeDeteccionDeRiesgos U0(
        i_reset,
        i_take_jump_r,
        i_take_branch,
        i_mem_to_reg,
        i_reg_dst,
        i_rs,
        i_rt,
        i_rd,
        i_post_bloqueo_1,
        i_post_bloqueo_2,
 
        o_bloqueo_pc,
        o_bloqueo_latch_ifid,
        o_bloqueo_latch_idex,
        o_reset_signals,
        o_reset_latch_exmem,
        o_post_bloqueo_1,
        o_post_bloqueo_2
    );
    
    initial begin
        
        i_take_jump_r = 0;
        i_take_branch = 0;
        i_mem_to_reg = 0;
        i_reg_dst = 0;
        i_rs = 0;
        i_rt = 0;
        i_rd = 0;
        i_post_bloqueo_1 = 0;
        i_post_bloqueo_2 = 0;
        i_reset = 1;
        
        #5 
        i_reset = 0;
        

        
    end
    
   
endmodule
