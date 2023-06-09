`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2023 20:08:46
// Design Name: 
// Module Name: Etapa_IF_Test
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


module Etapa_IF_Test();

    reg i_clk;
    reg i_reset;
    reg i_block_pc;
    reg i_reset_pc;
    reg i_ctrl_dir_mem;
    reg [31:0] i_dir_mem;
    reg [31:0]i_dato_escritura_mem;
    reg i_flag_escritura_mem;
    reg i_block_latch;
    
    reg i_take_jump;
    reg [31:0] i_jump_address;
    
    reg i_take_jump_r;
    reg [31:0] i_jump_r_address;
    
    reg i_take_branch;
    reg [31:0] i_branch_address;
    
    wire [31:0] o_pc_p4;
    wire [31:0] o_instruccion;
    
    wire [31:0] o_pc;
    
    Etapa_IF etapa_0(i_clk, i_reset, i_block_pc, i_reset_pc, i_ctrl_dir_mem, i_dir_mem, i_dato_escritura_mem, i_flag_escritura_mem, i_block_latch, i_take_jump, i_jump_address, i_take_jump_r, i_jump_r_address, i_take_branch, i_branch_address, o_pc_p4, o_instruccion, o_pc);

    initial begin

        i_clk = 1;
        i_block_pc = 0;
        i_reset_pc = 0;
        i_ctrl_dir_mem = 0;
        i_dir_mem = 0;
        i_dato_escritura_mem = 0;
        i_flag_escritura_mem = 0;
        i_block_latch = 0;
        i_take_jump = 0;
        i_jump_address = 0;
        i_take_jump_r = 0;
        i_jump_r_address = 0;
        i_take_branch = 0;
        i_branch_address = 0; 
        //Primero hacemos un reset
        i_reset = 1;
        
        #5
        i_reset = 0;
        
        //Dejamos pasar algunos clocks para verificar que el PC progrese
        #5
        
        //Comprobamos el cambio del PC ante las se�ales de saltos y branch
        i_take_jump = 1;
        i_jump_address = 32'h0000FF00;
        #1
        i_take_jump = 0;
        
        #5
        i_take_jump_r = 1;
        i_jump_r_address = 32'h00AAAAAC;
        #1
        i_take_jump_r = 0;
        
        #5
        i_take_branch = 1;
        i_branch_address = 32'h00000000;
        #1
        i_take_branch = 0;
        
        //Probamos a escribir algunas instrucciones en la memoria de instrucciones. Dado que aun no esta implementado el mux que permite 
        // tomar control sobre las direcciones para escritura, utilizar� el propio pc para hacerlo.
        #5
        i_block_latch = 1;
        i_ctrl_dir_mem = 1;
        i_dir_mem = 32'h0000000C;
        i_flag_escritura_mem = 1;
        i_dato_escritura_mem = 32'h11111111;
        
        #1
        i_dir_mem = 32'h00000014;
        i_dato_escritura_mem = 32'h22222222;
        
        #1
        i_dir_mem = 32'h0000001C;
        i_dato_escritura_mem = 32'h33333333;
        
        #1
        i_dir_mem = 32'h00000020;
        i_dato_escritura_mem = 32'h44444444;
        
        //Ahora vemos si se leen correctamente
        #1
        i_ctrl_dir_mem = 0;
        i_flag_escritura_mem = 0;
        i_block_latch = 0;
        i_take_jump = 1;
        i_jump_address = 32'h0000004;
        
        #1
        i_take_jump = 0;
        
        
        
        

    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule
