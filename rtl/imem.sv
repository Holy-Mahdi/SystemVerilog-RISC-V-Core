module imem (
    input logic [31:0] addr,
    output logic [31:0] inst
);
    logic [31:0] mem [0:1023]; // 4KB instruction memory

    initial begin
        $readmemh("imem.hex", mem); // Load instructions from a hex file
    end

    assign inst = mem[addr[11:2]];
    
endmodule