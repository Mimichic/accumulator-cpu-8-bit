module alu(
    input wire clk,
    input [2:0] op,
    input [4:0] imm,
    input [7:0] acc, 
    input [7:0] ram_data, //dependent on the value of imm value
    output reg [7:0] alu_out, 
    output zero_flag
);

    wire [7:0] operand;

    assign operand = (imm[4]==1) ? {4'b0000,imm[3:0]} : ram_data; //if the value of immediate is equal to one, selected value is extended, if the condition is false, ram_data is chosen 

    always @(*) begin
        case (op)
            3'b000: alu_out = operand; //load operation
            3'b001: alu_out = acc + operand;
            3'b010: alu_out = acc - operand;
            3'b011: alu_out = acc & operand;
            3'b100: alu_out = acc | operand;
            default: alu_out = acc;
        endcase
    end

    assign zero_flag = (alu_out == 8'h00);

endmodule