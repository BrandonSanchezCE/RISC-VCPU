`timescale 1ns/1ps
module RegFile_tb();

logic [4:0] Address1;
logic [4:0] Address2;
logic [4:0] Address3;
logic [31:0] WriteData3;
logic Clk;
logic WriteEnable3;
logic [31:0] ReadData1;
logic [31:0] ReadData2;


RegFile DUT( 
    .Address1(Address1),
    .Address2(Address2),
    .Address3(Address3),
    .WriteData3(WriteData3),
    .Clk(Clk),
    .WriteEnable3(WriteEnable3),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

initial begin
Clk = 0;    
forever #5 Clk = ~Clk;

end

initial begin
DUT.Register[0] = 0;
Address1 = 0;
Address2 = 0;
Address3 = 0;
WriteData3 = 0;
WriteEnable3 = 0;

#5;

assert(
    ReadData1 == 0 &&
    ReadData2 == 0
)

$display("TEST 1 PASSED: INITIALLY ZERO");

else 
    $error("TEST 1 FAILED: INITIALLY ZERO");

#5;

Address1 = 5'd5;
Address2 = 0;
Address3 = 0;
WriteData3 = 0;
WriteEnable3 = 0;

DUT.Register[5] = 32'd20;

#5;

assert(
    ReadData1 == 20 &&
    ReadData2 == 0
)

$display("TEST 2 PASSED: READ ADDRESS1");

else
    $error("TEST 2 FAILED: READ ADDRESS1");

#5;

Address1 = 5'd5;
Address2 = 5'd5;
Address3 = 0;
WriteData3 = 0;
WriteEnable3 = 0;

#5;

assert(
    ReadData1 == 32'd20 &&
    ReadData2 == 32'd20
)


$display("TEST 3 PASSED: READ ADDRESS2");

else
    $error("TEST 3 FAILED: READ ADDRESS2");

#5;

Address1 = 5'd5;
Address2 = 5'd5;
Address3 = 5'd5;
WriteData3 = 32'd75;
WriteEnable3 = 1;

#5;

assert(
    ReadData1 == 32'd75 &&
    ReadData2 == 32'd75
)

$display("TEST 4 PASSED: WRITE INTO ADDRESS3");

else
    $error("TEST 4 FAILED: WRITE INTO ADDRESS3");

#5;

Address1 = 0;
Address2 = 5'd5;
Address3 = 0;
WriteData3 = 32'd75;
WriteEnable3 = 1;

#5;

assert(
    ReadData1 == 0 &&
    ReadData2 == 32'd75
)

$display("TEST 5a PASSED: ATTEMPT TO WRITE INTO REGISTER 0");

else
    $error("TEST 5a FAILED: ATTEMPT TO WRITE INTO REGISTER 0");

#5;

Address1 = 5'd5;
Address2 = 0;
Address3 = 0;
WriteData3 = 32'd75;
WriteEnable3 = 1;

#5

assert(
    ReadData1 == 32'd75 &&
    ReadData2 == 0
)

$display("TEST 5b PASSED: ATTEMPT TO WRITE INTO REGISTER 0");

else
    $error("TEST 5b FAILED: ATTEMPT TO WRITE INTO REGISTER 0");


$finish;
end

endmodule

