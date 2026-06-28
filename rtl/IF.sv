module if_stage #(
    parameter DATA_WIDTH = 32;
) (
    input logic clk,
    input logic rst_n,
    input logic [DATA_WIDTH-1:0] pc_branch,    // Branch/Jump target address
    input logic pc_sel,                         // PC select: 1=branch, 0=PC+4
    
    output logic [DATA_WIDTH-1:0] pc_out,       // Current PC to ID stage
    output logic [DATA_WIDTH-1:0] instruction   // Fetched instruction
);

    // Internal signals
    logic [DATA_WIDTH-1:0] pc_plus4;            
    logic [DATA_WIDTH-1:0] pc_next;             
    logic [DATA_WIDTH-1:0] pc_current;          
    logic [DATA_WIDTH-1:0] instruction_raw;     // Raw instruction from memory
    
    // MUX inputs for PC selection
    logic [1:0][DATA_WIDTH-1:0] mux_in;
    
    // Instantiate adder for PC+4
    adder #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDEND(4)
    ) u_adder (
        .in(pc_current),
        .out(pc_plus4)
    );
    
    // Prepare MUX inputs
    assign mux_in[0] = pc_plus4;     // Normal execution: PC + 4
    assign mux_in[1] = pc_branch;    // Branch/Jump: target address
    
    // Instantiate MUX for PC selection
    mux #(
        .NUM_INPUT(2),
        .DATA_WIDTH(DATA_WIDTH)
    ) u_mux_pc (
        .in(mux_in),
        .sel(pc_sel),
        .out(pc_next)
    );
    
    // Instantiate PC register
    pc u_pc_reg (
        .clk(clk),
        .rst_n(rst_n),
        .pc_in(pc_next),
        .pc_out(pc_current)
    );
    
    // Instantiate Instruction Memory
    imem u_imem (
        .addr(pc_current),
        .inst(instruction_raw)
    );
    
    // Register the instruction output to avoid timing issues
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            instruction <= 32'b0;
        end else begin
            instruction <= instruction_raw;
        end
    end
    
    // Output current PC
    assign pc_out = pc_current;

endmodule