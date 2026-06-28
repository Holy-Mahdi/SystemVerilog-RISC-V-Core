module mux #(
    parameter NUM_INPUT = 4;
    parameter DATA_WIDTH = 32;
) (
    input wire [NUM_INPUT-1:0][DATA_WIDTH-1:0] in,
    input wire [$clog2(NUM_INPUT)-1:0] sel,
    output wire [DATA_WIDTH-1:0] out
);
    assign out = in[sel];

endmodule
