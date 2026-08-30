module DATAM(
    input [31:0] Address,
    input [31:0] WriteData,
    input Clk,
    input WriteEnable,
    input [15:0] Switches,
    output reg [15:0] Leds, 
    output reg[31:0] ReadData
);

 reg [31:0] Data[0:255];

    always @(posedge Clk) begin
         if(WriteEnable) begin
            if (Address == 32'h00001000) 
                Leds <= WriteData[15:0];
            else if (Address < 32'd1024)
                 Data[Address[31:2]]<= WriteData;
         end
    end
    always @(*) begin
        if (Address !== 32'h00001004)
            ReadData = Data[Address[31:2]];
        else
            ReadData= {16'b0, Switches};
    end
endmodule
