import os
import glob
import subprocess

Verilog_Files = [
    "../ALU.v",
    "../BranchingCompare.v",
    "../ControlUnit.v",
    "../DataPath.v",
    "../DATAM.v",
    "../Extend.v",
    "../INSTRM.v",
    "../Load.v",
    "../MainDecoder.v",
    "../PC.v",
    "../RegFile.v",
    "../Store.v",
    "../TopModule.v",
    "RISCVTest_tb.v"
]

TEST_TIMEOUT_SECONDS = 30  # per-test wall-clock cap; raise if long tests legitimately need more

passed_count = 0
failed_count = 0
timeout_count = 0

compileCommand = ["iverilog", "-o", "sim.vvp"] + Verilog_Files
compileResult = subprocess.run(compileCommand, capture_output=True, text=True)

if compileResult.returncode != 0:
    print("Error!")
    print(compileResult.stderr)
    exit(1)

test_files = glob.glob("hextests/*.hex")

if not test_files:
    print("No .hex files found in 'hextests/'. Did the compile step run first?")
    exit(1)

for test_path in sorted(test_files):
    test_name = os.path.basename(test_path)

    with open(test_path, "r") as src, open("test.hex", "w") as dst:
        dst.write(src.read())

    try:
        run_result = subprocess.run(
            ["vvp", "sim.vvp"],
            capture_output=True,
            text=True,
            timeout=TEST_TIMEOUT_SECONDS,
        )
        output = run_result.stdout
    except subprocess.TimeoutExpired:
        print(f"[TIMEOUT] {test_name} (no RESULT within {TEST_TIMEOUT_SECONDS}s -- "
              f"testbench likely never saw the tohost write)")
        timeout_count += 1
        continue

    if "RESULT: PASSED" in output:
        print(f"[PASS] {test_name}")
        passed_count += 1
    else:
        print(f"[FAIL] {test_name}")
        for line in output.splitlines():
            if "RESULT: FAILED" in line:
                print(f"       ->{line}")
        failed_count += 1

print("=" * 45)
print(f"Results: {passed_count} Passed, {failed_count} Failed, {timeout_count} Timed out.")
