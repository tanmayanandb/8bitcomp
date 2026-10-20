

module control_unit(
    input clk,
    input rst_n,
    input [15:0] instruction,
    input zero_flag,

    output reg [1:0] alu_op,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg pc_inc,
    output reg pc_jmp,
    output reg [7:0] pc_target,
    output reg [1:0] rd,
    output reg [1:0] rs,
    output reg halt,
    output reg [1:0] reg_src,
    output reg [7:0] inst_addr

);


    localparam FETCH = 3'b000;
    localparam DECODE = 3'b001;
    localparam EXECUTE = 3'b010;
    localparam MEMORY = 3'b011;
    localparam WRITEBACK = 3'b100;
    localparam HALT = 3'b101;

    localparam MOV = 4'b0001;
    localparam LOAD = 4'b0010;
    localparam STORE = 4'b0011;
    localparam ADD = 4'b0100;
    localparam SUBTRACT = 4'b0101;
    localparam XOR = 4'b0110;
    localparam MULTIPLY = 4'b0111;

    reg [2:0] state, next_state;
    reg [15:0] ir;

    
    // state manager - sync
    // assuming async instruction fetching

    always @(posedge clk or negedge rst_n) begin
        
        if(!rst_n) begin
            state <= FETCH;
            ir<=0;
        end
        else begin
            state <= next_state;
            if(state == FETCH) ir <= instruction;
        end

    end

    always @(*) begin

        next_state = state;
        // alu_op = 0;
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        pc_inc = 0;
        pc_jmp = 0;
        pc_target = 0;
        rd = ir[11:10];
        rs = ir[9:8];
        halt = 0;   
        reg_src = 0;
        inst_addr = ir[7:0];

        case(ir[15:12])

            ADD: begin
                alu_op = 2'b00;
            end

            SUBTRACT: begin
                alu_op = 2'b01;
            end

            XOR: begin
                alu_op = 2'b10;
            end

            MULTIPLY: begin
                alu_op = 2'b11;
            end

            default: alu_op = 2'b00;

        endcase

        case(state)
            FETCH: begin 
                next_state = DECODE;
            end

            DECODE: begin 
                case(ir[15:12])
                    MOV: next_state = WRITEBACK;
                    LOAD: next_state = MEMORY;
                    STORE: next_state = MEMORY;
                    ADD: next_state = EXECUTE;
                    SUBTRACT: next_state = EXECUTE;
                    XOR: next_state = EXECUTE;
                    MULTIPLY: next_state = EXECUTE;
                    default: next_state = FETCH;
                endcase
                pc_inc = 1;
            end

            EXECUTE: begin
                case(ir[15:12])

                    ADD: begin
                        next_state = WRITEBACK;
                    end

                    SUBTRACT: begin
                        next_state = WRITEBACK;
                    end

                    XOR: begin
                        next_state = WRITEBACK;
                    end

                    MULTIPLY: begin
                        next_state = WRITEBACK;
                    end

                    default: begin
                        next_state = FETCH;

                    end

                endcase
            end
            
            MEMORY:begin
                if(ir[15:12] == STORE) begin
                    mem_write = 1;
                    next_state = FETCH;
                end
                else begin
                    mem_read = 1;
                    next_state = WRITEBACK;
                end
            end

            WRITEBACK: begin 
                if(ir[15:12] == ADD || ir[15:12] == SUBTRACT || ir[15:12] == MULTIPLY || ir[15:12] == XOR) begin
                    reg_src = 2'b00;
                end
                else if(ir[15:12] == LOAD) reg_src = 2'b01;
                else reg_src = 2'b10;

                reg_write = 1;
                next_state = FETCH;
            end

            HALT: next_state = HALT;

            default: next_state = FETCH;

        endcase
        
    end


endmodule