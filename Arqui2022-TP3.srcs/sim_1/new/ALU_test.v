module ALU_test();

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
    
    reg [31:0]i_A;
    reg [31:0]i_B;
    reg [5:0]i_ALUOp;
    wire [31:0]o_C;
    wire o_carry;
    wire o_zero;
    
    ALU alu(
    .i_A(i_A),
    .i_B(i_B),
    .i_ALUOp(i_ALUOp),
    .o_C(o_C),
    .o_carry(o_carry),
    .o_zero(o_zero)
    );
    
    
    initial begin
    
    //Prueba Suma
    
    i_ALUOp = op_add;
    i_A = 32'h00000001;
    i_B = 32'h00000001;
    
    #10
    //i_ALUOp = op_add;
    i_A = 32'hFFFFFFFF;
    i_B = 32'h00000001;
    
    #10
    //i_ALUOp = op_add;
    i_A = 32'h00000000;
    i_B = 32'h00000000;
    
    #10
    i_ALUOp = op_add;
    i_A = 32'hFFFFFFFF;
    i_B = 32'hFFFFFFFF;
    
    //Prueba resta
    #10
    i_ALUOp = op_sub;
    i_A = 32'h00000010;
    i_B = 32'h00000001;
    
    #10
    i_ALUOp = op_sub;
    i_A = 32'h00000001;
    i_B = 32'h00000001;
    
    #10
    i_ALUOp = op_sub;
    i_A = 32'h00000010;
    i_B = 32'h00000100;
    
    #10
    i_ALUOp = op_sub;
    i_A = 32'h00000000;
    i_B = 32'h00000000;
    
    //Prueba and
    #10
    i_ALUOp = op_and;
    i_A = 32'h00000010;
    i_B = 32'h00000001;
    
    #10
    i_ALUOp = op_and;
    i_A = 32'h000000F0;
    i_B = 32'h000000FF;
    
    //Prueba or
    #10
    i_ALUOp = op_or;
    i_A = 32'h00000FF0;
    i_B = 32'h0000FF0F;
    
    //Prueba xor
    #10
    i_ALUOp = op_xor;
    i_A = 32'h00000FF0;
    i_B = 32'h0000FF0F;
    
    //Prueba sra
    #10
    i_ALUOp = op_sra;
    i_A = 32'h00000002;
    i_B = 32'hF0000000;
    
    #10
    i_ALUOp = op_sra;
    i_A = 32'h00000002;
    i_B = 32'h000000FF;
    
    //Prueba srl
    #10
    i_ALUOp = op_srl;
    i_A = 32'h00000002;
    i_B = 32'hF0000000;
    
    #10
    i_ALUOp = op_srl;
    i_A = 32'h00000002;
    i_B = 32'h000000FF;
    
    //Prueba sll
    #10
    i_ALUOp = op_sll;
    i_A = 32'h00000002;
    i_B = 32'hF0000000;
    
    #10
    i_ALUOp = op_sll;
    i_A = 32'h00000002;
    i_B = 32'h000000FF;
    
    //Prueba nor
    #10
    i_ALUOp = op_nor;
    i_A = 32'h00000110;
    i_B = 32'h00000101;
    
    //Prueba sll16
    #10
    i_ALUOp = op_sll16;
    i_B = 32'h0000F000;
    
    #10
    i_ALUOp = op_sll16;
    i_B = 32'h000000FF;
    
    //Prueba operacion invalida
    #10
    i_ALUOp = 6'b111000;
    i_A = 32'h00000001;
    i_B = 32'h00000001;

    end

endmodule