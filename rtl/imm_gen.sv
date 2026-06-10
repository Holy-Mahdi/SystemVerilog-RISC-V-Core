module imm_gen #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] in,
    input logic [2:0] imm_sel,
    output logic [DATA_WIDTH-1:0] out 
);
    always_comb begin
        case (imm_sel)
            // I-type: bits [31:20]
            3'b000: out = {{20{in[31]}}, in[31:20]};
            
            // S-type: bits [31:25][11:7]
            3'b001: out = {{20{in[31]}}, in[31:25], in[11:7]};
            
            // U-type: bits [31:12] << 12
            3'b010: out = {in[31:12], 12'b0};
            
            // J-type: bits [31][19:12][20][30:21] << 1
            3'b011: out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
            
            // B-type: bits [31][7][30:25][11:8] << 1
            3'b100: out = {{19{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};
            
            default: out = 32'b0;
        endcase
    end
endmodule