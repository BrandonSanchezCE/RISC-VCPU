`timescale 1ns/1ps

module Extend_tb();

    logic [31:0] In;
    logic [2:0]  ImmSrc;
    logic [31:0] ImmExt;

    Extend DUT (
        .In(In),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    initial begin
        ImmSrc = 3'b000;

        In = 32'h0050_0013;
        #5;
        assert (ImmExt == 32'h0000_0005)
            $display("TEST 1A PASSED: SMALL POSITIVE I-TYPE INSTRUCTION");
        else
            $error("TEST 1A FAILED: SMALL POSITIVE I-TYPE INSTRUCTION");

        In = 32'h7FF0_0013;
        #5;
        assert (ImmExt == 32'h0000_07FF)
            $display("TEST 1B PASSED: LARGE POSITIVE I-TYPE INSTRUCTION");
        else
            $error("TEST 1B FAILED: LARGE POSITIVE I-TYPE INSTRUCTION");

        In = 32'hFFF0_0013;
        #5;
        assert (ImmExt == 32'hFFFF_FFFF)
            $display("TEST 1C PASSED: SMALL NEGATIVE I-TYPE INSTRUCTION");
        else
            $error("TEST 1C FAILED: SMALL NEGATIVE I-TYPE INSTRUCTION");

        In = 32'h8000_0013;
        #5;
        assert (ImmExt == 32'hFFFF_F800)
            $display("TEST 1D PASSED: LARGE NEGATIVE I-TYPE INSTRUCTION");
        else
            $error("TEST 1D FAILED: LARGE NEGATIVE I-TYPE INSTRUCTION");

        ImmSrc = 3'b001;

        In = 32'h0000_02A3;
        #5;
        assert (ImmExt == 32'h0000_0005)
            $display("TEST 2A PASSED: SMALL POSITIVE S-TYPE INSTRUCTION");
        else
            $error("TEST 2A FAILED: SMALL POSITIVE S-TYPE INSTRUCTION");

        In = 32'h7E00_0FA3;
        #5;
        assert (ImmExt == 32'h0000_07FF)
            $display("TEST 2B PASSED: LARGE POSITIVE S-TYPE INSTRUCTION");
        else
            $error("TEST 2B FAILED: LARGE POSITIVE S-TYPE INSTRUCTION");

        In = 32'hFE00_0FA3;
        #5;
        assert (ImmExt == 32'hFFFF_FFFF)
            $display("TEST 2C PASSED: SMALL NEGATIVE S-TYPE INSTRUCTION");
        else
            $error("TEST 2C FAILED: SMALL NEGATIVE S-TYPE INSTRUCTION");

        In = 32'h8000_0023;
        #5;
        assert (ImmExt == 32'hFFFF_F800)
            $display("TEST 2D PASSED: LARGE NEGATIVE S-TYPE INSTRUCTION");
        else
            $error("TEST 2D FAILED: LARGE NEGATIVE S-TYPE INSTRUCTION");

        ImmSrc = 3'b010;

        In = 32'h0000_0263;
        #5;
        assert (ImmExt == 32'h0000_0004)
            $display("TEST 3A PASSED: SMALL POSITIVE B-TYPE INSTRUCTION");
        else
            $error("TEST 3A FAILED: SMALL POSITIVE B-TYPE INSTRUCTION");

        In = 32'h7E00_0FE3;
        #5;
        assert (ImmExt == 32'h0000_0FFE)
            $display("TEST 3B PASSED: LARGE POSITIVE B-TYPE INSTRUCTION");
        else
            $error("TEST 3B FAILED: LARGE POSITIVE B-TYPE INSTRUCTION");

        In = 32'hFE00_0FE3;
        #5;
        assert (ImmExt == 32'hFFFF_FFFE)
            $display("TEST 3C PASSED: SMALL NEGATIVE B-TYPE INSTRUCTION");
        else
            $error("TEST 3C FAILED: SMALL NEGATIVE B-TYPE INSTRUCTION");

        In = 32'h8000_0063;
        #5;
        assert (ImmExt == 32'hFFFF_F000)
            $display("TEST 3D PASSED: LARGE NEGATIVE B-TYPE INSTRUCTION");
        else
            $error("TEST 3D FAILED: LARGE NEGATIVE B-TYPE INSTRUCTION");

        ImmSrc = 3'b011;

        In = 32'h0040_00EF;
        #5;
        assert (ImmExt == 32'h0000_0004)
            $display("TEST 4A PASSED: SMALL POSITIVE J-TYPE INSTRUCTION");
        else
            $error("TEST 4A FAILED: SMALL POSITIVE J-TYPE INSTRUCTION");

        In = 32'h7FFF_F0EF;
        #5;
        assert (ImmExt == 32'h000F_FFFE)
            $display("TEST 4B PASSED: LARGE POSITIVE J-TYPE INSTRUCTION");
        else
            $error("TEST 4B FAILED: LARGE POSITIVE J-TYPE INSTRUCTION");

        In = 32'hFFFF_F0EF;
        #5;
        assert (ImmExt == 32'hFFFF_FFFE)
            $display("TEST 4C PASSED: SMALL NEGATIVE J-TYPE INSTRUCTION");
        else
            $error("TEST 4C FAILED: SMALL NEGATIVE J-TYPE INSTRUCTION");

        In = 32'h8000_00EF;
        #5;
        assert (ImmExt == 32'hFFF0_0000)
            $display("TEST 4D PASSED: LARGE NEGATIVE J-TYPE INSTRUCTION");
        else
            $error("TEST 4D FAILED: LARGE NEGATIVE J-TYPE INSTRUCTION");

        ImmSrc = 3'b100;

        In = 32'h0000_1037;
        #5;
        assert (ImmExt == 32'h0000_1000)
            $display("TEST 5A PASSED: SMALL POSITIVE U-TYPE INSTRUCTION");
        else
            $error("TEST 5A FAILED: SMALL POSITIVE U-TYPE INSTRUCTION");

        In = 32'h7FFF_F037;
        #5;
        assert (ImmExt == 32'h7FFF_F000)
            $display("TEST 5B PASSED: LARGE POSITIVE U-TYPE INSTRUCTION");
        else
            $error("TEST 5B FAILED: LARGE POSITIVE U-TYPE INSTRUCTION");

        In = 32'hFFFF_F037;
        #5;
        assert (ImmExt == 32'hFFFF_F000)
            $display("TEST 5C PASSED: SMALL NEGATIVE U-TYPE INSTRUCTION");
        else
            $error("TEST 5C FAILED: SMALL NEGATIVE U-TYPE INSTRUCTION");

        In = 32'h8000_0037;
        #5;
        assert (ImmExt == 32'h8000_0000)
            $display("TEST 5D PASSED: LARGE NEGATIVE U-TYPE INSTRUCTION");
        else
            $error("TEST 5D FAILED: LARGE NEGATIVE U-TYPE INSTRUCTION");

        ImmSrc = 3'b111;
        In = 32'hFFFF_FFFF;
        #5;
        assert (ImmExt == 32'h0000_0000)
            $display("TEST 5E PASSED: UNMENTIONED INSTRUCTION");
        else
            $error("TEST 5E FAILED: UNMENTIONED INSTRUCTION");

        #10;
        $finish;
    end

endmodule