module cpu(input clk, rst_n);
    // Program Counter
    wire [7:0] pc_out;
    // Register File
    wire [7:0] read_a;
    wire [7:0] read_b;
    // Memory
    wire [7:0] data_out;
    wire [15:0] instruction;
    // Control Unit
    wire [1:0] alu_op;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire pc_inc;
    wire pc_jmp;
    wire [7:0] pc_target;
    wire [1:0] rd;
    wire [1:0] rs;
    wire halt;
    wire [1:0] reg_src;
    //ALU
    wire [7:0] f;
    wire carry;
    wire zero_flag;

    //
    // wire [7:0] data_addr;
    wire [7:0] data_in;
    reg [7:0] writeback_data;
    wire [7:0] inst_addr;

    //
    // wire [7:0] alu_op_a;
    // wire [7:0] alu_op_b;

    program_counter program_counter_dut(clk, rst_n, pc_inc, pc_jmp, pc_target, pc_out);
    memory memory_dut(clk, rst_n, inst_addr, read_b, pc_out, mem_read, mem_write, data_out, instruction);
    control_unit control_unit_dut(clk, rst_n, instruction, zero_flag, alu_op, reg_write, mem_read, mem_write, pc_inc, pc_jmp, pc_target, rd, rs, halt, reg_src, inst_addr);
    register_file register_file_dut(clk, rst_n, reg_write, rd, writeback_data, rd, rs, read_a, read_b);
    alu alu_dut(read_a, read_b, alu_op, f, carry, zero_flag);

    always @(*) begin
        case(reg_src)
            2'b00: writeback_data = f;
            2'b01: writeback_data = data_out;
            2'b10: writeback_data = read_b;
            default: writeback_data = 8'b0;
        endcase
    end

endmodule