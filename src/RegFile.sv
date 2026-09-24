module RegFile(
    input [4:0]Address1,
    input [4:0]Address2,
    input [4:0]Address3,
    input [31:0] WriteData3,
    input Clk,
    input WriteEnable3,
    output reg [31:0]ReadData1,
    output reg [31:0]ReadData2

);

reg [31:0] Register[0:31];
    always @(posedge Clk) begin
        if (WriteEnable3 & (Address3 != 0))
            Register[Address3] <= WriteData3;
    end
    always @(*) begin
        if ((Address1 == 0) & (Address2 == 0)) begin
            ReadData1 = 0;
            ReadData2 = 0;
          end
        else if ((Address1 == 0) | (Address2 == 0)) begin
            if (Address1 == 0) begin
                ReadData1 = 0;
                ReadData2 = Register[Address2];
              end
            else begin
                ReadData1 = Register[Address1];
                ReadData2 = 0;
              end
        end
         else  begin
      ReadData1 = Register[Address1];
      ReadData2 = Register [Address2];
        end
    end

endmodule
