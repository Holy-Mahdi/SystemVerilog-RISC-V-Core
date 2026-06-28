module register_file #(
    parameter DATA_WIDTH = 32;
) (
    input logic clk,
    input logic resN,
    input logic write_en,
    input logic [4:0] addr1,
    input logic [4:0] addr2,
    input logic [4:0] write_addr,
    input logic [DATA_WIDTH-1:0] write_data,

    output logic [DATA_WIDTH-1:0] read_data1,
    output logic [DATA_WIDTH-1:0] read_data2

);
    logic [DATA_WIDTH-1:0] registers [0:31];

    always @(posedge clk or negedge resN) begin
        if(!resN) begin
            for(int i = 0; i < 32; i++) begin
                registers[i] <= 0;
            end
        end else if (write_en && write_addr != 5'b0) begin
            registers[write_addr] <= write_data;
        end
    end
    assign read_data1 = registers[addr1];
    assign read_data2 = registers[addr2];

endmodule
