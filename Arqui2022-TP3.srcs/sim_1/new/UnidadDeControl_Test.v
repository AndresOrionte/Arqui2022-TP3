`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2023 20:14:57
// Design Name: 
// Module Name: UnidadDeControl_Test
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


module UnidadDeControl_Test();

    reg i_reset;
    reg [5:0] i_op_code;
    
    wire o_reg_dst;
    wire o_reg_write;
    wire o_alu_src;
    wire o_mem_write;
    wire o_mem_to_reg;
    wire o_pc_4_wb;
    wire o_gpr31;
    wire [3:0] o_mem_width;
    wire o_less_wb;
    wire o_take_jump;
    wire o_take_jump_r;
    wire o_take_branch;
    wire o_branch_neq;
    
    wire [5:0] o_alu_op;
    
    UnidadDeControl_Signals UCS(i_reset, i_op_code, o_reg_dst, o_reg_write, o_alu_src, o_mem_write, o_mem_to_reg, o_pc_4_wb, o_gpr31, o_mem_width, o_less_wb, o_take_jump, o_take_jump_r, o_take_branch, o_branch_neq);
    UnidadDeControl_ALUOP UCA(i_reset, i_op_code, o_alu_op);
    
    initial begin
        
        i_reset = 1;
        i_op_code = 0;
        
        #5
        i_reset = 0;
        
        #1
        i_op_code = 6'b000001;  //ADDU
        
        #1
        i_op_code = 6'b000010;  //SUBU
        
        #1
        i_op_code = 6'b000011;  //AND
        
        #1
        i_op_code = 6'b000100;  //OR
        
        #1
        i_op_code = 6'b000101;  //XOR
        
        #1
        i_op_code = 6'b000110;  //NOR
        
        #1
        i_op_code = 6'b001001;  //SRAV
        
        #1
        i_op_code = 6'b001010;  //SRLV
        
        #1
        i_op_code = 6'b001100;  //SLLV
        
        #1
        i_op_code = 6'b001000;  //SLT
        
        #10
        
        #1
        i_op_code = 6'b010001;  //ADDI
        
        #1
        i_op_code = 6'b010010;  //SUBI
        
        #1
        i_op_code = 6'b010011;  //ANDI
        
        #1
        i_op_code = 6'b010100;  //ORI
        
        #1
        i_op_code = 6'b010101;  //XORI
        
        #1
        i_op_code = 6'b010111;  //LUI
        
        #1
        i_op_code = 6'b011001;  //SRA
        
        #1
        i_op_code = 6'b011010;  //SRL
        
        #1
        i_op_code = 6'b011100;  //SLL
        
        #1
        i_op_code = 6'b011000;  //SLTI
        
        #10
        
        #1
        i_op_code = 6'b100000;  //LB
        
        #1
        i_op_code = 6'b100001;  //LBU
        
        #1
        i_op_code = 6'b100010;  //LH
        
        #1
        i_op_code = 6'b100011;  //LHU
        
        #1
        i_op_code = 6'b100100;  //LW
        
        #1
        i_op_code = 6'b101001;  //SB
        
        #1
        i_op_code = 6'b101010;  //SH
        
        #1
        i_op_code = 6'b101100;  //SW
        
        #10
        
        #1
        i_op_code = 6'b110000;  //J
        
        #1
        i_op_code = 6'b110001;  //JAL
        
        #1
        i_op_code = 6'b110010;  //JR
        
        #1
        i_op_code = 6'b110011;  //JARL
        
        #1
        i_op_code = 6'b110100;  //BEQ
        
        #1
        i_op_code = 6'b110101;  //BEN
        
        #10
        
        #1
        i_op_code = 6'b000000;  //NOP
        
        #1
        i_op_code = 6'b000001;  //ADDU
        
        #1
        i_op_code = 6'b111111; //HALT
        
        
    end

endmodule