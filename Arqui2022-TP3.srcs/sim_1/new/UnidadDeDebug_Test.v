`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 18:53:10
// Design Name: 
// Module Name: UnidadDeDebug_Test
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


module UnidadDeDebug_Test();


    reg i_clk;
    reg i_reset;
    reg i_eor;
    reg i_err;
    reg [7:0] i_recept_byte;
    reg i_sending_flag;
    reg [31:0] i_PC;
    reg [31:0] i_dato_reg;
    reg [31:0] i_dato_mem_datos;
    reg [5:0] i_OP_code;
    
    wire o_send_start;
    wire [7:0] o_send_byte;
    wire o_reset;
    wire o_reset_PC;
    wire o_block;
    wire o_sel_mem_instr;
    wire o_flag_esc_mem_instr;
    wire [31:0] o_dir_mem_instr;
    wire [31:0] o_dato_mem_instr;
    wire o_sel_un_reg;
    wire [31:0] o_dir_un_reg;
    wire o_sel_mem_datos;
    wire [31:0] o_dir_mem_datos;
    
    UnidadDeDebug UD0(
    i_clk,
    i_reset,
    i_eor,
    i_err,
    i_recept_byte,
    i_sending_flag,
    i_PC,
    i_dato_reg,
    i_dato_mem_datos,
    i_OP_code,
    o_send_start,
    o_send_byte,
    o_reset,
    o_reset_PC,
    o_block,
    o_sel_mem_instr,
    o_flag_esc_mem_instr,
    o_dir_mem_instr,
    o_dato_mem_instr,
    o_sel_un_reg,
    o_dir_un_reg,
    o_sel_mem_datos,
    o_dir_mem_datos
    );
    
    initial begin
        
        i_clk = 1;
        i_reset = 1;
        i_eor = 0;
        i_err = 0;
        i_recept_byte = 0;
        i_sending_flag = 0;
        i_PC = 0;
        i_dato_reg = 0;
        i_dato_mem_datos = 0;
        i_OP_code = 0;
        
        #10
        i_reset = 0;
        
        // PRUEBA RESET
        
        #10 //R
        i_eor = 1;
        i_recept_byte = 'h52;
        #1
        i_eor = 0;
        
        // PRUEBA PROGRAMACION
        
        #99 //P
        i_eor = 1;
        i_recept_byte = 'h50;
        #1
        i_eor = 0;
        
        #9 // Cantidad de instrucciones, como son 2, luego debo recibir 8 bytes 
        i_eor = 1;
        i_recept_byte = 2;
        #1
        i_eor = 0;
        
        #9
        i_eor = 1;
        i_recept_byte = 'h00;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h11;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h22;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h33;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h44;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h55;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h66;
        #1
        i_eor = 0;
        #9
        i_eor = 1;
        i_recept_byte = 'h77;
        #1
        i_eor = 0;
        
        // PRUEBA CONTINUOUS
        
        #99 //C
        i_eor = 1;
        i_recept_byte = 'h43;
        #1
        i_eor = 0;
        
        #9
        i_OP_code = 6'b111111;
        i_PC = 32'hAABBCCDD; // Agregado solo para probar read
        i_dato_reg = 32'h33445566; // Agregado solo para probar read
        #1
        i_OP_code = 6'b000000;

        // PRUEBA STEP 1
        
        #499 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        
        #499 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        
        #499 //C
        i_eor = 1;
        i_recept_byte = 'h43;
        #1
        i_eor = 0;
        
        #499
        i_OP_code = 6'b111111;
        #1
        i_OP_code = 6'b000000;
        
        // PRUEBA STEP 2
        
        #499 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        
        #499 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        #1
        i_OP_code = 6'b111111;
        #1
        i_OP_code = 6'b000000;
        
        // PRUEBA STEP 3
        
        #497 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        
        #499 //S
        i_eor = 1;
        i_recept_byte = 'h53;
        #1
        i_eor = 0;
        
        #499 //X
        i_eor = 1;
        i_recept_byte = 'h58;
        #1
        i_eor = 0;
        
        
    end
    
    // Clk de periodo 1
    always begin
        #0.5
        i_clk = ~i_clk;
    end
    
endmodule
