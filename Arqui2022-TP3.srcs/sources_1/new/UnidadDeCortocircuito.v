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
    input wire [4:0] rs,
    input wire [4:0] rt,
    input wire [4:0] rd_exmem,
    input wire reg_write_exmem,
    input wire [4:0] rd_memwb,
    input wire reg_write_memwb,
    input wire reg_dst,
    
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
    );
    
    always @(*) begin
    
        if(reg_write_exmem && (rd_exmem==rs)) begin
            
            forward_a <= 2'b10;
            
        end else if(reg_write_memwb && (rd_memwb==rs)) begin
            
            forward_a <= 2'b01;
            
        end else begin
        
            forward_a <= 2'b00;
        
        end
    
    end
    
    always @(*) begin
    
        if(reg_dst) begin
        
            if(reg_write_exmem && (rd_exmem==rt)) begin
                
                forward_b <= 2'b10;
                
            end else if(reg_write_memwb && (rd_memwb==rt)) begin
                
                forward_b <= 2'b01;
                
            end else begin
            
                forward_b <= 2'b00;
            
            end
            
        end else begin
        
            forward_b <= 2'b00;
        
        end
    
    end
    
endmodule
