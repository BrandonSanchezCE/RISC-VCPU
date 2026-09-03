module DATAM(
    input [31:0] Address,
    input [31:0] WriteData,
    input Clk,
    input [3:0] WriteEnable,
    input [15:0] Switches,
    output reg [15:0] Leds, 
    output reg[31:0] ReadData
);

 reg [31:0] Data[0:255];

 wire [7:0] WordAddress = Address[9:2];
 localparam LedAddress = 32'h00001000;
 localparam SwitchAddress = 32'h00001004;
    always @(posedge Clk) begin
         if(Address == LedAddress) begin
            if (WriteEnable[0]) 
                Leds[7:0] <= WriteData[7:0];
            if (WriteEnable[1])
                Leds[15:8] <= WriteData[15:8];
         end
            else if (Address < 32'd1024) begin
                if (WriteEnable[0])
                 Data[WordAddress][7:0]<= WriteData[7:0];
                if (WriteEnable[1])
                 Data[WordAddress][15:8]<= WriteData[15:8];
                if (WriteEnable[2])
                 Data[WordAddress][23:16]<= WriteData[23:16];
                if (WriteEnable[3])
                 Data[WordAddress][31:24]<= WriteData[31:24];
            end
         end
    always @(*) begin
        if (Address == SwitchAddress)
            ReadData= {16'b0, Switches};
        else if (Address < 32'd1024)
            ReadData = Data[WordAddress];
        else 
            ReadData = 32'b0;
    end
endmodule
