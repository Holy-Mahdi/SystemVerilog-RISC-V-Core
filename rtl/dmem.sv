module dmem (
    input logic clk,
    input logic we,
    input logic [31:0] addr,
    input logic [31:0] data_in,
    output logic [31:0] data_out
);
    logic [31:0] mem [0:1023]; // 4KB data memory

    always @(posedge clk) begin
        if (we) begin
            mem[addr[11:2]] <= data_in;
        end
    end

    assign data_out = mem[addr[11:2]];

endmodule
