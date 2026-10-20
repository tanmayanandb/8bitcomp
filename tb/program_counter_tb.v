`timescale 1ns/1ps

module program_counter_tb(

);

    reg clk;
    reg rst_n;
    reg pc_inc;
    reg pc_jmp;
    reg [7:0] pc_target;
    wire [7:0] pc_out;

    initial begin
        clk = 0;
        rst_n = 0;
        pc_inc = 0; pc_jmp = 0; pc_target = 0; #10;

    end

    always #5 clk = ~clk;

    program_counter dut(clk, rst_n, pc_inc, pc_jmp, pc_target, pc_out);

    initial begin
        $dumpfile("program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        #10; rst_n = 1;

        pc_inc = 1; pc_jmp = 0; pc_target = 0; #10;
        pc_inc = 1; pc_jmp = 0; pc_target = 0; #10;

        $finish;
    end

endmodule
