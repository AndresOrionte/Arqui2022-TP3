`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2023 11:15:38
// Design Name: 
// Module Name: UnidadDeCortocircuito
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


module UnidadDeCortocircuito(
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,
    input wire [4:0] i_rd_exmem,
    input wire i_reg_write_exmem,
    input wire [4:0] i_rd_memwb,
    input wire i_reg_write_memwb,
    input wire i_reg_dst,
    input wire i_mem_write_idex,
    
    output reg [1:0] o_forward_a,
    output reg [1:0] o_forward_b,
    output reg [1:0] o_forward_c
    );
    
    always @(*) begin
    
        if(i_reg_write_exmem && (i_rd_exmem==i_rs)) begin
            
            o_forward_a <= 2'b10;
            
        end else if(i_reg_write_memwb && (i_rd_memwb==i_rs)) begin
            
            o_forward_a <= 2'b01;
            
        end else begin
        
            o_forward_a <= 2'b00;
        
        end
    
    end
    
    always @(*) begin
    
        if(i_reg_dst) begin
        
            if(i_reg_write_exmem && (i_rd_exmem==i_rt)) begin
                
                o_forward_b <= 2'b10;
                
            end else if(i_reg_write_memwb && (i_rd_memwb==i_rt)) begin
                
                o_forward_b <= 2'b01;
                
            end else begin
            
                o_forward_b <= 2'b00;
            
            end
            
        end else begin
        
            o_forward_b <= 2'b00;
        
        end
    
    end
    
    always @(*) begin
        
        if(i_mem_write_idex && (i_rd_exmem == i_rt)) begin
            
            o_forward_c <= 2'b10;
            
        end else if(i_mem_write_idex && (i_rd_memwb == i_rt)) begin
            
            o_forward_c <= 2'b01;
            
        end else begin
            
            o_forward_c <= 2'b00;
            
        end
        
    end
    
endmodule
