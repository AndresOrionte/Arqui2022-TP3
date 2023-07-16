`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:04:31
// Design Name: 
// Module Name: UART_Receiver
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

module UART_Receiver
(
    input wire i_clk,
    input wire i_reset,
    input wire i_tick,
    input wire i_rx,
    output reg [7:0] o_word,
    output reg o_eor,
    output reg o_err
);

    localparam state_waiting = 4'b0001;
    localparam state_start = 4'b0010;
    localparam state_recept = 4'b0100;
    localparam state_stop = 4'b1000;
    
    
    reg [3:0] state;
    reg [3:0] tick_counter;
    reg [3:0] bit_counter;
    
    reg parity;
    wire parity_check;
    
    reg eor_flag;
    reg err_flag;
    
    UART_ParityGen paritygen0(
        .i_word(o_word),
        .o_pbit(parity_check)
    );
    
    
    // Como la variable i_ticks no es clock como lo puedo hacer sincronico a i_ticks? 
    // Cuando hay varias asignaciones no bloqueantes de la misma variable dentro de uno o varios bloques always se asigna siempre la ultima?
    
    always @(posedge i_clk) begin
        // Reset con prioridad sobre el resto de condiciones
        if(i_reset) begin
            state <= state_waiting;
            tick_counter <= 4'h0;
            bit_counter <= 4'h0;
            o_word <= 8'h00;
            parity <= 1'b0;
            o_eor <= 0;
            o_err <= 0;
            eor_flag <= 0;
            err_flag <= 0;
        end else begin
        
            //Logica para activacion de salidas (Necesaria por el sincronismo por clk). 
            //Dado que cada salida debe permancer levantada no mas de un clock (cuando los estados tienen duracion de ticks),
            //se hace necesario este sistema.
            
            if(eor_flag) begin
                o_eor <= 0;
                eor_flag <= 0;
            end 
            
            if(err_flag) begin
                o_err <= 0;
                err_flag <= 0;
            end 
        
            // Dado que la maquina avanza por ticks, comprobamos si tenemos un tick;
            if (i_tick) begin
                // Logica de la cuenta de ticks
                if(tick_counter < 15) begin
                    tick_counter <= tick_counter + 1'b1;
                end else begin
                    tick_counter <= 4'h0;
                end
                
                //Maquina de estados del receptor
                case(state)
            
                    state_waiting: begin
                        if(!i_rx) begin
                            state <= state_start;
                            tick_counter <= 4'h0;
                        end
                    end
                    
                    state_start: begin
                        if(tick_counter >= 7) begin
                            if(!i_rx) begin
                                state <= state_recept;
                                tick_counter <= 4'h0;
                            end else begin
                                state <= state_waiting;
                            end  
                        end
                    end
                    
                    state_recept: begin
                        if(tick_counter == 15) begin
                            if(bit_counter <= 7) begin
                                o_word[bit_counter] <= i_rx;
                                bit_counter <= bit_counter + 1'b1;
                            end else begin
                                parity <= i_rx;
                                bit_counter <= 0;
                                state <= state_stop;
                            end
                        end
                    end
                    
                    state_stop: begin
                        if(tick_counter == 15) begin
                            if(i_rx) begin
                                if(parity == parity_check) begin
                                    o_eor <= 1;
                                    eor_flag <= 1;
                                end else begin
                                    o_err <= 1;
                                    err_flag <= 1;
                                end
                            end else begin
                                o_err <= 1;
                                err_flag <= 1;
                            end
                        state <= state_waiting;
                        end
                    end
                    
                    default: begin
                        state <= state_waiting;
                    end
                          
                endcase
            end
        end
    end
            
endmodule
