module alu_tb();
    reg [7:0] a;
    reg [7:0] b;
    reg [1:0] opcode;
    wire [7:0] f;
    wire carry;
    wire zero;

    alu dut(a, b, opcode, f, carry, zero);
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        a = 8'b10000001;
        b = 8'b10000001;
        opcode = 2'b00;

        #10;

        a = 8'b00000010;
        b = 8'b00000001;
        opcode = 2'b01;

        #10;

        a = 8'b00000001;
        b = 8'b00000001;
        opcode = 2'b10;

        #10;

        $finish; 
    end

endmodule
