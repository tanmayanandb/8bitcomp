module cpu_tb();
    reg clk;
    reg rst_n;

    cpu cpu_dut(clk, rst_n);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
    end
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);

        #12; rst_n = 1;
        #100;
        $finish;
    end

endmodule