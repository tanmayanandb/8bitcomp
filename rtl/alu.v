
module alu(input [7:0] a, input [7:0] b, input [1:0] opcode,  output reg [7:0] f, output reg carry, output zero);
    always @(*) begin
        case(opcode)
            2'b00: {carry, f} = a+b;
            2'b01: {carry, f} = a-b;
            2'b10: {carry, f} = a^b;
            2'b11: {carry, f} = a*b;
        endcase
    end

    assign zero = (f == 8'b00000000);
endmodule