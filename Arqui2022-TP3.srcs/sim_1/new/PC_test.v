`timescale 1ns / 1ps

module PC_test();
    
    
    reg i_clk;
    reg i_reset;
    reg [31:0] i_pc_next;
    reg i_bloqueo;
    wire [31:0] o_pc;
    
    PC pc0(i_clk, i_reset, i_pc_next, i_bloqueo, o_pc);
    
    initial begin
    
        i_clk = 1;
        i_pc_next = 0;
        i_bloqueo = 0;
        // Primero hacemos un reset
        i_reset = 1;
        
        #5
        i_reset = 0;
        
        #1
        // Asigno un valor al PC
        i_pc_next = 32'h0004;
        #1
        i_pc_next = 32'h000F;
        #1
        i_pc_next = 32'h00FF;
        
        // Checkeo bit de bloqueo
        i_bloqueo = 1;
        #1
        i_pc_next = 32'hFFFF;
        #3
        i_bloqueo = 0;
        #1
        i_pc_next = 32'h0000;
     
    end
        
    // Inicializo el Clk
    always begin
        #0.5
        i_clk = ~i_clk;
    end
endmodule
