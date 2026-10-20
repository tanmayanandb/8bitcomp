module register_file(
    input clk,
    input rst_n,
    input wr_en,
    input [1:0] wr_ad,
    input [7:0] wr_data,
    input [1:0] addr_a,
    input [1:0] addr_b,
    output reg [7:0] read_a,
    output reg [7:0] read_b
);


    reg [7:0] registers [0:3];
    integer i;


    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin
            for(i=0;i<4;i=i+1) registers[i] = 8'b00000001;
            read_a = 8'b0;
            read_b = 8'b0;
        end

        if(wr_en) begin   
            if(wr_ad == 2'b00) begin
                registers[0] <= wr_data;
            end
            else if(wr_ad == 2'b01) begin
                registers[1] <= wr_data;
            end
            else if(wr_ad == 2'b10) begin
                registers[2] <= wr_data;
            end
            else begin
                registers[3] <= wr_data;
            end
        end

        case(addr_a)
            2'b00: read_a <= registers[0];
            2'b01: read_a <= registers[1];
            2'b10: read_a <= registers[2];
            2'b11: read_a <= registers[3];
        endcase

        case(addr_b)
            2'b00: read_b <= registers[0];
            2'b01: read_b <= registers[1];
            2'b10: read_b <= registers[2];
            2'b11: read_b <= registers[3];
        endcase

    end

endmodule
