`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2023 11:04:31
// Design Name: 
// Module Name: UART_Transmitter
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


module UART_Transmitter(
    input wire i_clk,
    input wire i_reset,
    input wire i_tick,
    input wire i_start,
    input wire [7:0] i_word,
    output reg o_tx,
    output reg o_sending
    );
    
    localparam STATE_WAITING = 5'b00001;
    localparam STATE_START = 5'b00010;
    localparam STATE_SEND = 5'b00100;
    localparam STATE_PARITY = 5'b01000;    
    localparam STATE_STOP = 5'b10000;

    reg [4:0] state;
    reg [3:0] tick_counter;
    reg [3:0] bit_counter;
    
    reg start_flag;
    
    reg [7:0]t_word;    // Dato a transmitir
    wire parity_bit;
    
    UART_ParityGen paritygen0(
        .i_word(t_word),
        .o_pbit(parity_bit)
    );
    
    always @(posedge i_clk) begin
        // Reset aborta y vuelve a idle la transmision
        if(i_reset) begin
            state <= STATE_WAITING;
            tick_counter <= 4'h0;
            bit_counter <= 4'h0;
            t_word <= 8'h00;
            o_tx <= 1;
            start_flag <= 0;
            o_sending <= 0;
        end else begin
        
            if(i_start && (!o_sending)) begin
                start_flag <= 1;
                t_word <= i_word;
            end
            
            if(i_tick) begin
            
                // Logica de la cuenta de ticks   
                if(tick_counter < 15) begin
                    tick_counter <= tick_counter + 1'b1;
                end else begin
                    tick_counter <= 4'h0;
                end          
      
                // Maquina de estados del transmisor
                case(state)
                    STATE_WAITING: begin
                        if (start_flag) begin
                            tick_counter <= 4'h0;
                            start_flag <= 0;
                            o_sending <= 1;
                            state <= STATE_START; 
                            o_tx <= 1'b0;   // Envio bit de start
                        end
                    end
                    
                    STATE_START: begin
                        if (tick_counter == 14) begin
                            state = STATE_SEND;   
                        end
                    end
                    
                    STATE_SEND: begin
                        if (tick_counter == 15) begin
                            o_tx <= t_word[bit_counter];
                            bit_counter <= bit_counter + 1'b1;
                            if (bit_counter == 8) begin // Si se enviaron los 8 bits
                                bit_counter <= 4'd0;
                                o_tx <= parity_bit; // Envio bit de paridad
                                state <= STATE_PARITY;
                            end
                        end
                    end
                    
                    STATE_PARITY: begin
                        if (tick_counter == 15) begin
                            o_tx <= 1;  // Bit de stop
                            state <= STATE_STOP;
                        end
                    end
                    
                    STATE_STOP: begin 
                        if (tick_counter == 15) begin
                            t_word <= 8'h00;
                            o_sending <= 0;
                            state <= STATE_WAITING;
                        end
                    end
                    
                    default: begin
                        state <= STATE_WAITING;
                    end
                    
                endcase
            end
        end
    end
     
endmodule