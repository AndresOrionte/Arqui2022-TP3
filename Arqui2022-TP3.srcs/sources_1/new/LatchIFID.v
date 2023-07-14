`timescale 1ns / 1ps

module LatchIFID(
    input wire i_clk,
    input wire i_reset,
    input wire i_bloqueo,
    input wire [31:0] i_pc_p4, //PC+4
    input wire [31:0] i_instruccion,
    
    output reg [31:0] o_pc_p4,
    output wire [31:0] o_instruccion
    );
    
    assign o_instruccion = i_instruccion;
    
    always @(posedge i_clk) begin
        
        if(i_reset) begin
            
            o_pc_p4 <= 32'h00000000;
        
        end else begin
        
            if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
                
                o_pc_p4 <= i_pc_p4;
                
            end
        end   
    end    

endmodule
