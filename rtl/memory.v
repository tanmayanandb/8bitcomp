module memory(
    input clk,
    input rst_n,
    input [7:0] data_addr,
    input [7:0] data_in,
    input [7:0] pc,
    input mem_read,
    input mem_write,

    output reg [7:0] data_out,
    output reg [15:0] instruction
);

    reg [15:0] instruction_rom [0:255];

    reg [7:0] data_ram [0:255];

    integer i;

    initial begin
        $readmemb("./programs/program.bin", instruction_rom);
    end

    always @(*) begin
        if(!rst_n) begin
            data_out = 0;
            instruction = 0;
        end
        else begin
            if(mem_read) begin
                data_out = data_ram[data_addr];
            end
            else begin
                data_out = 0;   
            end
            instruction = instruction_rom[pc];
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin

            for(i=0;i<256;i=i+1) data_ram[i] <= 2;
        end
        else begin
            if(mem_write) begin
                data_ram[data_addr] <= data_in;
            end
        end
    end


endmodule

// Aync read, sync write