`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2023 09:00:49
// Design Name: 
// Module Name: UnidadDeControl_Signals
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


module UnidadDeControl_Signals(

    input wire i_clk,
    input wire i_reset,
    input wire [5:0] i_op_code,
    input wire i_reset_signals, // Como se usa??
    
    output reg o_reg_dst,
    output reg o_reg_write,
    output reg o_alu_src,
    output reg o_mem_write,
    output reg o_mem_to_reg,
    output reg o_pc_4_wb,
    output reg o_gpr31,
    output reg [3:0] o_mem_width,
    output reg o_less_wb,
    output reg o_take_jump,
    output reg o_take_jump_r,
    output reg o_take_branch,
    output reg o_branch_neq
    );
    
    
    always @(*) begin
    
        if(i_reset) begin               //En caso de reset pongo todas las salidas a 0
        
            o_reg_dst <= 1'b0;
            o_reg_write <= 1'b0;
            o_alu_src <= 1'b0;
            o_mem_write <= 1'b0;
            o_mem_to_reg <= 1'b0;
            o_pc_4_wb <= 1'b0;
            o_gpr31 <= 1'b0;
            o_mem_width <= 4'b0000;
            o_less_wb <= 1'b0;
            o_take_jump <= 1'b0;
            o_take_jump_r <= 1'b0;
            o_take_branch <= 1'b0;
            o_branch_neq <= 1'b0;
            
        end else begin
           
            
            if(!i_op_code[5]) begin                     // 0 = Operaciones tipo R e I(Inm)
            
                if(i_op_code[4:0] == 5'b00000) begin    // NOP
                
                    o_reg_dst <= 1'b0;
                    o_reg_write <= 1'b0;
                    o_alu_src <= 1'b0;
                    o_mem_write <= 1'b0;
                    o_mem_to_reg <= 1'b0;
                    o_pc_4_wb <= 1'b0;
                    o_gpr31 <= 1'b0;
                    //o_mem_width <= 4'bXXXX;
                    o_less_wb <= 1'b0;
                    o_take_jump <= 1'b0;
                    o_take_jump_r <= 1'b0;
                    o_take_branch <= 1'b0;
                    o_branch_neq <= 1'b0;
                
                end else begin
                
                    o_reg_write <= 1'b1;
                    o_mem_write <= 1'b0;
                    o_mem_to_reg <= 1'b0;
                    o_pc_4_wb <= 1'b0;
                    o_gpr31 <= 1'b0;
                    //o_mem_width <= 4'bXXXX;
                    o_take_jump <= 1'b0;
                    o_take_jump_r <= 1'b0;
                    o_take_branch <= 1'b0;
                    o_branch_neq <= 1'b0;
                    
                    o_reg_dst <= !i_op_code[4];
                    o_alu_src <= i_op_code[4];
                    
                    if(i_op_code[3:0] == 4'b1000) begin         // (0X) 1000 = Deteccion operacion SLT o SLTI
                    
                        o_less_wb <= 1'b1;
                    
                    end else begin
                    
                        o_less_wb <= 1'b0;
                    
                    end
                end
                
            end else begin                              // 1 = Operaciones tipo I(L-S), Jump y Branch
            
                if(!i_op_code[4]) begin                     // (1) 0 = Operaciones tipo I(L-S)
                
                    o_reg_dst <= 1'b0;
                    o_alu_src <= 1'b1;
                    o_mem_to_reg <= 1'b1;
                    o_pc_4_wb <= 1'b0;
                    o_gpr31 <= 1'b0;
                    o_less_wb <= 1'b0;
                    o_take_jump <= 1'b0;
                    o_take_jump_r <= 1'b0;
                    o_take_branch <= 1'b0;
                    o_branch_neq <= 1'b0;
                    
                    if(!i_op_code[3]) begin                     // (10) 0 = Operaciones tipo I(L)
                    
                        o_reg_write <= 1'b1;
                        o_mem_write <= 1'b0;
                        
                        case(i_op_code[2:0])
                        
                            3'b000: begin
                                o_mem_width <= 4'b0001;
                            end
                            
                            3'b001: begin
                                o_mem_width <= 4'b1001;
                            end
                            
                            3'b010: begin
                                o_mem_width <= 4'b0010;
                            end
                            
                            3'b011: begin
                                o_mem_width <= 4'b1010;
                            end
                            
                            3'b100: begin
                                o_mem_width <= 4'b1100;
                            end
                            
                        endcase

                    end else begin                              // (10) 1 = Operaciones tipo I(S)
                    
                        o_reg_write <= 1'b0;
                        o_mem_write <= 1'b1;
                        o_mem_width <= i_op_code[3:0];
                    
                    end
                    
                end else begin                              // (1) 1 = Operaciones tipo Jump y Branch
                
                    o_reg_dst <= 1'b1;
                    o_alu_src <= 1'b0;
                    o_mem_write <= 1'b0;
                    o_mem_to_reg <= 1'b0;
                    o_pc_4_wb <= 1'b1;
                    //o_mem_width <= 4'bXXXX;
                    //o_less_wb <= 1'bX;
                    
                    if(!i_op_code[2]) begin                     // (11X) 0 = Operaciones tipo Jump
                    
                        o_take_branch <= 1'b0;
                        o_branch_neq <= 1'b0;
                        
                        o_reg_write <= i_op_code[0];
                        o_gpr31 <= !i_op_code[1];
                        o_take_jump <= !i_op_code[1];
                        o_take_jump_r <= i_op_code[1];
                    
                    end else begin                              // (11X) 1 = Operaciones tipo Branch
                    
                        o_reg_write <= 1'b0;
                        //o_gpr31 <= 1'bX;
                        o_take_jump <= 1'b0;
                        o_take_jump_r <= 1'b0;
                        o_take_branch <= 1'b1;
                        
                        o_branch_neq <= i_op_code[0];
                    
                    end
                
                end
                
            end
            
        end
           
    end 
        
    
    
endmodule
