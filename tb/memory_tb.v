`timescale 1ns/1ps

module memory_tb();

    reg clk;
    reg rst_n;
    reg [7:0] data_addr;
    reg [7:0] data_in;
    reg [7:0] pc;
    reg mem_write;
    reg mem_read;

    wire [7:0] data_out;
    wire [15:0] instruction;

    memory dut(clk, rst_n, data_addr, data_in, pc, mem_read, mem_write, data_out, instruction);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
    end

    initial begin

        $dumpfile("memory.vcd");
        $dumpvars(0, memory_tb);

        #10; rst_n = 1;
        #10;
        data_addr = 0;
        data_in = 2;
        pc = 0;
        mem_write = 1;
        mem_read = 0;

        #10;
        data_addr = 0;
        data_in = 2;
        pc = 0;
        mem_write = 0;
        mem_read = 1;
        #10;

        $finish;

    end

endmodule