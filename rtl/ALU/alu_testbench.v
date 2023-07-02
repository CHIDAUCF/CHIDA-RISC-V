module alu_testbench();

reg [31:0] a, b;
reg [2:0] funct3;
reg [6:0] funct7;
reg [6:0] opcode;

// Outputs
wire zero;
wire[31:0] alu_out;

alu_top dut (
    .a(a),
    .b(b),
    .funct3(funct3),
    .funct7(funct7),
    .opcode(opcode),
    .zero(zero),
    .alu_out(alu_out)
);

initial begin
    // Initialize inputs
    a = {{28{1'b0}}, 4'b0101};
    b = {{28{1'b0}}, 4'b1001};
    funct3 = 3'b011;  // SLTU
    funct7 = 7'b0000000;
    opcode = 7'b0110011;

    // Display input values
    $display("Input a: %b", a);
    $display("Input b: %b", b);

    $display("ALU OUPUT (SLTU): %b", alu_out);
    #10
    
    funct3 = 3'b010;  // SLT
    $display("ALU OUPUT (SLT): %b", alu_out);
    #10
    
    funct3 = 3'b101;  // SRL
    $display("ALU OUPUT (SRL): %b", alu_out);
    #10
    
    funct7 = 7'b0100000; // SRA
    $display("ALU OUPUT (SRA): %b", alu_out);
    #10
    
    funct7 = 7'b0000000;
    funct3 = 3'b001;  // SLL
    $display("ALU OUPUT (SLL): %b", alu_out);
    
    // End simulation
    $finish;
  end
endmodule