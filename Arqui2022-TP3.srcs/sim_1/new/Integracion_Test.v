`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 22:26:54
// Design Name: 
// Module Name: Integracion_Test
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


module Integracion_Test();

    reg i_clk, i_reset, i_block_pc, i_ctrl_dir_mem_instrucciones, i_flag_esc_mem, i_block_latch_1, i_reset_signals, i_block_latch_2, i_block_latch_3, i_block_latch_4;
    reg [31:0] i_dir_mem_instrucciones, i_dato_esc_mem;
    
    Integracion Int_0(i_clk, i_reset, i_block_pc, i_ctrl_dir_mem_instrucciones, i_dir_mem_instrucciones, i_dato_esc_mem, i_flag_esc_mem, i_block_latch_1, i_reset_signals, i_block_latch_2, i_block_latch_3, i_block_latch_4);

    initial begin
        
        i_clk = 1;
        i_reset = 1;
        i_block_pc = 0;
        i_ctrl_dir_mem_instrucciones = 0;
        i_dir_mem_instrucciones = 0;
        i_dato_esc_mem = 0;
        i_flag_esc_mem = 0;
        i_block_latch_1 = 0;
        i_reset_signals = 0;
        i_block_latch_2 = 0;
        i_block_latch_3 = 0;
        i_block_latch_4 = 0;
        
        #5
        i_reset = 0;
        i_block_pc = 1;
        i_block_latch_1 = 1;
        
        #1
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        //i_dato_esc_mem = 32'b01011100000111100000000011001000;  // LUI R30, 200 - OK
        //i_dato_esc_mem = 32'b01011100000111100000000011110000;  // LUI R30, 4080 - OK
        i_dato_esc_mem = 32'b01010000000111100000111111110000;  // ORI R30, R0, 4080 - OK

        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000100000111110000000011111010;  // ADDI R31, R0, 250 - OK
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        //i_dato_esc_mem = 32'b10110011111111100000000000000000;  // SW R30, R31, 0 - OK
        //i_dato_esc_mem = 32'b10101011111111100000000000000010;  //SH R30, R31, 2 - OK
        i_dato_esc_mem = 32'b10100111111111100000000000000010;  //SB R30, R31, 2 - OK

        #1
        i_dir_mem_instrucciones = 32'h00000003C;
        i_dato_esc_mem = 32'b10001111111111010000000000000001;  // LHU R29, R31, 2 - NO SELECCIONA BIEN EL MUX MANEJADO POR MemToReg*/
        
        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01011100000111100000011011000011;  // LUI R30, 1731
        
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000100000111110000000011110000;  // LUI R31, 240 - OK       
                
        #1
        i_flag_esc_mem = 0;
        i_ctrl_dir_mem_instrucciones = 0;
        i_block_pc = 0;
        i_block_latch_1 = 0;
        
        

    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end


endmodule
