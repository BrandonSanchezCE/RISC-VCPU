module ClockDivider(
    input CLK100MHZ,
    input Reset,
    output reg SlowClock

);

reg[26:0] Counter;

always @(posedge CLK100MHZ or posedge Reset) begin
    if (Reset) begin
        Counter <= 0;
        SlowClock <=0;
    end
    else if (Counter == 27'd50000000) begin //0.5 seconds
        Counter <=0;
        SlowClock <= !SlowClock;
    end
    else
        Counter <= Counter +1;
end

endmodule