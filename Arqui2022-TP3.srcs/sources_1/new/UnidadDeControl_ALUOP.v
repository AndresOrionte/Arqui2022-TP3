`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2023 20:55:48
// Design Name: 
// Module Name: UnidadDeControl_ALUOP
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


module UnidadDeControl_ALUOP(

    input wire i_reset,
    input wire [5:0] i_op_code,
    
    output reg [5:0] o_alu_op

    );
    
    always @(*) begin
    
        if(i_reset) begin
        
            o_alu_op <= 6'b000000;
        
        end else begin
        
            if(!i_op_code[5]) begin                     // 0 = Operaciones R e I(Inm)
            
                if(!i_op_code[3]) begin                 // (0X) 0 
                
                    o_alu_op[5:3] <= 3'b000;
                    o_alu_op[2:0] <= i_op_code[2:0];
                
                end else begin                          // (0X) 1
                
                    if(i_op_code[2:0] == 3'b000) begin  // (0X1) 000
                    
                        o_alu_op <= 6'b000010;
                    
                    end else begin                      // (0X1) XXX
                    
                        o_alu_op[5:3] <= i_op_code[2:0];
                        o_alu_op[2:0] <= 3'b000; 
                    
                    end
                
                end
            
            end else begin                              // 1 = Operaciones I(L-S), Jump y Branch.
            
                if(!i_op_code[4]) begin                 // (1) 0 = Operaciones I(L-S)
                
                    o_alu_op <= 6'b000001;
                
                end else begin                          // (1) 1 = Operaciones Jump y Branch
                
                    o_alu_op[5:2] <= 4'b0000;
                    o_alu_op[1] <= i_op_code[2];
                    o_alu_op[0] <= 1'b0; 
                
                end
                
            end
        
        end
    
    end
    
endmodule