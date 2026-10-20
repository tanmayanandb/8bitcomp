module control_unit_tb();
    reg clk;
    reg rst_n;
    reg [15:0] instruction;
    reg zero_flag;

    wire [1:0] alu_op;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire pc_inc;
    wire [7:0] pc_target;
    wire [1:0] rd;
    wire [1:0] rs;
    wire halt;
    wire [1:0] reg_src;
    wire pc_jmp;

    control_unit dut(clk, rst_n, instruction, zero_flag, alu_op, reg_write, mem_read, mem_write, pc_inc, pc_jmp, pc_target, rd, rs, halt, reg_src);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        instruction = 16'b0;
        zero_flag = 0;
    end

    initial begin
        $dumpfile("control_unit.vcd");
        $dumpvars(0, control_unit_tb);
        $dumpvars(0, control_unit_tb.dut.state);

        #12; rst_n = 1; #1;
        instruction = 16'b0010010100000000;
        zero_flag = 0;
        #100;
        instruction = 16'b0101000100000000;
        #100;
        $finish;
        
    end


endmodule