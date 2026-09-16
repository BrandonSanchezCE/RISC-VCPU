`timescale 1ns/1ps
`include "CPU_Types.sv"

module EX_MEM_Register_tb;
    
    
    logic Clk;
    logic RegWriteE;
    logic Reset;
    logic MemWriteE;   
    logic [1:0] ResultSrcE;
    logic [4:0] ReadDestinationE;
    logic [31:0] ALUResultE;
    logic [31:0] WriteDataE;
    logic [31:0] PCPlus4E;
    
    EX_MEM EX_MEM_OUT;

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; 
    end

    EX_MEM_Register dut(
        .Clk(Clk),
        .RegWriteE(RegWriteE),
        .Reset(Reset),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .ReadDestinationE(ReadDestinationE),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCPlus4E(PCPlus4E),
        .EX_MEM_OUT(EX_MEM_OUT)
    );

    initial begin
        
        Reset = 1;

        RegWriteE = 0;
        MemWriteE = 0;
        ResultSrcE = 0;
        ReadDestinationE = 0;
        ALUResultE = 0;
        WriteDataE = 0;
        @(posedge Clk);
        #1;
        assert (
            EX_MEM_OUT.RegWriteE == 0 &&
            EX_MEM_OUT.MemWriteE == 0 &&
            EX_MEM_OUT.ResultSrcE == 0 &&
            EX_MEM_OUT.ReadDestinationE == 0 &&
            EX_MEM_OUT.ALUResultE == 0 &&
            EX_MEM_OUT.WriteDataE == 0
        )
            $display ("TEST 1 PASS: Reset");
        else 
            $error ("TEST 1 FAILED: Reset did not clear outputs");
        
        $display("TEST 1 FINISHED: Reset");

        Reset = 0;

        RegWriteE = 1;
        MemWriteE = 1;
        ResultSrcE = 2'b10;
        ReadDestinationE = 5'b01010;
        ALUResultE = 32'hAAAAAAAA;
        WriteDataE = 32'h01010101;

        @(posedge Clk);
        #1;

        assert(
            EX_MEM_OUT.RegWriteE == RegWriteE &&
            EX_MEM_OUT.MemWriteE == MemWriteE &&
            EX_MEM_OUT.ResultSrcE == ResultSrcE &&
            EX_MEM_OUT.ReadDestinationE == ReadDestinationE &&
            EX_MEM_OUT.ALUResultE == ALUResultE &&
            EX_MEM_OUT.WriteDataE == WriteDataE            
        )
            $display ("TEST 2 PASSED: Normal capture");
        else begin
            $error("TEST 2 FAILED: Outputs did not capture inputs");
        end

        Reset = 0;

        RegWriteE = 0;
        MemWriteE = 0;
        ResultSrcE = 2'b11;
        ReadDestinationE = 5'b01110;
        ALUResultE = 32'hAAAAAABA;
        WriteDataE = 32'h010101A1;
        @(posedge Clk);
        #1
        assert(
            EX_MEM_OUT.RegWriteE == RegWriteE &&
            EX_MEM_OUT.MemWriteE == MemWriteE &&
            EX_MEM_OUT.ResultSrcE == ResultSrcE &&
            EX_MEM_OUT.ReadDestinationE == ReadDestinationE &&
            EX_MEM_OUT.ALUResultE == ALUResultE &&
            EX_MEM_OUT.WriteDataE == WriteDataE            
        )
            $display ("TEST 3 PASSED: New values captured");
        else 
            $error("TEST 3 FAILED: Outputs did not update correctly");

        Reset = 1;
        @(posedge Clk);
        #1

        assert (
            EX_MEM_OUT.RegWriteE == 0 &&
            EX_MEM_OUT.MemWriteE == 0 &&
            EX_MEM_OUT.ResultSrcE == 0 &&
            EX_MEM_OUT.ReadDestinationE == 0 &&
            EX_MEM_OUT.ALUResultE == 0 &&
            EX_MEM_OUT.WriteDataE == 0
        )
            $display("TEST 4 PASSED: Reset again");
        else
            $error("TEST 4 PASSED: Reset did not clear outputs");
        
        $display ("=============================");
        $display("ALL TESTS Finished");
        $display ("=============================");


        

    end
endmodule