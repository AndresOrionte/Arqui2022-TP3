`timescale 1ns / 1ps

module PC(
    
    input wire i_clk,
    input wire i_reset,
    input wire [31:0] i_pc_next,
    input wire i_bloqueo,
    
    output reg [31:0] o_pc
    );

    
    always @(negedge i_clk) begin
    
        if(i_reset) begin                   //// En caso de reset pongo PC a cero
            o_pc <= 32'h00000000;
        end else begin
            if(! i_bloqueo) begin           // En caso de que el bit de bloqueo no este activado, modifico el module PC
                o_pc <= i_pc_next;
            end
        end
        
    end
        
endmodule