module adder #(
    parameter DATA_WIDTH = 32;
    parameter ADDEND = 4;
) (
    input wire [DATA_WIDTH-1:0] in,
    output wire [DATA_WIDTH-1:0] out
);
    assign out = in + ADDEND;
    
endmodule