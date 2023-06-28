`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2023 18:03:11
// Design Name: 
// Module Name: MemoriaDeInstrucciones
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


module MemoriaDeInstrucciones
(
    input wire i_clk,
    input wire i_reset,
    input wire [31:0] i_direccion,
    input wire [31:0] i_escritura,
    input wire i_flag_escritura,
    
    output reg [31:0] o_instruccion
);

    reg [7:0] mem [255:0];
    integer i;
    
    always @(negedge i_clk) begin
    
        if(i_reset) begin                   // En caso de reset pongo memoria y salidas a cero
            o_instruccion <= 32'h00000000;
            for(i=0; i<256; i=i+1) begin
                mem[i] <= 8'h00;
            end
        end else begin                      // Si no hay reset entonces voy al funcionamiento normal
            if(i_flag_escritura) begin      // Si esta levantado el flag de escritura escribo la palabra indicada en la posicion indicada
                {mem[i_direccion[7:0]+2'b11], mem[i_direccion[7:0]+2'b10], mem[i_direccion[7:0]+2'b01], mem[i_direccion[7:0]]} = i_escritura;
            end else begin                  // En otro caso saco la instruccion indicada 
                #0.1
                o_instruccion = {mem[i_direccion[7:0]+2'b11], mem[i_direccion[7:0]+2'b10], mem[i_direccion[7:0]+2'b01], mem[i_direccion[7:0]]};
            end
        end
    
    end
endmodule
