module branch_logic (
    input logic [31:0] data1,
    input logic [31:0] data2,
    input logic [2:0] br_type,
    output logic pc_sel
);

    always_comb begin
        case (br_type)
            3'b000: pc_sel = 1'b0; // No branch
            3'b001: pc_sel = (data1 == data2); // BEQ
            3'b010: pc_sel = (data1 != data2); // BNE
            3'b011: pc_sel = ($signed(data1) < $signed(data2)); // BLT
            3'b100: pc_sel = ($signed(data1) >= $signed(data2)); // BGE
            3'b101: pc_sel = (data1 < data2); // BLTU
            3'b110: pc_sel = (data1 >= data2); // BGEU
            default: pc_sel = 1'b0; // Default case
        endcase
    end

endmodule
