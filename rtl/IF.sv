module if #(
    parameter DATA_WIDTH = 32;
) (
    input logic clk,
    input logic rst_n,
    input logic [DATA_WIDTH-1:0] pc_in,
    input logic pc_sel,

    output logic [DATA_WIDTH-1:0] pc_out,
    output logic [DATA_WIDTH-1:0] instruction
);
    logic [DATA_WIDTH-1:0] pc_plus4;
    logic [DATA_WIDTH-1:0] pc_next;
    logic [DATA_WIDTH-1:0] pc_current;


    logic [1:0][DATA_WIDTH-1:0] mux_in;

    adder #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDEND(4)
    ) u_adder (
        .in(pc_current),
        .out(pc_plus4)
    );

    assign mux_in[0] = pc_plus4;
    assign mux_in[1] = pc_branch;

    mux #(
        .NUM_INPUT(2),
        .DATA_WIDTH(DATA_WIDTH)
    ) u_mux (
        .in(mux_in),
        .sel(pc_sel),
        .out(pc_next)
    );

    pc u_pc (
        .clk(clk),
        .rst_n(rst_n),
        .pc_in(pc_next),
        .pc_out(pc_current)
    );
    
    imem u_imem (
        .addr(pc_current),
        .inst(instruction)
    );

    assign pc_out = pc_current;

endmodule

