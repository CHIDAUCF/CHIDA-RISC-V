// 32-bit single-cycle ALU
// opcodes/funct

module alu_top(
    input[31:0] a, b,
    input[2:0] funct3,
    input[6:0] funct7,
    input[6:0] opcode,
    output zero,            // Zero flag indicating the result is 0
    output [31:0] alu_out    // Ouput of the ALU operation
);

reg[31:0] result, sign_extension;
always @ (*) begin // May change sensitivity list later
    case(funct3)
        // AND
        3'b111:
            result = a & b;
        // OR
        3'b110:
            result = a | b;
        // XOR
        3'b100:
            result = a ^ b;
        // SLTU
        3'b011:    
            result = (a < b) ? 1:0;
        // SLT
        3'b010: begin
            // If one operand is negative and the other positive
            if (a[31] != b[31])
                result = (a[31] > b[31]) ? 1:0;
            else
                result = (a < b) ? 1:0;

            result = (a < b) ? 1:0;
        end
        // SRL and SRA
        3'b101: begin
            if (funct7 == 7'b0000000)
                result = a >> (b);
            else begin
                sign_extension = {{32{a[31]}}, a};
                result = sign_extension >> (b);
            end
        end
        // SLL
        3'b001:
            result = a << (b);
        // ADD and SUB
        3'b000: begin
            if (funct7 == 7'b0000000)
                result = a + b;
            else
                result = a + (~b + 1);
        end
    endcase
end
assign alu_out = result;
assign zero = (result) ? 0:1; // Set zero output to 1 if all alu_out bits are zero
endmodule