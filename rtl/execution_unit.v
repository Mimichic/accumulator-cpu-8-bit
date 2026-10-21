module execution_unit (
    input wire clk,
    input wire rst_n,
    input wire run,
    input wire HALT,
    output wire exec,
    output reg halted
);

    assign exec = run & ~halted; //execute next instruction if NOT halted and run is turned high

    always @(posedge clk) begin
        if (!rst_n)
            halted <= 1'b0;
        else if (exec && HALT) //if you were to receive the halt instruction
            halted <= 1'b1; 
    end

endmodule
