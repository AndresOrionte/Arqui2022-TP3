`timescale 1ns / 1ps

module LatchIFID(
    input wire i_clk,
    input wire i_bloqueo,
    input wire [31:0] i_pc_p4, //PC+4
    input wire [31:0] i_instruccion,
    
    output reg [31:0] o_pc_p4,
    output reg [25:0] o_index,     // Bits [25:0] de la instruccion
    output reg [5:0] o_opcode,     // Bits [31:26] de la instruccion
    output reg [4:0] o_reg_lec_1,  // Bits [25:21] de la instruccion
    output reg [4:0] o_reg_lec_2,  // Bits [20:16] de la instruccion
    output reg [15:0] o_inmediato,
    output reg [31:0] o_instruccion
    );
    
    always @(posedge i_clk) begin
    
        if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
            o_pc_p4 <= i_pc_p4;
            o_index <= i_instruccion[25:0];
            o_opcode <= i_instruccion[31:26];
            o_reg_lec_1 <= i_instruccion[25:21];
            o_reg_lec_2 <= i_instruccion[20:16];
            o_inmediato <= i_instruccion[15:0];
            o_instruccion <= i_instruccion;
            
        end
    end    
endmodule
