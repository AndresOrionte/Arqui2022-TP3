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
        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01011100000111100000000001100100;  // LUI R30, 100 - OK
        //i_dato_esc_mem = 32'b01011100000111100000000011110000;  // LUI R30, 4080 - OK
        //i_dato_esc_mem = 32'b01010000000111100000111111110000;  // ORI R30, R0, 4080 - OK

        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000100000111110000000011111010;  // ADDI R31, R0, 250 - OK
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b10110011111111100000000000000000;  // SW R30, R31, 0 - OK
        //i_dato_esc_mem = 32'b10101011111111100000000000000010;  //SH R30, R31, 2 - OK
        //i_dato_esc_mem = 32'b10100111111111100000000000000010;  //SB R30, R31, 2 - OK

        #1
        i_dir_mem_instrucciones = 32'h00000003C;
        i_dato_esc_mem = 32'b10010011111111010000000000000000;  // LW R29, R31, 0 - NO SELECCIONA BIEN EL MUX MANEJADO POR MemToReg
        
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01000100000111100000011011000011;  // ADDI R30, R0, 1731 - OK
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000111110111110000000011110000;  // ADDI R31, R30, 240 - OK
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b00000111110111111110100000000000;  // ADDU R29, R30, R31
       
        #1        
        i_dir_mem_instrucciones = 32'h0000003C;
        i_dato_esc_mem = 32'b00001011110111111110000000000000;  // SUBU R28, R30, R31        
        
        #1
        i_dir_mem_instrucciones = 32'h00000050;
        i_dato_esc_mem = 32'b00001111110111111101100000000000;  // AND R27, R30, R31
        
        #1        
        i_dir_mem_instrucciones = 32'h00000064;
        i_dato_esc_mem = 32'b00010011110111111101000000000000;  // OR R26, R30, R31
        
        #1
        i_dir_mem_instrucciones = 32'h00000078;
        i_dato_esc_mem = 32'b00010111110111111100100000000000;  // XOR R25, R30, R31
        
        #1        
        i_dir_mem_instrucciones = 32'h0000008C;
        i_dato_esc_mem = 32'b00011011110111111100000000000000;  // NOR R24, R30, R31       */         
        
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01000100000111100000000000000100;  // ADDI R30, R0, 4
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000111110111110000000000110010;  // ADDI R31, R30, 50
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b00100111111111101110100000000000;  // SRAV R29, R31, R30
       
        #1        
        i_dir_mem_instrucciones = 32'h0000003C;
        i_dato_esc_mem = 32'b00101011111111101110000000000000;  // SRLV R28, R31, R30      
        
        #1
        i_dir_mem_instrucciones = 32'h00000050;
        i_dato_esc_mem = 32'b00110011111111101101100000000000;  // SLLV R27, R31, R30
        
        #1        
        i_dir_mem_instrucciones = 32'h00000064;
        i_dato_esc_mem = 32'b00100011110111111101000000000000;  // SLT R26, R30, R31   */
        
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01000100000111100000000000101000;  // ADDI R30, R0, 40
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01001011110111010000000000110010;  // SUBI R29, R30, 50
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b01001011110111000000000000001010;  // SUBI R28, R30, 10
       
        #1        
        i_dir_mem_instrucciones = 32'h0000003C;
        i_dato_esc_mem = 32'b01001111110110110000000011111111;  // ANDI R27, R30, 255

        #1
        i_dir_mem_instrucciones = 32'h00000050;
        i_dato_esc_mem = 32'b01010111110110100000111111110000;  // XORI R26, R30, 4080 */

/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01000100000111100000000000101000;  // ADDI R30, R0, 40
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01100111110111010000000000000101;  // SRA R29, R30, 5
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b01101011110111000000000000000101;  // SRL R28, R30, 5
       
        #1        
        i_dir_mem_instrucciones = 32'h0000003C;
        i_dato_esc_mem = 32'b01110011110110110000000000000101;  // SLL R27, R30, 5     
        
        #1
        i_dir_mem_instrucciones = 32'h00000050;
        i_dato_esc_mem = 32'b01100011110110100000000000101001;  // SLTI R26, R30, 41    */
        
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        //i_dato_esc_mem = 32'b01000100000111100000000001111000;  // ADDI R30, R0, 120
        i_dato_esc_mem = 32'b01000100000101000000000001111000;  // ADDI R20, R0, 120
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        //i_dato_esc_mem = 32'b11000000000000000000000010000000;  // J 128
        //i_dato_esc_mem = 32'b11000100000000000000000010000000;  // JAL 128
        //i_dato_esc_mem = 32'b11001011110000000000000000000000;  // JR R30
        //i_dato_esc_mem = 32'b11001111101000001111000000000000;  // JALR R30, R29*/
        
/*        i_flag_esc_mem = 1;
        i_ctrl_dir_mem_instrucciones = 1;
        i_dir_mem_instrucciones = 32'h00000000;
        i_dato_esc_mem = 32'b01000100000111100000000001111000;  // ADDI R30, R0, 120
        
        #1
        i_dir_mem_instrucciones = 32'h00000014;
        i_dato_esc_mem = 32'b01000100000101000000000001111000;  // ADDI R20, R0, 120
        
        #1
        i_dir_mem_instrucciones = 32'h00000028;
        i_dato_esc_mem = 32'b11010010100111100000010011101000;  // BEQ 1256, R20, R30
        i_dato_esc_mem = 32'b11010110100111100000001100100000;  // BNE 800, R20, R30*/
        
        
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
