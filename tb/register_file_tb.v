`timescale 1ns/1ps

module register_file_tb();

    reg wr_en;
    reg [1:0] wr_ad;
    reg [1:0] addr_a;
    reg [1:0] addr_b;
    reg [7:0] wr_data;
    reg clk;
    reg rst_n;  

    wire [7:0] read_a;
    wire [7:0] read_b;
    
    initial begin
        clk = 0;
        rst_n = 0;
    end

    always #5 clk = ~clk;

    register_file dut(clk, rst_n, wr_en, wr_ad, wr_data, addr_a, addr_b, read_a, read_b);

    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        wr_en = 1'b1; wr_ad = 2'b01; addr_a = 2'b01; addr_b = 2'b10; wr_data = 8'b00000011; #10; 
        wr_en = 1'b0; wr_ad = 2'b01; addr_a = 2'b01; addr_b = 2'b10; wr_data = 8'b00000011; #10; 

        $finish;
    end

endmodule