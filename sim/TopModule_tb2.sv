module TopModule_tb2();
logic Clk, Reset;
TopModule_tb2 dut(
    .Clk(Clk),
    .Reset(Reset)
);
initial Clk = 0;
always #5 Clk = ~Clk;

initial

Reset = 1;

@(posedge Clk);
endmodule