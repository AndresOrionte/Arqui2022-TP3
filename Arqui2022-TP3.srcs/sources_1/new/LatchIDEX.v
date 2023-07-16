`timescale 1ns / 1ps

module LatchIDEX(
    input wire i_clk,
    input wire i_reset,
    input wire i_bloqueo,
    input wire [31:0] i_pc_p4,
    input wire [31:0] i_dato_1,
    input wire [31:0] i_dato_2,
    input wire [31:0] i_operando_b,
    input wire [31:0] i_instruccion,
    input wire [5:0] i_ALUOp,
    //A partir de aqui las seniales de control
    input wire i_LessWB,
    input wire [3:0] i_MemWidth,
    input wire i_GPR31,
    input wire i_PC4WB,
    input wire i_RegDst,
    input wire i_MemtoReg,
    input wire i_MemWrite,
    input wire i_RegWrite,
    input wire i_TakeJumpR,
    input wire i_TakeBranch,
    input wire i_BranchNEQ,
    input wire i_Halt,
    //De la unidad de deteccion de riesgo
    input wire i_PostBloqueo,
    
    output reg [31:0] o_pc_p4,
    output reg [31:0] o_dato_1,
    output reg [31:0] o_dato_2,
    output reg [31:0] o_operando_b,
    output reg [31:0] o_instruccion,
    output reg [5:0] o_ALUOp,
    // De control
    output reg o_LessWB,
    output reg [3:0] o_MemWidth,
    output reg o_GPR31,
    output reg o_PC4WB,
    output reg o_RegDst,
    output reg o_MemtoReg,
    output reg o_MemWrite,
    output reg o_RegWrite,
    output reg o_TakeJumpR,
    output reg o_TakeBranch,
    output reg o_BranchNEQ,
    output reg o_Halt,
    // Deteccion de riesgo
    output reg o_PostBloqueo
    );
    
    always @(posedge i_clk) begin
    
        if(i_reset) begin
        
            o_pc_p4 <= 32'h00000000; 
            o_dato_1 <= 32'h00000000;
            o_dato_2 <= 32'h00000000;
            o_operando_b <= 32'h00000000;
            o_instruccion <= 32'h00000000;
            o_ALUOp <= 6'h00;
            o_LessWB <= 1'b0;
            o_MemWidth <= 4'h0;
            o_GPR31 <= 1'b0;
            o_PC4WB <= 1'b0;
            o_RegDst <= 1'b0;
            o_MemtoReg <= 1'b0;
            o_MemWrite <= 1'b0;
            o_RegWrite <= 1'b0;
            o_TakeJumpR <= 1'b0;
            o_TakeBranch <= 1'b0;
            o_BranchNEQ <= 1'b0;
            o_PostBloqueo <= 1'b0;
            o_Halt <= 1'b0;
        
        end else begin
        
            if(! i_bloqueo) begin         // En caso de que el bit de bloqueo no este activado, acciono el latch
                o_pc_p4 <= i_pc_p4;
                o_dato_1 <= i_dato_1;
                o_dato_2 <= i_dato_2;
                o_operando_b <= i_operando_b;
                o_instruccion <= i_instruccion;
                o_ALUOp <= i_ALUOp;
                o_LessWB <= i_LessWB;
                o_MemWidth <= i_MemWidth;
                o_GPR31 <= i_GPR31;
                o_PC4WB <= i_PC4WB;
                o_RegDst <= i_RegDst;
                o_MemtoReg <= i_MemtoReg;
                o_MemWrite <= i_MemWrite;
                o_RegWrite <= i_RegWrite;
                o_TakeJumpR <= i_TakeJumpR;
                o_TakeBranch <= i_TakeBranch;
                o_BranchNEQ <= i_BranchNEQ;
                o_PostBloqueo <= i_PostBloqueo;           
                o_Halt <= i_Halt;           
            end
        end
    end   
     
endmodule