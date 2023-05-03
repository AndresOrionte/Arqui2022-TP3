`timescale 1ns / 1ps

module LatchIDEX(
    input wire i_clk,
    input wire i_bloqueo,
    input wire [31:0] i_pc_p4,
    input wire [31:0] i_resultado,
    input wire [31:0] i_dato_2,
    output reg i_carry,
    output reg [4:0] i_registro_escritura,
    //A partir de aqui las seniales de control
    input wire i_LessWB,
    input wire [3:0] i_MemWidth,
    input wire i_PC4WB,
    input wire i_MemtoReg,
    input wire i_MemWrite,
    input wire i_RegWrite,
    
    output reg [31:0] o_pc_p4,
    output reg [31:0] o_resultado,
    output reg [31:0] o_dato_2,
    output reg o_carry,
    output reg [4:0] o_registro_escritura,
    // De control
    output reg o_LessWB,
    output reg [3:0] o_MemWidth,
    output reg o_PC4WB,
    output reg o_MemtoReg,
    output reg o_MemWrite,
    output reg o_RegWrite,
    );
    
    always @(posedge i_clk) begin
    
        if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
            o_pc_p4 <= i_pc_p4;
            o_resultado <= i_resultado;
            o_dato_2 <= i_dato_2;
            o_carry <= i_carry;
            o_registro_escritura <= i_registro_escritura;
            o_LessWB <= i_LessWB;
            o_MemWidth <= i_MemWidth;
            o_PC4WB <= i_PC4WB;
            o_MemtoReg <= i_MemtoReg;
            o_MemWrite <= i_MemWrite;
            o_RegWrite <= i_RegWrite;     
            
        end
    end    
endmodule