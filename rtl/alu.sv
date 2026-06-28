module alu #(
    parameter DATA_WIDTH = 32;
) (
    input logic [DATA_WIDTH-1:0] operand_a,
    input logic [DATA_WIDTH-1:0] operand_b,
    input logic [3:0] alu_control,

    output logic [DATA_WIDTH-1:0] alu_result,
    output logic zero_flag
);
    localparam SHIFT_WIDTH = $clog2(DATA_WIDTH);

    always_comb begin
        alu_result = '0;

        case (alu_control)
            4'b0000: alu_result = operand_a + operand_b;       // ADD / ADDI
            4'b0001: alu_result = operand_a - operand_b;       // SUB (used for branches too)
            4'b0010: alu_result = operand_a & operand_b;       // AND / ANDI
            4'b0011: alu_result = operand_a | operand_b;       // OR / ORI
            4'b0100: alu_result = operand_a ^ operand_b;       // XOR / XORI
            4'b0101: alu_result = operand_a << operand_b[SHIFT_WIDTH-1:0]; // SLL / SLLI
            4'b0110: alu_result = operand_a >> operand_b[SHIFT_WIDTH-1:0]; // SRL / SRLI (Logical Shift Right)
            4'b0111: alu_result = $signed(operand_a) >>> operand_b[SHIFT_WIDTH-1:0]; // SRA / SRAI (Arithmetic Shift Right)
            4'b1000: alu_result = ($signed(operand_a) < $signed(operand_b)) ? {{DATA_WIDTH-1{1'b0}}, 1'b1} : '0; // SLT
            4'b1001: alu_result = (operand_a < operand_b) ? {{DATA_WIDTH-1{1'b0}}, 1'b1} : '0;                   // SLTU
            default: alu_result = '0;                     // Default
        endcase

        zero_flag = (alu_result == '0) ? 1'b1 : 1'b0;
    end

endmodule
