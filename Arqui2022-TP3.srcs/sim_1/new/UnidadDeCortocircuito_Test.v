`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2023 10:04:40
// Design Name: 
// Module Name: UnidadDeCortocircuito_Test
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


module UnidadDeCortocircuito_Test();

    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd_exmem;
    reg reg_write_exmem;
    reg [4:0] rd_memwb;
    reg reg_write_memwb;
    reg reg_dst;
    reg mem_write_idex;
    
    wire [1:0] forward_a;
    wire [1:0] forward_b;
    wire [1:0] forward_c;

    UnidadDeCortocircuito UC_0 (rs, rt, rd_exmem, reg_write_exmem, rd_memwb, reg_write_memwb, reg_dst, mem_write_idex, forward_a, forward_b, forward_c);

    always begin
        
        rs = 5'b00100;
        rt = 5'b00110;
        rd_exmem = 5'b00001;
        reg_write_exmem = 0;
        rd_memwb = 5'b00010;
        reg_write_memwb = 0;
        reg_dst = 0;
        mem_write_idex = 0;
        
        // Levantamos flags pero sin cambiar las condiciones no deberia haber cambios
        #1
        reg_dst = 1;
        mem_write_idex = 1;
        reg_write_exmem = 1;
        reg_write_memwb = 1;
        
        // A deberia forwardear desde exmem y B desde memwb
        #1
        rd_exmem = 5'b00100;
        rd_memwb = 5'b00110;
        
        // B deberia forwardear desde exmem y A desde memwb
        #1
        rd_exmem = 5'b00110;
        rd_memwb = 5'b00100;
        
        // B deberia dejar de forwardear
        #1
        mem_write_idex = 0;
        reg_dst = 0;
        
        // B deberia volver a forwardear
        #1
        reg_dst = 1;
        
        // A y B deberian dejar de forwardear
        #1
        reg_write_exmem = 0;
        reg_write_memwb = 0;
        
        // Probamos que ante un cumplimiento de condiciones para forward desde exmem y memwb se elija exmem
        #1
        rs = 5'b00001;
        rt = 5'b00001;
        rd_exmem = 5'b00001;
        reg_write_exmem = 1;
        rd_memwb = 5'b00001;
        reg_write_memwb = 1;

        #1
        rs = 0;
        rt = 0;
        
    end

endmodule
