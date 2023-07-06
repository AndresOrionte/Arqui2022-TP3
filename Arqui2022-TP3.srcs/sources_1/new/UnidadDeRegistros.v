`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2023 16:54:16
// Design Name: 
// Module Name: UnidadDeRegistros
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


module UnidadDeRegistros(

    input wire i_clk,
    input wire i_reset,
    input wire [4:0] i_reg_lec_1,
    input wire [4:0] i_reg_lec_2,
    input wire [4:0] i_reg_esc,
    input wire [31:0] i_dato_esc,
    input wire i_flag_reg_write,
    
    output reg [31:0] o_dato_1,
    output reg [31:0] o_dato_2
    );
    
    reg [31:0] mem [31:0];
    integer i;
    
    always @(posedge i_clk) begin
    
        if(i_reset) begin
            
            for(i=0; i<32; i=i+1) begin
                mem[i] <= 32'h00000000;
            end
            
        end else begin
            #0.1
            if(i_flag_reg_write & (i_reg_esc != 5'b00000 )) begin
                
                mem[i_reg_esc] = i_dato_esc;
                
            end
        end
    end
    
    always @(negedge i_clk) begin
        
        if(i_reset) begin
            
            o_dato_1 <= 32'h00000000;
            o_dato_2 <= 32'h00000000;
            
        end else begin
            
            o_dato_1 = mem[i_reg_lec_1];
            o_dato_2 = mem[i_reg_lec_2];
            
        end
        
    end 
    
    
endmodule
