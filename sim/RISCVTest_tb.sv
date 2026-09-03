`timescale 1ns / 1ps

module RISCVTest_tb;

logic clk;
logic rst;

initial begin
clk = 0;
forever #5 clk = ~clk;
end

TopModule dut (

    .CLK100MHZ(clk),
    .Reset(rst)
);

int file_desc;
string current_test;
int passed_count = 0;
int failed_count = 0;
int total_count = 0;

logic [31:0] last_pc;
int unchanged_cycles;
int cycle_count;
localparam int MAX_CYCLES_PER_TEST = 15000;

initial begin
    file_desc = $fopen("test_list.txt", "r");
    if (file_desc == 0) begin
        $display ("\n[FATAL ERROR] Could not open test_list.txt.");
        $display("Make sure test_list.txt is located in your Vivado simulation directory.\n");
        $finish;
    end
$display("==================================================");
$display("       STARTING RISC-V ARCH COMPLIANCE SUITE      ");
$display("==================================================");

while (!$feof(file_desc)) begin
    int scanned;
    scanned = $fscanf(file_desc, "%s\n", current_test);

    if (scanned == 1 && current_test != "") begin
                total_count++;
                $write("[TEST %02d] Running %-18s ... ", total_count, current_test);

        $display("Loading %s", current_test);

        $readmemh(current_test, dut.instance1.instance2.Instruction);

        $display("Instruction[0] = 0x%08h",
         dut.instance1.instance2.Instruction[0]);

        $display("PC before reset = 0x%08h",
         dut.instance1.PC);

        rst = 1;
        repeat (5) @(posedge clk);
        rst = 0;

        $display("PC after reset = 0x%08h",dut.instance1.PC);

                // C. Initialize tracking counters
                unchanged_cycles = 0;
                cycle_count      = 0;
                last_pc          = 32'hFFFF_FFFF;

                // D. Run until test halts (PC freezes) or watchdog triggers
                while (unchanged_cycles < 10 && cycle_count < MAX_CYCLES_PER_TEST) begin
                    @(posedge clk);
                    cycle_count++;
                    $display("Cycle %0d: PC=0x%08h, Instr=0x%08h, x1=0x%08h",
         cycle_count,
         dut.instance1.PC,
         dut.instance1.instance2.Instruction[dut.instance1.PC >> 2],
         dut.instance1.instance3.Register[1]);

                    // >>> ADJUST HIERARCHY PATH TO YOUR PC REGISTER <<<
                    if (dut.instance1.PC == last_pc) begin
                        unchanged_cycles++;
                    end else begin
                        unchanged_cycles = 0;
                        last_pc = dut.instance1.PC;
                    end
                end

                // E. Evaluate test result
                if (cycle_count >= MAX_CYCLES_PER_TEST) begin
                    $display("❌ TIMEOUT (Core looped endlessly without halting)");
                    failed_count++;
                end else begin
                    // >>> ADJUST HIERARCHY PATH TO REGISTER x1 / ra <<<
                    if (dut.instance1.instance3.Register[1] == 32'h1) begin
                        $display("✅ PASSED (%0d cycles)", cycle_count);
                        passed_count++;
                    end else begin
                        $display("❌ FAILED (x1 = 0x%08h)", dut.instance1.instance3.Register[1]);
                        failed_count++;
                    end
                end
            end
        end

        // ---------------------------------------------------------------------
        // 5. Final Summary Banner
        // ---------------------------------------------------------------------
        $display("==================================================");
        $display("                 TEST SUMMARY                     ");
        $display("==================================================");
        $display(" Total Tests Executed : %0d", total_count);
        $display(" Passed               : %0d", passed_count);
        $display(" Failed               : %0d", failed_count);
        if (total_count > 0) begin
            $display(" Success Rate         : %0.1f%%", (passed_count * 100.0) / total_count);
        end
        $display("==================================================");

        $fclose(file_desc);
        $finish;
    end

endmodule

