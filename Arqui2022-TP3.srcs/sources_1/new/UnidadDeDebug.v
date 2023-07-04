`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2023 16:50:23
// Design Name: 
// Module Name: UnidadDeDebug
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


module UnidadDeDebug(
    input wire i_clk,
    input wire i_reset,
    
    input wire i_eor,
    input wire i_err,
    input wire [7:0] i_recept_byte,
    input wire i_sending_flag,
    
    input wire [31:0] i_PC,
    input wire [31:0] i_dato_reg,
    input wire [31:0] i_dato_mem_datos,
    input wire [5:0] i_OP_code,
    
    output reg o_send_start,
    output reg [7:0] o_send_byte,
    
    output reg o_reset,
    output reg o_reset_PC,
    
    output reg o_block,
    output reg o_sel_mem_instr,
    output reg o_flag_esc_mem_instr,
    output reg [31:0] o_dir_mem_instr,
    output reg [31:0] o_dato_mem_instr,
    output reg o_sel_un_reg,
    output reg [4:0] o_dir_un_reg,
    output reg o_sel_mem_datos,
    output reg [31:0] o_dir_mem_datos,
    output wire [3:0] o_state
    );
    
    localparam STATE_WAITING = 4'b0001;
    localparam STATE_PROGRAM = 4'b0010;
    localparam STATE_CONTINUOUS = 4'b0100;
    localparam STATE_STEP = 4'b1000;
       
    
    localparam C_ascii = 8'h43;
    localparam P_ascii = 8'h50;
    localparam R_ascii = 8'h52;
    localparam S_ascii = 8'h53;
    localparam X_ascii = 8'h58;
    
    reg [3:0] state;
    
    reg state_program_flag;
    reg [7:0] state_program_size;
    reg [7:0] state_program_pointer;
    reg [1:0] state_program_byte_counter;
    reg [31:0] state_program_instruction; 
    
    reg state_step_flag;
    
    reg read_call_flag;
    reg read_flag;
    
    reg read_change_flag;
    reg [4:0] read_pointer;
    reg [31:0] read_send_word;
    reg [1:0] read_byte_counter;
    reg [1:0] read_stage;
    
    reg halt_found_flag;
    reg [1:0] post_halt_counter;
    
    assign o_state = state;
    
    always @(posedge i_clk) begin
        
        if(i_reset) begin
            
            state <= STATE_WAITING;
            o_reset <= 1'b1;
            o_block <= 1'b1;
            
            o_reset_PC <= 1'b0;
            
            o_send_start <= 1'b0;
            o_send_byte <= 8'h00;
            
            o_sel_mem_instr <= 1'b0;
            o_flag_esc_mem_instr <= 1'b0;
            o_dir_mem_instr <= 32'h00000000;
            o_dato_mem_instr <= 32'h00000000;
            o_sel_un_reg <= 1'b0;
            o_dir_un_reg <= 5'b00000;
            o_sel_mem_datos <= 1'b0;
            o_dir_mem_datos <= 32'h00000000;
            
            state_program_flag <= 1'b0;
            state_program_size <= 8'h00;
            state_program_pointer <= 8'h00;
            state_program_byte_counter <= 2'b00;
            state_program_instruction <= 32'h00000000;
            
            halt_found_flag <= 1'b0;
            post_halt_counter <= 2'b00;
            
            state_step_flag <= 1'b0;
            
            read_call_flag <= 1'b0;
            read_flag <= 1'b0;
            
            read_change_flag <= 1'b0;
            read_pointer <= 5'b00000;
            read_send_word <= 32'h00000000;
            read_byte_counter <= 2'b00;
            read_stage <= 2'b00;
            
        end else if(read_call_flag) begin
                
            // Preparacion para comenzar la lectura
            read_call_flag <= 0;
            read_flag <= 1;
            read_change_flag <= 1'b1;
            read_pointer <= 5'b00000;
            read_byte_counter <= 2'b00;
            read_stage <= 2'b00;
            
            o_block <= 1'b1;
            
        end else if(read_flag) begin
            
            if(!i_sending_flag) begin
                
                if(read_change_flag == 1'b1) begin
                    
                    o_send_start <= 1'b0;
                    
                    if(read_stage == 2'b00) begin
                        
                        read_send_word <= i_PC;
                        read_stage <= 2'b01;
                        
                    end else if(read_stage == 2'b01) begin
                        
                        o_sel_un_reg <= 1'b1;
                        o_dir_un_reg <= read_pointer;
                        read_pointer <= read_pointer + 1;
                        read_send_word <= i_dato_reg;
                        
                        if(read_pointer == 5'b11111) begin
                            
                            read_stage <= 2'b10;
                            
                        end
                        
                    end else if(read_stage == 2'b10) begin
                        
                        o_sel_un_reg <= 1'b0;
                        o_sel_mem_datos <= 1'b1;
                        o_dir_mem_datos <= read_pointer << 2;
                        read_pointer <= read_pointer + 1;
                        read_send_word <= i_dato_mem_datos;
                        
                        if(read_pointer == 5'b11111) begin
                            
                            read_stage <= 2'b11;
                            
                        end
                        
                    end else begin
                        
                        o_sel_mem_datos <= 1'b0;
                        read_flag <= 1'b0;
                        
                    end
                    
                    read_change_flag <= 1'b0;
                    
                end else begin
                    
                    o_send_byte <= read_send_word [31:24];
                    o_send_start <= 1'b1;
                    read_send_word <= read_send_word << 8;
                    read_byte_counter <= read_byte_counter + 1'b1;
                    
                    if(read_byte_counter == 2'b11) begin
                        
                        read_change_flag <= 1'b1;
                        
                    end
                    
                end
                
            end else begin
                
                o_send_start <= 1'b0;
                
            end
            
        end else begin
            
            case(state)
            
                STATE_WAITING: begin
                    
                    o_reset <= 1'b0;
                    o_block <= 1'b1;
                    
                    o_sel_mem_instr <= 1'b0;
                    o_flag_esc_mem_instr <= 1'b0;
                    o_sel_un_reg <= 1'b0;
                    o_sel_mem_datos <= 1'b0;
                    
                    if(i_eor) begin
                        
                        case(i_recept_byte)
                        
                            R_ascii: begin
                                o_reset <= 1'b1;
                            end
                            
                            P_ascii: begin
                                state <= STATE_PROGRAM;
                                state_program_flag <= 1;
                            end
                            
                            C_ascii: begin
                                state <= STATE_CONTINUOUS;
                                o_reset_PC <= 1'b1;
                            end
                            
                            S_ascii: begin
                                state <= STATE_STEP;
                                state_step_flag <= 1'b1;
                                o_reset_PC <= 1'b1;
                            end
                            
                        endcase
                    
                    end
                    
                end
                
                STATE_PROGRAM: begin
                    
                    if(i_eor) begin
                        
                        if(state_program_flag) begin
                            
                            state_program_flag <= 1'b0;
                            state_program_size <= i_recept_byte;
                            state_program_pointer <= 8'h00;
                            state_program_byte_counter <= 2'b00;
                             
                        end else begin
                        
                            state_program_instruction = state_program_instruction << 8;
                            state_program_instruction[7:0] = i_recept_byte;
                            state_program_byte_counter = state_program_byte_counter + 1;
                            
                            if(state_program_byte_counter == 0) begin
                                    
                                o_sel_mem_instr <= 1'b1;
                                o_flag_esc_mem_instr <= 1'b1;
                                o_dir_mem_instr <= state_program_pointer;
                                o_dato_mem_instr <= state_program_instruction;
                                
                                state_program_size <= state_program_size - 1;
                                state_program_pointer <= state_program_pointer + 4;
                                
                            end
                            
                        end
                        
                    end else begin
                        
                        o_sel_mem_instr <= 1'b0;
                        o_flag_esc_mem_instr <= 1'b0;
                        
                    end
                    
                    if(state_program_size == 0 & !state_program_flag) begin
                        
                        state <= STATE_WAITING;
                        
                    end
                    
                end
                
                STATE_CONTINUOUS: begin
                    
                    if(halt_found_flag == 1'b0) begin
                        
                        if(i_OP_code != 6'b111111) begin
                            
                            o_block <= 1'b0; 
                            o_reset_PC <= 1'b0;
                            
                        end else begin
                            
                            post_halt_counter <= 2'b00;
                            halt_found_flag <= 1'b1;
                            
                        end
                        
                    end else begin
                        
                        if(post_halt_counter != 2'b01) begin
                            
                            post_halt_counter <= post_halt_counter + 1;
                            
                        end else begin
                            
                            halt_found_flag <= 1'b0;
                            o_block <= 1'b1;
                            state <= STATE_WAITING;
                            read_call_flag <= 1'b1;
                            
                        end
                        
                    end
                    
                end
                
                STATE_STEP: begin
                    
                    if(state_step_flag) begin
                        
                        state_step_flag <= 1'b0;
                        o_block <= 1'b0;
                        o_reset_PC <= 1'b0;
                        read_call_flag <= 1'b1;
                        
                    end else begin
                                          
                        if(halt_found_flag == 1'b0) begin
                            
                            o_block <= 1'b1;
                        
                            if(i_OP_code == 6'b111111) begin
                                
                                halt_found_flag <= 1'b1;
                                post_halt_counter <= 2'b00;
                                
                            end else if(i_eor) begin
                                
                                case(i_recept_byte)
                                    
                                    C_ascii: begin
                                        
                                        state <= STATE_CONTINUOUS;
                                        
                                    end
                                    
                                    S_ascii: begin
                                        
                                        state_step_flag <= 1'b1;
                                        
                                    end
                                    
                                    X_ascii: begin
                                        
                                        state <= STATE_WAITING;
                                        
                                    end
                                    
                                endcase
                                
                            end
                            
                        end else begin
                            
                            if(post_halt_counter != 2'b01) begin
                                
                                post_halt_counter <= post_halt_counter + 1;
                                
                            end else begin
                                
                                halt_found_flag <= 1'b0;
                                o_block <= 1'b1;
                                state <= STATE_WAITING;
                                read_call_flag <= 1'b1;
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            endcase
            
        end
    end
    
endmodule
