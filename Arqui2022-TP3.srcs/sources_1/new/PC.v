`timescale 1ns / 1ps

module PC(
    input wire [31:0] i_pc_next,
    input wire i_clk,
    input wire i_bloqueo,
    
    output reg [31:0] o_pc
    );

    
    always @(posedge i_clk) begin
    
        if(i_bloqueo) begin         // En caso de que el bit de bloqueo este activado, no modifico el module PC
        
        end else begin              // Si no esta activado el bloqueo, entonces modifico el PC
            o_pc = i_pc_next;
        end
    end
        
endmodule