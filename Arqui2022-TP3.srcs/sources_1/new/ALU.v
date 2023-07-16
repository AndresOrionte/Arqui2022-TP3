`timescale 1ns / 1ps

module ALU
(
    input wire [31:0] i_A,
    input wire [31:0] i_B,
    input wire [5:0] i_ALUOp,
    output wire [31:0] o_C,
    output wire o_carry,
    output wire o_zero
    );
    
    localparam op_add = 6'b000001;
    localparam op_sub = 6'b000010;
    localparam op_and = 6'b000011;
    localparam op_or = 6'b000100;
    localparam op_xor = 6'b000101;
    localparam op_nor = 6'b000110;
    localparam op_sll16 = 6'b000111;
    localparam op_sra = 6'b001000;
    localparam op_srl = 6'b010000;
    localparam op_sll = 6'b100000;
    
    reg [32:0]result;
    
    assign o_C = result;
    assign o_carry = result[32];
    assign o_zero = ~|result;
    
    always @* begin
        case (i_ALUOp)
        op_add: begin
            result = i_A + i_B;
            end
        op_sub: begin
            result = i_A - i_B;
            end
        op_and: begin
            result = i_A & i_B;
            end
        op_or: begin
            result = i_A | i_B;
            end
        op_xor: begin
            result = i_A ^ i_B;
            end
        op_nor: begin
            result = ~(i_A | i_B);
            end
        op_sll16: begin
           result = i_B << 16;
            end
        op_sra: begin
            result =  $signed(i_A) >>> i_B;
            end
        op_srl: begin
            result = i_A >> i_B;
            end
        op_sll: begin
            result = i_A << i_B;
            end
        default: begin
            result = {32{1'b0}};
            end
            
        endcase    
    end
    
    
endmodule