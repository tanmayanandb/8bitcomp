module program_counter(
    input clk,
    input rst_n,
    input pc_inc,
    input pc_jmp,
    input [7:0] pc_target, 
    output reg [7:0] pc_out
);

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) pc_out <= 8'b0;
        
        else begin

            if(pc_jmp) pc_out <= pc_target;
            else if(pc_inc) pc_out <= pc_out + 1'b1;
        
        end

    end


endmodule